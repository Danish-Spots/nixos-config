{
  config,
  lib,
  pkgs,
  outputs,
  ...
}:
with lib; let
  cfg = config.features.desktop.waybar;
  nixUpdatesScript = pkgs.writeShellScriptBin "nix-updates" (builtins.readFile ./nix-os-updates.sh);
  nvidiaUtilScript = pkgs.writeShellScriptBin "nvidia-util" (builtins.readFile ./nvidia-util.sh);
in {
  options.features.desktop.waybar.enable = mkEnableOption "enable waybar and config";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.wttrbar
      nixUpdatesScript
      nvidiaUtilScript
    ];
    programs.waybar = {
      enable = true;
      systemd = {
        enable = true;
      };
      style = ''
        @import url('../../.cache/wal/colors-waybar.css');


        * {
            border: none;
            border-radius: 0;
            font-family: FiraCode Nerd Font;
            font-weight: bold;
            font-size: 18px;
            min-height: 0;
            /* margin-top: 10px; */
        }
        tooltip {
            background: @background;
            color: @color7;
        }

        /* waybar */
        window#waybar {
            all: unset;
        }

        /* modules */
        .modules-right {
            padding:10px;
            /* margin: 10 10 5 0; */
            margin: 0;
            margin-bottom: 5px;
            padding-top: 15px;
            padding-right: 15px;
            border-bottom-left-radius: 16px;
            box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
            background: alpha(@background,.6);

        }
        .modules-center {
            padding:10px;
            padding-top: 15px;
            margin: 0;
            margin-bottom: 5px;
            border-bottom-left-radius: 16px;
            border-bottom-right-radius: 16px;
            background: alpha(@background,.6);
            box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
        }

        /* Groups */
        #left {
            padding:10px;
            padding-top: 15px;
            margin: 0;
            margin-bottom: 5px;
            background: alpha(@background,.6);
            box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
            margin-right: 120px;
            border-bottom-right-radius: 16px;
        }

        /* Workspaces */
        #workspaces {
            padding: 0;
            padding-left: 5px;
            padding-right: 5px;
        }


        #workspaces button {
            all:unset;
            padding: 0;
            padding-left: 5px;
            padding-right: 5px;
            margin-right: 8px;
            margin-left: 8px;
            color: alpha(@color9,.4);
            transition: all .2s ease;
        }
        #workspaces button:hover {
            color:rgba(0,0,0,0);
            border: none;
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
            transition: all 1s ease;
        }
        #workspaces button.active {
            color: @color9;
            border: none;
            text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
        }
        #workspaces button.empty {
            color: rgba(0,0,0,0);
            border: none;
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
        }
        #workspaces button.empty:hover {
            color: rgba(0,0,0,0);
            border: none;
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
            transition: all 1s ease;
        }
        #workspaces button.empty.active {
            color: @color9;
            border: none;
            text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
        }
        /* Left modules */
        #tray{
            padding: 0px 5px;
            margin-right: 5px;
            margin-left: 15px;
            transition: all .3s ease;
            color: @color7;

        }
        #tray menu * {
            padding: 0px 5px;
            transition: all .3s ease;
        }

        #tray menu separator {
            padding: 0px 5px;
            transition: all .3s ease;
        }

        #mpris {
            padding:10px;
            padding-top: 15px;
            padding-left: 20px;
            padding-right: 15px;
            margin: 0;
            margin-bottom: 5px;
            border-bottom-left-radius: 16;
            border-bottom-right-radius: 16;
            color: @color7;
            transition: all .3s ease;
            background: alpha(@background,.6);
            box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
        }

        #custom-notification, #clock, #custom-weather, #user, #cpu, #memory, #network, #privacy, #custom-nvidia, #custom-nix-updates {
            padding: 0 5px;
            color: @color7;
            transition: all .3s ease;
        }
        #user, #custom-weather, #custom-nix-updates {
            margin-left: 15px;
            margin-right: 15px;
        }

        #custom-nvidia,
        #cpu,
        #memory,
        #network,
        #custom-notification,
        #clock {
            margin-left: 15px;
            margin-right: 15px;
        }
        #custom-nvidia {
            margin-left: 5px;
        }

        /* Hover */
        #mpris:hover,
        #privacy:hover,
        #cpu:hover,
        #memory:hover,
        #network:hover,
        #custom-weather:hover,
        #custom-notification:hover,
        #custom-nvidia:hover,
        #user:hover,
        #custom-nix-updates:hover,
        #clock:hover {
            transition: all .3s ease;
            color: @color9;
        }
      '';
      settings = {
        mainbar = {
          layer = "top";
          position = "top";
          mode = "dock";
          exclusive = true;
          passthrough = true;
          gtk-layer-shell = true;
          height = 0;
          modules-left = ["group/left" "mpris"];
          modules-center = ["hyprland/workspaces"];
          modules-right = [
            "custom/nvidia"
            "privacy"
            "cpu"
            "memory"
            "network"
            "custom/notification"
            "clock"
          ];

          "hyprland/workspaces" = {
            disable-scroll = true;
            format = "{icon}";
            format-icons = {
              active = "";
              default = "";
              empty = "";
            };
            persistent-workspaces = {
              "*" = [
                1
                2
                3
                4
                5
              ];
            };
          };
          "custom/notification" = {
            tooltip = false;
            format = "󰂚";
            on-click = "swaync-client -t -sw";
            escape = true;
          };
          network = {
            interval = 5;
            format-ethernet = "󰈀 {ipaddr}";
            format-disconnected = "󰪎 disconnected";
            tooltip-format-disconnected = "Error";
            tooltip-format-ethernet = "󰁞 {bandwidthUpBytes} | 󰁆 {bandwidthDownBytes}";
          };
          "custom/weather" = {
            format = "{}°C";
            tooltip = true;
            interval = 3600;
            exec = "wttrbar --location Soroe";
            return-type = "json";
          };
          tray = {
            icon-size = 18;
            spacechoing = 10;
          };
          clock = {
            format = " {:%R   %d/%m}";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
          cpu = {
            format = "󰻠 {usage}% | {avg_frequency} GHz";
            tooltip = true;
          };
          memory = {
            format = "󰍛 {percentage}% | {used} GiB";
            tooltip = true;
          };
          "group/left" = {
            orientation = "horizontal";
            modules = [
              "user"
              "custom/weather"
              "custom/nix-updates"
              "tray"
            ];
          };

          "custom/nvidia" = {
            format = "{}";
            interval = 2;
            return-type = "json";
            exec = "nvidia-util";
          };
          "custom/nix-updates" = {
            format = "{}";
            exec = "cat ~/.cache/nix-update/waybar.json";
            on-click = "nix-updates";
            on-right-click = "cat ~/.cache/nix-update/waybar.json";
            return-type = "json";
            interval = 0;
          };

          mpris = {
            format = "{status_icon} {player_icon} {dynamic}";
            format-paused = "{status_icon} <i>{dynamic}</i>";
            player-icons = {
              firefox = "󰈹";
            };
            status-icons = {
              paused = "󰏤";
              playing = "󰐊";
              stopped = "󰓛";
            };
          };
        };
      };
    };
  };
}
