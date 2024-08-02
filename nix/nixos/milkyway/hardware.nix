# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules = [
    "ehci_pci"
    "ahci"
    "firewire_ohci"
    "xhci_pci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "sr_mod"
  ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];
  boot.loader = {
    systemd-boot.enable = false;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      useOSProber = false;
      efiSupport = true;
      theme = "/boot/grub/themes/hyperfluent";
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/d8f3e37e-f096-4db4-bb72-963d6bdff43f";
    fsType = "ext4";
  };

  fileSystems."/mnt/toshiba" = {
    device = "/dev/disk/by-uuid/1fbe4c71-e926-460b-8dc4-a2e3ea8cda56";
    options = [ "rw" "nofail" "users" ];
    fsType = "ext4";
  };

  fileSystems."/mnt/hitachi" = {
    device = "/dev/disk/by-uuid/e931974d-288c-43c2-a2b3-28c164cb3442";
    options = [ "rw" "nofail" "users" ];
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6CA6-91BA";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/4f225b86-d0d6-4ccb-a24d-489d0571e08e"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.eno1.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}