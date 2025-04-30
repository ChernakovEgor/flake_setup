{ config, lib, pkgs,  ... }:

{
    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_17;
      ensureDatabases = [ "demo_database" ];
      enableTCPIP = true;
      # port = 5432;
      settings = {
        listen_addresses = "*";
      };
      authentication = pkgs.lib.mkOverride 10 ''
        #type database DBuser origin-address auth-method
        local all       all     trust
        # ipv4
        host  all      all     127.0.0.1/32   trust
        # ipv6
        host all       all     ::1/128        trust

        host all       egor    0.0.0.0/0      md5
      '';
      initialScript = pkgs.writeText "backend-initScript" ''
        CREATE ROLE egor WITH LOGIN SUPERUSER PASSWORD 'egor' CREATEDB;
      '';
    };
}

