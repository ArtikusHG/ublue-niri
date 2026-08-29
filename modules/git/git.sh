#!/usr/bin/env bash
set -euo pipefail

get_json_array PACKAGES 'try .["packages"][]' "$1"

default_regex='^https://(?!.*musl)(?=.*(x86_64|amd64))(?=.*linux).*\.((tar(\.(gz|xz|bz2))?)|tgz|txz|zip|gz|xz|bz2)$'

for package in "${PACKAGES[@]}"; do
    repo=$(jq -r '.repo' <<< "$package")
    regex=$(jq -r --arg default "$default_regex" '.regex // $default' <<< "$package")
    type=$(jq -r '.type' <<< "$package")
    files=$(jq -r '.files // empty | .[]' <<< "$package")
    postinstall=$(jq -r '.postinstall // empty' <<< "$package")

    echo -e "\033[32mInstalling $repo...\033[0m"
    url="$(curl -s "https://api.github.com/repos/$repo/releases/latest" | jq -r '.assets[].browser_download_url' | grep -P "$regex" | head -n1)"
    file="${url##*/}"
    curl -LO "$url"

    mkdir gittmp
    7z x "$file" -o"gittmp"
    tar -xf gittmp/*.tar -C gittmp

    if [[ -n "$files" ]]; then
        for filename in $files; do
            find "gittmp" -type f -name "$filename" -exec install -m 755 {} /usr/bin \;
        done
    elif [[ "$type" != "custom" ]]; then
        find "gittmp" -type f -exec sh -c '
            for file do
                if file "$file" | grep -q "ELF.*executable"; then
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
    echo $file >> /etc/git-versions
    rm $file

    echo -e "\033[32mSuccessfully installed $repo!\033[0m"

done
