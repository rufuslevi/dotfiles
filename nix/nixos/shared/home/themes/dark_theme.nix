{ pkgs, ... }:

{
  dconf = {
    settings = {
      "org/gnome/desktop/wm/preferences".button-layout = "";
      "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; };
    };
  };

  gtk.theme = {
    name = "Gruvbox Dark";
    package = pkgs.gruvbox-dark-gtk;
  };

  xdg = {
    configFile = {
      "bat/config".text = ''--theme "gruvbox-dark"'';
      "qt5ct/qt5ct.conf" = { source = ../../../../../themes/qt5ct_dark.conf; };
      "qt6ct/qt6ct.conf" = { source = ../../../../../themes/qt6ct_dark.conf; };
      "Kvantum/kvantum.kvconfig".text = ''
        [General]
        theme=Catppuccin-Macchiato-Mauve
      '';
      "Kvantum/Catppuccin-Macchiato-Mauve" = {
        source = ../../../../../themes/catppuccin/Catppuccin-Macchiato-Mauve;
        recursive = true;
      };
      "Kvantum/gruvbox-kvantum" = {
        source = ../../../../../themes/gruvbox-kvantum;
        recursive = true;
      };
      "Kvantum/GraphiteNord-rimless" = {
        source = ../../../../../themes/GraphiteNord-rimless;
        recursive = true;
      };
    };
  };
}

