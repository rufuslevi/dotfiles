{ inputs, ... }:

{
  imports = [
    ../shared
    ./hardware
    ./programs
    ./services
    ./packages
    ./hardware.nix
    ./networking.nix
  ];

  nixpkgs.config.nvidia.acceptLicense = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
    users.rufuslevi = import ./home;
  };
}
