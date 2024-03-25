{ config, pkgs, lib, inputs, ... }:

let
  extra-path = with pkgs; [
    dotnetCorePackages.sdk_6_0
    dotnetPackages.Nuget
    mono
    msbuild
  ];

  extra-lib = with pkgs;[
    # Add any extra libraries you want accessible to Rider here
  ];

  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = ''
      # Wrap rider with extra tools and libraries
      mv $out/bin/rider $out/bin/.rider-toolless
      makeWrapper $out/bin/.rider-toolless $out/bin/rider \
        --argv0 rider \
        --prefix PATH : "${lib.makeBinPath extra-path}" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"
      # Making Unity Rider plugin work!
      # The plugin expects the binary to be at /rider/bin/rider,
      # with bundled files at /rider/
      # It does this by going up two directories from the binary path
      # Our rider binary is at $out/bin/rider, so we need to link $out/rider/ to $out/
      shopt -s extglob
      ln -s $out/rider/!(bin) $out/
      shopt -u extglob
    '' + attrs.postInstall or "";
  });

  dconf_color = if config.darkmode then "prefer-dark" else "prefer-light";
  gtk_theme =
    if config.darkmode then {
      name = "Gruvbox Dark";
      package = pkgs.gruvbox-dark-gtk;
    } else {
      name = "Rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };
in
{
  imports = [
    ../../variables.nix
  ];

  home.username = "rufuslevi";
  home.homeDirectory = "/home/rufuslevi";
  home.stateVersion = "23.11";

  dconf = {
    settings = {
      "org/gnome/desktop/wm/preferences".button-layout = "";
      "org/gnome/desktop/interface" = {
        color-scheme = dconf_color;
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      source = ~/.config/hypr/hypr.conf
      source = ~/.config/hypr/test-hypr.conf
    '';
  };

  services = {
    gammastep = {
      enable = true;
      provider = "manual";
      latitude = 45.50884;
      longitude = -73.58781;
    };
    playerctld = {
      enable = true;
    };
    flameshot = {
      enable = true;
      settings = {
        General = {
          showStartupLaunchMessage = false;
        };
      };
    };
  };

  gtk = {
    enable = true;
    theme = gtk_theme;
    cursorTheme = {
      name = "volantes";
      package = pkgs.volantes-cursors;
      size = 24;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style = {
      name = "kvantum";
    };
  };

  xdg = {
    portal = {
      config = {
        common = {
          "org.freedesktop.impl.portal.Settings" = "gtk";
        };
      };
    };
    userDirs = {
      enable = true;
      desktop = "${config.home.homeDirectory}/Bureau";
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Téléchargements";
      music = "${config.home.homeDirectory}/Musique";
      pictures = "${config.home.homeDirectory}/Images";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Modèles";
      videos = "${config.home.homeDirectory}/Vidéos";
    };
    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = [ "okularApplication_pdf.desktop" ];
        "application/json" = [ "nvim.desktop" ];
        "application/x-docbook+xml" = [ "nvim.desktop" ];
        "application/x-yaml" = [ "nvim.desktop" ];
        "application/yaml" = [ "org.kde.kate.desktop" ];
        "application/zip" = [ "org.kde.ark.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
        "text/plain" = [ "nvim.desktop;org.kde.kate.desktop" ];
        "text/x-cmake" = [ "nvim.desktop" ];
        "x-scheme-handler/http" = [ "librewolf.desktop;firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "x-scheme-handler/https" = [ "librewolf.desktop;firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "text/html" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "application/x-extension-htm" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "application/x-extension-html" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "application/x-extension-shtml" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "application/xhtml+xml" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "application/x-extension-xhtml" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
        "application/x-extension-xht" = [ "firefox-developer-edition.desktop;firefox-devedition.desktop" ];
      };
      defaultApplications = {
        "application/pdf" = [ "okularApplication_pdf.desktop" ];
        "application/json" = [ "nvim.desktop" ];
        "application/x-docbook+xml" = [ "nvim.desktop" ];
        "application/x-yaml" = [ "nvim.desktop" ];
        "application/yaml" = [ "org.kde.kate.desktop" ];
        "application/zip" = [ "org.kde.ark.desktop" ];
        "text/html" = [ "firefox-devedition.desktop" ];
        "text/markdown" = [ "nvim.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
        "text/x-cmake" = [ "nvim.desktop" ];
        "x-scheme-handler/ame" = [ "cider.desktop" ];
        "x-scheme-handler/cider" = [ "cider.desktop" ];
        "x-scheme-handler/http" = [ "firefox-devedition.desktop" ];
        "x-scheme-handler/https" = [ "firefox-devedition.desktop" ];
        "x-scheme-handler/itms" = [ "cider.desktop" ];
        "x-scheme-handler/itmss" = [ "cider.desktop" ];
        "x-scheme-handler/music" = [ "cider.desktop" ];
        "x-scheme-handler/musics" = [ "cider.desktop" ];
        "x-scheme-handler/x-github-client" = [ "github-desktop.desktop" ];
        "x-scheme-handler/x-github-desktop-auth" = [ "github-desktop.desktop" ];
        "x-scheme-handler/chrome" = [ "firefox-devedition.desktop" ];
        "application/x-extension-htm" = [ "firefox-devedition.desktop" ];
        "application/x-extension-html" = [ "firefox-devedition.desktop" ];
        "application/x-extension-shtml" = [ "firefox-devedition.desktop" ];
        "application/xhtml+xml" = [ "firefox-devedition.desktop" ];
        "application/x-extension-xhtml" = [ "firefox-devedition.desktop" ];
        "application/x-extension-xht" = [ "firefox-devedition.desktop" ];
      };
    };
    configFile = {
      "tofi/config" = {
        source = ../../tofi/config;
      };
      "hypr/hypr.conf" = {
        source = ../../hypr/hypr.conf;
      };
      "waypaper/config.ini" = {
        source = ../../waypaper/config.ini;
      };
      "scripts/hyprland_qt_fix.sh" = {
        source = ../../scripts/hyprland_qt_fix.sh;
      };
      "waybar" = {
        source = ../../waybar;
        recursive = true;
      };
    };
  };

  home.packages = with pkgs; [
    speedtest-rs
    killall
    stow
    jq
    openrazer-daemon
    zoxide
    cargo
    rustc
    tree-sitter
    nodejs_21
    fd
    lua
    eza
    gcc
    lxqt.lxqt-policykit
    ripgrep
    libqalculate
    notion-app-enhanced
    youtube-tui
    mpv
    obsidian
    cider
    webcord
    caprine-bin
    sublime4
    onedrive
    guake
    bitwarden-desktop

    # KDE Tools
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.dolphin
    kdePackages.partitionmanager
    kdePackages.kirigami

    # Git
    gitui
    lazygit
    gh

    dex
    waybar-mpris
    krabby
    qpwgraph
    helvum
    swww
    waypaper
    wlogout
    cliphist
    at-spi2-atk

    #Theming
    darkman
    volantes-cursors
    kdePackages.qtwebsockets
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qt6gtk2
    kdePackages.qt6ct
    libsForQt5.systemsettings
    libsForQt5.qt5ct
    libsForQt5.qt5.qtwayland
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugins
    libsForQt5.kwayland-integration
    qt6.qmake
    qt6.qtwayland
    xorg.libxcb
    gnome.adwaita-icon-theme
    gsettings-desktop-schemas

    # Fonts
    atkinson-hyperlegible
    font-awesome

    clipman
    lua54Packages.jsregexp
    llvmPackages_17.clang-unwrapped
    gnome.gnome-tweaks
    grimblast
    lua-language-server
    stylua
    jdt-language-server
    marksman
    rust-analyzer
    nil
    go
    gopls
    python312
    python312Packages.pip
    shfmt
    taplo
    rider
    jetbrains.clion
    jetbrains.idea-ultimate
    unityhub
    dotnet-sdk_7
  ];

  programs = { } // import ./programs.nix { inherit pkgs; };

  home.file = {
    ".local/share/applications/jetbrains-rider.desktop".source =
      let
        desktopFile = pkgs.makeDesktopItem {
          name = "jetbrains-rider";
          desktopName = "Rider";
          exec = "\"${rider}/bin/rider\"";
          icon = "rider";
          type = "Application";
          # Don't show desktop icon in search or run launcher
          extraConfig.NoDisplay = "true";
        };
      in
      "${desktopFile}/share/applications/jetbrains-rider.desktop";
  };

  home.activation = {
    # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
    regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };
}
