# 開発・クラスタ操作用ロール
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kubectl
    kubernetes-helm
    k9s
    kustomize
    argocd
    tektoncd-cli
    openshift # oc
    rosa
    awscli2
    terraform
    gh
  ];

  programs.zsh.shellAliases = {
    k = "kubectl";
  };
}
