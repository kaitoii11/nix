{
  description = "Kaito's Home Manager configuration for multiple Linux VMs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      username = "kaito";

      # ホスト用の Home Manager 構成を作るヘルパー
      mkHome =
        {
          system ? "x86_64-linux",
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          extraSpecialArgs = { inherit username; };
          modules = [ ./home/common.nix ] ++ modules;
        };
    in
    {
      # キーは "ユーザー名@ホスト名"。`home-manager switch --flake .` で自動選択される
      homeConfigurations = {
        "${username}@vm-dev" = mkHome {
          modules = [
            ./home/dev.nix
            ./hosts/vm-dev.nix
          ];
        };

        "${username}@vm-bastion" = mkHome {
          modules = [ ./hosts/vm-bastion.nix ];
        };

        # ARM の VM を足す場合の例
        # "${username}@vm-arm" = mkHome {
        #   system = "aarch64-linux";
        #   modules = [ ./hosts/vm-arm.nix ];
        # };
      };
    };
}
