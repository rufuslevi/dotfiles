{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Hyprland
    hyprland-protocols
    hyprpicker
    hyprpaper

    iftop
    clipman
    eww
    swww
    wlogout
    cliphist
    exfat
    gnome.gvfs
    man-pages
    man-pages-posix
    udiskie
    cmake
    gnumake
    os-prober
    wget
    docker
    unzip
    speedtest-rs
    killall
    stow
    eza
    ripgrep
    fuse3
    jq
    zoxide
    fd
    playerctl
    brightnessctl
    go-task
    wl-clipboard
    kdePackages.qtimageformats
    xdg-utils
    xdg-ninja
  ];
}

