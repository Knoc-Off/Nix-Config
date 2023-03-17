# NixOS, Firefox, web browser configuration, extensions, custom configuration options, CSS styles
{ nix-colors, config, pkgs, inputs, ... }:
let
  profileName = "knoff";
  firefoxPath = ".mozilla/firefox";
  profilePath = "${firefoxPath}/${profileName}";

  addons = inputs.firefox-addons.packages.${pkgs.system};
in
{
  home.file."${profilePath}/chrome/sidebar-mods.css".text =
    builtins.readFile (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/UnlimitedAvailableUsername/Edge-Mimicry-Tree-Style-Tab-For-Firefox/main/edge-mimicry/sidebar-mods.css";
      sha256 = "0r70aygb86gldpzcsv2jqr88hm612m1av7whgxh3qid8jkzwfhxb";
  });
  home.file."${profilePath}/chrome/treestyletab-edge-mimicry.css".text =
    builtins.readFile (builtins.fetchurl {
      url = "https://raw.githubusercontent.com/UnlimitedAvailableUsername/Edge-Mimicry-Tree-Style-Tab-For-Firefox/main/treestyletab-edge-mimicry.css";
      sha256 = "1pyn99widc3m9xlsklwd403q2srhnafa4a1kyh1b3pgd1w9g0bli";
  });

  imports = [
    ./profiles/main.nix
  ];

  programs.firefox = {
    enable = true;

    profiles."testing" = {
      id = 11;
      name = "cssTests";
      isDefault = false;


      extensions = with addons; [
        ublock-origin
        anonaddy
        clearurls
        privacy-possum
        decentraleyes
        darkreader
        sponsorblock
        i-dont-care-about-cookies

        # Productivity
        violentmonkey
      ];
      settings = {

        # Disable all sorts of telemetry
        "browser.newtabpage.activity-stream.telemetry.structuredIngestion.endpoint" = "";
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "devtools.onboarding.telemetry.logged" = false;
        "toolkit.telemetry.unifiedIsOptIn" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.rejected" = true;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.hybridContent.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.prompted" = 2;
        "toolkit.telemetry.cachedClientID" = "";

        # As well as Firefox 'experiments'
        "experiments.activeExperiment" = false;
        "experiments.enabled" = false;
        "experiments.supported" = false;
        "network.allow-experiments" = false;


        # Disable Pocket Integration
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "extensions.pocket.enabled" = false;
        "extensions.pocket.api" = "";
        "extensions.pocket.oAuthConsumerKey" = "";
        "extensions.pocket.showHome" = false;
        "extensions.pocket.site" = "";


        #### Theme Settings ####

        ## Photon theme
        # Defaults
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.compactmode.show" = true;


        # Theme Default Settings
	      "layout.css.devPixelsPerPx" = "1.3"; # UI shrink

        # Useful Options
        "browser.urlbar.suggest.calculator" = true;
        "browser.urlbar.unitConversion.enabled" = true;

      };
    };
  };
}
