#!/bin/sh
echo -ne '\033c\033]0;Prog Avancee\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Prog Avancee_gardanne_ben_salah_boulay_micoulet.x86_64" "$@"
