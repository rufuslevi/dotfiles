{ ... }:

{
  imports = [ ./languages.nix ];

  homebrew.brews = [
    "borders"
    "cmatrix"
    "koekeishiya/formulae/yabai"
    "koekeishiya/formulae/skhd"
    "neofetch"
    "libqalculate"
    "octave"
    "fish"
    "yazi"
    "zoxide"
    "fzf"
    "ripgrep"
    "eza"
    "stow"
    "telnet"
    "jq"
    "fd"
    "bat"
    "git-lfs"
    "gitui"
    "lazygit"
    "btop"
    "neovim"
    "tree-sitter"
    "scons"
    "pngquant"
  ];
}
