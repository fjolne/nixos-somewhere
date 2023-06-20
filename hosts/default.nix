{ modulesPath, diskDevice, inputs, ... }:
with inputs;
{
  imports = [
    "${modulesPath}/installer/scan/not-detected.nix"
    # "${modulesPath}/profiles/qemu-guest.nix"
    "${modulesPath}/profiles/all-hardware.nix" # just to be safe for bare metal deployments
    disko.nixosModules.disko
  ];
  disko.devices = import ./single-gpt-disk-fullsize-ext4.nix diskDevice;
  boot.loader.grub = {
    devices = [ diskDevice ];
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  services.openssh.enable = true;
}
