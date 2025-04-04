var plasma = getApiVersion(1);

var layout = {
  desktops: [
    {
      config: {
        "/": {
          wallpaperplugin: "com.plasma.wallpaper.wallhaven",
        },
        "/Wallpaper/com.plasma.wallpaper.wallhaven/General": {
          Query: "",
          Ratio1610: true,
          Ratio169: true,
          Sorting: "toplist",
          TopRange: "1d",
          WallpaperDelay: "1440",
        },
      },
      wallpaperPlugin: "com.plasma.wallpaper.wallhaven",
    },
  ],
  panels: [
    {
      alignment: "left",
      location: 4,
      applets: [
        {
          config: {
            "/Configuration/Units": {
              pressureUnit: "5028",
              speedUnit: "9002",
              temperatureUnit: "6002",
              visibilityUnit: "2024",
            },
            "/Configuration/WeatherStation": {
              source:
                "wettercom|weather|Ha Long, Tinh Quang Ninh, VN|VN1580410;Ha Long",
            },
          },
          plugin: "org.kde.plasma.weather",
        },
        {
          config: {
            "/Configuration": {
              localPath:
                "/usr/share/applications/org.kde.plasma-systemmonitor.desktop",
              url: "file:///usr/share/applications/org.kde.plasma-systemmonitor.desktop",
            },
          },
          plugin: "org.kde.plasma.icon",
        },
        {
          config: {
            "/Configuration": {
              localPath: "/usr/share/applications/org.kde.systemdgenie.desktop",
              url: "file:///usr/share/applications/org.kde.systemdgenie.desktop",
            },
          },
          plugin: "org.kde.plasma.icon",
        },
        { plugin: "org.kde.plasma.pager" },
        { plugin: "org.kde.plasma.minimizeall" },
        { plugin: "org.kde.plasma.panelspacer" },
        {
          config: {
            "/Configuration/General": {
              customButtonImage: "distributor-logo-steamdeck",
              systemFavorites: "suspend,hibernate,reboot,shutdown",
              favoritesPortedToKAstats: "true",
              useCustomButtonImage: "true",
            },
          },
          plugin: "org.kde.plasma.kickoff",
        },
        { plugin: "com.himdek.kde.plasma.overview" },
        {
          config: {
            "/Configuration/General": {
              groupingStrategy: "0",
              launchers:
                "applications:org.kde.dolphin.desktop,applications:org.kde.konsole.desktop,applications:code-oss.desktop,preferred://browser",
            },
          },
          plugin: "org.kde.plasma.icontasks",
        },
        { plugin: "org.kde.plasma.panelspacer" },
        { plugin: "org.kde.plasma.systemtray", "location": 4 },
        { plugin: "org.kde.plasma.digitalclock" },
      ],
      config: {
          "/": {
              location: "4",
              wallpaperplugin: "org.kde.image"
          }
      },
      height: 2,
      location: "top",
    },
  ],
  serializationFormatVersion: "1",
};

plasma.loadSerializedLayout(layout);
