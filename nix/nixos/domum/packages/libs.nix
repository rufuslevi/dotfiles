{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    openrazer-daemon
    glib
    logiops
    libinput
    libcamera
    wayland-scanner
  ];
}
