!/usr/bin/env bash
set -euo pipefail

get_json_array PACKAGES 'try .["packages"][]' "$1"
echo "${PACKAGES[@]}"
