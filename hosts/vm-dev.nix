# vm-dev 固有の設定
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    go
    nodejs
    python3
    rustc
    cargo
  ];
}
