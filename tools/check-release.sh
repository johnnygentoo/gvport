#!/usr/bin/env bash
# check-release.sh [PATH...]: fails if what would be published holds game files, saves, keys or
# personal details. With no PATH: this repository's tracked files and every path in its history.
# A PATH is a folder or an AppImage (listed with unsquashfs) to check before uploading it.
#   bash tools/check-release.sh                       # before pushing
#   bash tools/check-release.sh dist/*.AppImage       # before publishing a release
# See LEGAL.md: none of the game, its update, DLC, saves or console keys is ever distributed.
set -euo pipefail
cd -- "$(dirname -- "$0")/.."

# Game dumps and files from them, console data, saves, keys.
forbidden='(^|/)(eboot\.bin|param\.sfo|sce_sys|sce_module|savedata|user|user-p2|addcont|CUSA[0-9]{5}[^/]*)(/|$)|\.(pkg|sprx|prx|self|trp|at9|nus3audio|nus3bank|sav|key|pem)$|(^|/)\.env(\.|$)'

status=0
report() { echo "NOT RELEASABLE: $1" >&2; status=1; }

check_paths() { # stdin: paths; $1: where they come from
    local hits
    hits=$(grep -E "$forbidden" || true)
    if [[ -n $hits ]]; then
        report "$1 contains game, save or key files:"
        echo "$hits" | head -40 | sed 's/^/    /' >&2
    fi
}

if (( $# == 0 )); then
    # Input by redirection, not a pipe: check_paths must run in this shell to set the status.
    check_paths "the tracked files" < <(git ls-files)
    check_paths "the git history" < <(git log --all --diff-filter=A --name-only --format= | sort -u)
    # Large binaries do not belong in the source: game data usually is.
    big=$(git ls-files -z | xargs -0 -r stat -c '%s %n' 2>/dev/null | awk '$1 > 5000000 {print}' |
        grep -Ev ' gpu/third_party/' || true)
    [[ -z $big ]] || { report "tracked files over 5 MB (game data?):"; echo "$big" | sed 's/^/    /' >&2; }
    # Personal details and secrets in the tracked text.
    secrets=$(git grep -nIE 'AIza[0-9A-Za-z_-]{30,}|ghp_[A-Za-z0-9]{30,}|sk-[A-Za-z0-9]{30,}|BEGIN [A-Z ]*PRIVATE KEY|192\.168\.1\.[0-9]+|/home/[a-z][a-z0-9_-]*/' -- . ':!tools/check-release.sh' || true)
    [[ -z $secrets ]] || { report "keys, LAN addresses or home paths in tracked files:"; echo "$secrets" | head -20 | sed 's/^/    /' >&2; }
else
    for target in "$@"; do
        if [[ -d $target ]]; then
            # An AppImage's own .env (sharun's runtime variables, each a path under SHARUN_DIR) is
            # part of the package; any other .env is not.
            sharun_env=
            if [[ -f $target/.env ]] && ! grep -qvE '^[A-Z_]+=[^=]*\$\{SHARUN_DIR\}' "$target/.env"; then
                sharun_env=.env
            fi
            check_paths "$target" < <(cd "$target" && find . -mindepth 1 | sed 's|^\./||' |
                grep -vxF "${sharun_env:-/}")
        elif [[ -f $target && $target == *.AppImage ]]; then
            command -v unsquashfs >/dev/null || { report "unsquashfs (squashfs-tools) is needed to list $target"; continue; }
            # The AppImage's squashfs starts at the end of its ELF runtime.
            offset=$(python3 -I - "$target" <<'EOF'
import struct, sys
with open(sys.argv[1], 'rb') as f:
    head = f.read(64)
    shoff, = struct.unpack_from('<Q', head, 0x28)
    shentsize, shnum = struct.unpack_from('<HH', head, 0x3a)
    print(shoff + shentsize * shnum)
EOF
)
            check_paths "$target" < <(unsquashfs -o "$offset" -l -d '' "$target" 2>/dev/null |
                sed 's|^/||' | grep -v '^$')
        else
            report "$target is neither a folder nor an AppImage"
        fi
    done
fi

if (( status == 0 )); then
    echo "check-release: nothing that must not be distributed was found"
fi
exit "$status"
