{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    flake-utils.url = "github:numtide/flake-utils";
    srvos.url = "github:numtide/srvos";
    srvos.inputs.nixpkgs.follows = "nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        legacyPackages.nixosConfigurations = {
          contabo-cloud = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; diskDevice = "/dev/sda"; };
            modules = [ ./hosts/contabo-cloud ];
          };

          digital-ocean-cloud = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; diskDevice = "/dev/vda"; };
            modules = [ ./hosts/digital-ocean-cloud ];
          };

          # has to be installed from official AMI manually
          # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/virtualisation/amazon-ec2-amis.nix
          # "23.05".ap-northeast-1.x86_64-linux.hvm-ebs = "ami-0e37827874573dbbf";
          # "23.05".ap-northeast-1.aarch64-linux.hvm-ebs = "ami-09418b2049c3c9533";
          ec2 = nixpkgs.lib.nixosSystem {
            inherit system;
            specialArgs = { inherit inputs; };
            modules = [ ./hosts/ec2 ];
          };
        };

        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            just
            awscli2
          ];
        };
      });
}
