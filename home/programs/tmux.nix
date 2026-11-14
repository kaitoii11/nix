{ pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    mouse = true;
    keyMode = "vi";
    historyLimit = 50000;
    escapeTime = 0;
    terminal = "tmux-256color";
    baseIndex = 1;
    # tpm は使わず home-manager 管理（Nix）のプラグインに置き換え
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
      resurrect
    ];
    # kaitoii11/dotfiles の .tmux.conf から移植（macOS/tpm プラグイン等は除外）
    extraConfig = ''
      set-option -g status-position top
      set-option -g status-left-length 90
      set-option -g status-right-length 90
      set-option -g status-interval 1
      set-option -g status-justify centre

      setw -g pane-base-index 1

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      bind-key v split-window -h -c '#{pane_current_path}'
      bind-key b split-window -c '#{pane_current_path}'

      set-window-option -g automatic-rename
      set-option -g renumber-windows on

      setw -g monitor-activity on
      set -g visual-activity on

      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Reload Config!!"
    '';
  };
}
