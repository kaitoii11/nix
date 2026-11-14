# 全 VM 共通の設定
{ pkgs, username, ... }:
{
  imports = [
    ./programs/git.nix
    ./programs/bash.nix
    ./programs/zsh.nix
    ./programs/tmux.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # 初回適用時の値から変更しないこと
  home.stateVersion = "26.05";

  # Nix 以外の Linux（Ubuntu など）で動かすための設定
  targets.genericLinux.enable = true;

  home.packages = with pkgs; [
    # 基本 CLI
    ripgrep
    fd
    jq
    yq-go
    bat
    eza
    htop
    curl
    wget
    unzip
    tree
    ghq
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  # 既存 dotfiles をそのまま置く場合の例（./files に配置）
  # home.file.".vimrc".source = ./files/.vimrc;
  # xdg.configFile."nvim".source = ./files/nvim;

  programs.home-manager.enable = true;
  programs.fzf.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
