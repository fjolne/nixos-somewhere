{ modulesPath, config, pkgs, inputs, ... }:
with inputs;
{
  imports = [
    "${modulesPath}/virtualisation/amazon-image.nix"
    srvos.nixosModules.server
  ];

  environment.systemPackages = with pkgs; [ vim tmux git ];

  users.users.ec2-user = {
    isNormalUser = true;
    description = "EC2 user";
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys = {
      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyva32b9/JANUGZEgQny/wemAETo4z6wAkF16CLk7fF"
      ];
    };
  };
}
