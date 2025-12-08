{ ... }:
{
  programs.firefox = {
    enable = true;
    profiles = {
      default = { };
    };
    policies = {
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisableFirefoxScreenshots = true;
      DisableForgetButton = true;
      DisableMasterPasswordCreation = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DisableFormHistory = true;

      DisplayMenuBar = false;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;

      GenerativeAI = {
        Enabled = false;
        Chatbot = false;
        LinkPreviews = false;
        TabGroups = false;
        Locked = true;
      };

      ExtensionSettings =
        with builtins;
        let
          extension = shortId: uuid: {
            name = uuid;
            value = {
              install_url = "https://addons.mozilla.org/en-US/firefox/downloads/latest/${shortId}/latest.xpi";
              installation_mode = "force_installed";
            };
          };
        in
        listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
          (extension "bitwarden-password-manager" "{446900e4-71c2-419f-a6a7-df9c091e268b}")
          (extension "7tv-extension" "moz-addon-prod@7tv.app")
        ]
        // {
          "*".installation_mode = "blocked";
        };
    };
  };
  stylix.targets.firefox = {
    enable = true;
    profileNames = [ "default" ];
  };
}
