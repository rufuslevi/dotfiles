{ pkgs, ... }:

{
  home.username = "rufuslevi";
  home.stateVersion = "22.05";

  xdg = {
    enable = true;
  };
  programs = import ./programs.nix { inherit pkgs; };
  home.packages = with pkgs; [ nil nixfmt nixpkgs-fmt ];
}
