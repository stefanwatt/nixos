{ userSettings, ... }: {
  fileSystems."/run/media/${userSettings.username}/1TBHybrid" = {
    device = "/dev/disk/by-uuid/52A4CF08A4CEED93";
    fsType = "ntfs";
  };

  fileSystems."/run/media/${userSettings.username}/250SSD" = {
    device = "/dev/disk/by-uuid/53cca614-bfc1-4c42-9088-d83b04b2e73e";
    fsType = "ext4";
  };

  fileSystems."/run/media/${userSettings.username}/nvme-data" = {
    device = "/dev/disk/by-uuid/a80c8aa6-a23f-4252-9253-4464c3fc8f5f";
    fsType = "ext4";
  };
}
