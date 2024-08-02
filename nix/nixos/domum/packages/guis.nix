{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    waybar
    vesktop
    notion-app-enhanced
    vivaldi
    vivaldi-ffmpeg-codecs
    gnome.nautilus
    bitmagnet
    github-desktop
    openrgb-with-all-plugins
    kitty
    guake
    thunderbird
    obsidian
    cider
    caprine-bin
    bitwarden-desktop
    prismlauncher
    jetbrains.clion
    jetbrains.idea-ultimate
    unityhub
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.dolphin
    libsForQt5.partitionmanager
    dunst
    themechanger
    wezterm
    kitty
    pavucontrol
    pwvucontrol
    vlc
    gparted
    librewolf
    tofi
    wofi
    kate
    qbittorrent
    onedrive
    waypaper
    vscodium
    gimp
    qpwgraph
    helvum
    selectdefaultapplication
    lutris
    heroic
  ];
}