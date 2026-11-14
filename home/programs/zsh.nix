{ ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 100000;
      save = 100000;
      ignoreDups = true;
      ignoreAllDups = true;
      share = true;
      extended = true;
    };
    shellAliases = {
      ll = "eza -l --git";
      la = "eza -la --git";
      hms = "home-manager switch --flake ~/dotfiles";
      ls = "ls -F --color=auto";
      grep = "grep --color=always";
      diff = "diff -u";
    };
    # kaitoii11/dotfiles の .zshrc / .zshaliases から移植（zprezto/macports/peco 等は除外）
    initContent = ''
      if command -v colordiff >/dev/null 2>&1; then
        alias diff='colordiff -u'
      fi
      if [ -e /usr/bin/xsel ]; then
        alias pbcopy='xsel --clipboard --input'
        alias pbpaste='xsel --clipboard --output'
        alias tmux-copy='tmux save-buffer - | pbcopy'
      fi

      setopt AUTOCD
      setopt EXTENDED_GLOB
      setopt HIST_REDUCE_BLANKS
      setopt HIST_IGNORE_SPACE
      setopt NOTIFY
      setopt NO_CORRECT
      setopt NO_CORRECT_ALL
      setopt NOCLOBBER

      autoload -U history-search-end
      zle -N history-beginning-search-backward-end history-search-end
      zle -N history-beginning-search-forward-end history-search-end
      bindkey "^P" history-beginning-search-backward-end
      bindkey "^N" history-beginning-search-forward-end
    '';
  };

  programs.starship.enable = true;
}
