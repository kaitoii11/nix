# vm-bastion 固有の設定（最小構成）
{ pkgs, ... }:
{
  home.packages = with pkgs; [
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
