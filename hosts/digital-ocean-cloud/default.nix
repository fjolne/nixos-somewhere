# DigitalOcean provides network configuration via cloud-init on boot (not DHCP),
# so we use mixin from numtide/srvos, enable networkd and disable DHCP.

{ modulesPath, pkgs, inputs, ... }:
with inputs;
{
  imports = [
    ../default.nix
    srvos.nixosModules.mixins-cloud-init
  ];
  networking.useNetworkd = true;
  networking.useDHCP = false;

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyva32b9/JANUGZEgQny/wemAETo4z6wAkF16CLk7fF fjolne.yngling@gmail.com"
  ];
  environment.systemPackages = with pkgs; [ vim tmux ];
}
