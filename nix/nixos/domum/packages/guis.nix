{ anyrun, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    anyrun.packages.${system}.anyrun
    waybar
    vesktop
    notion-app-enhanced
    vivaldi
    vivaldi-ffmpeg-codecs
    nautilus
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
    dunst
    themechanger
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
    slurp
    obs-studio
    obs-studio-plugins.wlrobs
  ];
}
