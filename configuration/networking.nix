{ ... }: {
  networking = {
    hostName = "nixos"; # Define your hostname.
    extraHosts = ''
      127.0.0.1 localcast.example.com
    '';
    networkmanager.enable = true;
    firewall = {
      enable = true;
      allowedUDPPortRanges = [{
        from = 1899;
        to = 1901;
      }];
      allowedTCPPorts = [ 10400 ];
      allowedTCPPortRanges = [
        {
          from = 2999;
          to = 3005;
        }
        {
          from = 5172;
          to = 5175;
        }
        {
          from = 49152;
          to = 65535;
        }
      ];
    };
  };
}
