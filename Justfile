fetch-network-configuration host hostname:
  ssh {{host}} 'bash -s' < gen_network_configuration.sh > hosts/{{hostname}}/network-configuration.nix

install host hostname:
  nix run github:numtide/nixos-anywhere -- {{host}} --flake .#{{hostname}}

install-arm host hostname:
  nix run github:numtide/nixos-anywhere -- {{host}} --flake .#{{hostname}} \
    --kexec "$(nix build --print-out-paths github:nix-community/nixos-images#packages.aarch64-linux.kexec-installer-nixos-unstable-noninteractive)/nixos-kexec-installer-noninteractive-aarch64-linux.tar.gz"

switch host hostname:
  nixos-rebuild switch --flake .#{{hostname}} --target-host {{host}} --use-substitutes # --fast --build-host {{host}}
