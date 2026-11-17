# WSL (Windows Subsystem for Linux) 固有の設定
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wslu
    kubectl
    openshift
    oc
    jq
    ripgrep
    git
    neovim
    tmux
  ];
}
