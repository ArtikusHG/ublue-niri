#!/usr/bin/env bash
set -euo pipefail

get_json_array PACKAGES 'try .["packages"][]' "$1"

default_regex='^https://(?!.*musl)(?=.*(x86_64|amd64))(?=.*linux).*\.((tar(\.(gz|xz|bz2))?)|tgz|txz|zip|gz|xz|bz2)$'

for package in "${PACKAGES[@]}"; do
    repo=$(jq -r '.repo' <<< "$package")
    regex=$(jq -r --arg default "$default_regex" '.regex // $default' <<< "$package")
    release_regex=$(jq -r '.["release-regex"] // empty' <<< "$package")
    type=$(jq -r '.type' <<< "$package")
    files=$(jq -r '.files // empty | .[]' <<< "$package")
	postinstall=$(jq -r '.postinstall // empty' <<< "$package")

    echo -e "\033[32mInstalling $repo...\033[0m"

	if [[ -n "$release_regex" ]]; then
		data="$(curl -s "https://api.github.com/repos/$repo/releases" | jq -c --arg regex "$release_regex" 'first(.[] | select(.name | test($regex)))')"
	else
		data="$(curl -s "https://api.github.com/repos/$repo/releases/latest")"
	fi
	
	url="$(echo "$data" | jq -r '.assets[].browser_download_url' | grep -P "$regex" | head -n1)"
    file="${url##*/}"
    curl -LO "$url"

    mkdir gittmp
    7z x "$file" -o"gittmp"
	tarfile=$(find gittmp -maxdepth 1 -name '*.tar' -print -quit)
	if [[ -n "$tarfile" ]]; then
		tar -xf "$tarfile" -C gittmp
		dirs=(gittmp/*/)
		if [ "${#dirs[@]}" -eq 1 ] && [ -d "${dirs[0]}" ]; then
    		mv "${dirs[0]}"* gittmp/
    		rm -rf "${dirs[0]}"
		fi
		rm "$tarfile"
	else
        echo -e "\033[38;5;208mNo tar files found, assuming zip or single binary!\033[0m"
	fi

    if [[ -n "$files" ]]; then
        for filename in $files; do
            find "gittmp" -type f -name "$filename" -exec install -m 755 {} /usr/bin \;
        done
	elif [[ "$type" == "share" ]]; then
	    folder=$(jq -r '.folder' <<< "$package")
		mkdir /usr/share/$folder
		cp -r gittmp/* /usr/share/$folder
    elif [[ "$type" != "custom" ]]; then
        find "gittmp" -type f -exec sh -c '
            for file do
                if file "$file" | grep -q "ELF.*executable"; then
					echo "$file"
                    install -m 755 "$file" /usr/bin
		fi
            done
        ' sh {} +
    fi

    if [[ -n "$postinstall" ]]; then
        echo -e "\033[38;5;208mRunning postinstall...\033[0m"
        bash -c "$postinstall"
    fi

    rm -rf gittmp
	echo "$file $(echo "$data" | jq -r '.tag_name')" >> /etc/git-versions
    rm $file

    echo -e "\033[32mSuccessfully installed $repo!\033[0m"

done
