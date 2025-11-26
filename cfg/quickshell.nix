{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      audio = {
        cavaFrameRate = 60;
        mprisBlacklist = [];
        preferredPlayer = "";
        visualizerQuality = "high";
        visualizerType = "mirror";
        volumeOverdrive = true;
        volumeStep = 5;
      };
      bar = {
        density = "comfortable";
        position = "left";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "SidePanelToggle";
              useDistroLogo = true;
            }
            {
              id = "SystemMonitor";
              showCpuUsage = true;
              showCpuTemp = false;
              showMemoryUsage = true;
              showMemoryAsPercent = true;
              showNetworkStats = false;
              showDiskUsage = false;
            }
            {
              id = "MediaMini";
              hideMode = "hidden";
              scrollingMode = "hover";
              maxWidth = 350;
              useFixedWidth = false;
              showAlbumArt = true;
              showVisualizer = true;
              visualizerType = "mirror";
            }
          ];
          center = [
            {
              id = "Workspace";
              hideUnoccupied = false;
              labelMode = "none";
            }
          ];
          right = [
            {
              id = "SystemMonitor";
              showCpuUsage = false;
              showCpuTemp = false;
              showMemoryUsage = false;
              showMemoryAsPercent = false;
              showNetworkStats = true;
              showDiskUsage = false;
            }
            {
              id = "NotificationHistory";
              showUnreadBadge = true;
              hideWhenZero = true;
            }
            # {
            #   id = "Tray";
            #   blacklist = [ ];
            #   colorizeIcons = false;
            # }
            {
              id = "Volume";
            }
            {
              id = "Clock";
              formatHorizontal = "HH:mm";
              formatVertical = "HH mm";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
      colorSchemes.predefinedScheme = "Monochrome";
      general = {
        avatarImage = "/home/x137/pics/.face";
        radiusRatio = 0.2;
        dimDesktop = false;
        showScreenCorners = false;
        forceBlackScreenCorners = false;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        animationSpeed = 1;
        animationDisabled = false;
        compactLockScreen = false;
        lockOnSuspend = true;
        enableShadows = true;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        language = "";
      };
      dock = {
        enabled = false;
      };
      notifications = {
        enabled = true;
        monitors = [];
        location = "top_right";
        overlayLayer = true;
        backgroundOpacity = 1;
        respectExpireTimeout = false;
        lowUrgencyDuration = 3;
        normalUrgencyDuration = 8;
        criticalUrgencyDuration = 15;
      };
      osd = {
        enabled = true;
        location = "top_right";
        monitors = [];
        autoHideMs = 2000;
        overlayLayer = true;
      };
      wallpaper = {
        enabled = true;
        overviewEnabled = true;
        directory = "/home/x137/code/echelon/walls/";
        enableMultiMonitorDirectories = false;
        recursiveSearch = false;
        setWallpaperOnAllMonitors = true;
        defaultWallpaper = "/home/x137/code/echelon/walls/jinx1.png";
        fillMode = "crop";
        fillColor = "#000000";
        randomEnabled = false;
        randomIntervalSec = 300;
        transitionDuration = 1500;
        transitionType = "random";
        transitionEdgeSmoothness = 0.05;
        monitors = [];
        panelPosition = "follow_bar";
      };
      screenRecorder = {
        directory = "/home/x137/docs/Screenshots/";
        frameRate = 60;
        audioCodec = "opus";
        videoCodec = "h264";
        quality = "very_high";
        colorRange = "limited";
        showCursor = true;
        audioSource = "default_output";
        videoSource = "portal";
      };
      ui = {
        fontDefault = "Roboto";
        fontFixed = "DejaVu Sans Mono";
        fontDefaultScale = 1;
        fontFixedScale = 1;
        tooltipsEnabled = true;
        panelsAttachedToBar = true;
        settingsPanelAttachToBar = false;
      };
      location = {
        name = "Kochi"; # doxxing myself
        weatherEnabled = true;
        useFahrenheit = false;
        use12hourFormat = false;
        showWeekNumberInCalendar = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
      };
    };
  };
}
