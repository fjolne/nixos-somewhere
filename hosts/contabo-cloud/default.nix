# This doesn't work for Contabo Dedidated Servers (at least without cloud-init).
# Maybe works for VPS, untested.
# Don't forget to fetch network-configuration.nix if cloud-init is not enabled.

{ modulesPath, ... }:
{
  imports = [
    ../default.nix
    ./network-configuration.nix
  ];

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyva32b9/JANUGZEgQny/wemAETo4z6wAkF16CLk7fF fjolne.yngling@gmail.com"
  ];
}
