#!/usr/bin/env bash
# 既存の Ubuntu VM からパッケージと dotfiles を棚卸しする
# 使い方: ./scripts/inventory.sh [出力先ディレクトリ]
set -euo pipefail

OUT="${1:-./inventory/$(hostname)}"
mkdir -p "$OUT/dotfiles"

echo ">> packages"
apt-mark showmanual | sort > "$OUT/apt-manual.txt" || true
zgrep -h "Commandline: apt" /var/log/apt/history.log* 2>/dev/null \
  | grep -E " install " | sed 's/Commandline: //' > "$OUT/apt-history.txt" || true
command -v snap >/dev/null && snap list > "$OUT/snap.txt" || true
command -v pip  >/dev/null && pip list --user 2>/dev/null > "$OUT/pip-user.txt" || true
command -v npm  >/dev/null && npm ls -g --depth=0 2>/dev/null > "$OUT/npm-global.txt" || true
ls -1 ~/.local/bin /usr/local/bin 2>/dev/null > "$OUT/manual-bin.txt" || true

echo ">> frequently used commands"
HISTFILES=(~/.zsh_history ~/.bash_history)
cat "${HISTFILES[@]}" 2>/dev/null \
  | sed 's/^: [0-9]*:[0-9]*;//' | awk '{print $1}' \
  | sort | uniq -c | sort -rn | head -100 > "$OUT/top-commands.txt" || true

echo ">> dotfiles (secrets are excluded)"
for f in .zshrc .bashrc .gitconfig .vimrc .tmux.conf .inputrc; do
  [ -f "$HOME/$f" ] && cp "$HOME/$f" "$OUT/dotfiles/" || true
done
for d in nvim k9s starship.toml alacritty; do
  [ -e "$HOME/.config/$d" ] && cp -r "$HOME/.config/$d" "$OUT/dotfiles/" || true
done

# ~/.ssh, ~/.kube/config, ~/.aws, .env などは意図的に対象外
echo ">> done: $OUT"
