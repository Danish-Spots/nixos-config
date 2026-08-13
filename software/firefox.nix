{ pkgs, ... }:

{ 
  programs.firefox = {
    enable = true;
    profiles.justin = {
      settings = {
        "browser.startup.page" = 3;

        "browser.tabs.warnOnClose" = false;
        "browser.tabs.warnOnCloseOtherTabs" = false;
        "browser.tabs.warnOnQuit" = false;
      };
    };
  };
}