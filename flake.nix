{
  inputs = {
    srvos.url = "github:numtide/srvos";
    nixpkgs.follows = "srvos/nixpkgs";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations = {

      contabo-cloud = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; diskDevice = "/dev/sda"; };
        modules = [ ./hosts/contabo-cloud ];
      };

      digital-ocean-cloud = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; diskDevice = "/dev/vda"; };
        modules = [ ./hosts/digital-ocean-cloud ];
      };

    };
  };
}
