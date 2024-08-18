{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    wlr = {
      enable = true;
    };
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-kde
    ];
  };
}
