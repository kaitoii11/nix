# kaitoii11/dotfiles の .bashrc / .bash_profile から移植（macOS/macports 固有部分は除外）
{ ... }:
{
  programs.bash = {
    enable = true;
    historyControl = [ "ignoredups" "erasedups" ];
    historyFileSize = 100000;
    historySize = 100000;
    shellOptions = [
      "histappend"
      "checkwinsize"
    ];
    shellAliases = {
      ls = "ls -F --color=auto";
      grep = "grep --color=always";
      diff = "diff -u";
    };
    initExtra = ''
      if command -v colordiff >/dev/null 2>&1; then
        alias diff='colordiff -u'
      fi
      if [ -e /usr/bin/xsel ]; then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
        alias tmux-copy='tmux save-buffer - | pbcopy'
      fi
    '';
  };
}
