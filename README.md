This project is a template for installing and managing NixOS on different compute providers. It uses:
- [nixos-anywhere](https://github.com/numtide/nixos-anywhere) as a main way to install NixOS
- [nixos-infect](https://github.com/elitak/nixos-infect) to fetch runtime network configuration in certain cases
- [just](https://github.com/casey/just) to run commands

## Install on a new machine
- create configuration in `hosts/<hostname>/default.nix` and add it to `flake.nix`
- run `just fetch-network-configuration <host> <hostname>` and ensure that you import it in `hosts/<hostname>/default.nix`
- run `just install <host> <hostname>` to install NixOS to the target machine

## Update configuration on a machine
- run `just switch <host> <hostname>` to update configuration on the target machine


## Inspirations
- This blogpost by [tfc](https://github.com/tfc): https://galowicz.de/2023/04/05/single-command-server-bootstrap/
