{ pkgs, config, ... }:

  ###################################################################################
  #
  #  macOS's System configuration
  #
  #  All the configuration options are documented here:
  #    https://daiderd.com/nix-darwin/manual/index.html#sec-options
  #  Incomplete list of macOS `defaults` commands :
  #    https://github.com/yannbertrand/macos-defaults
  #
  ###################################################################################
{
    system = {
    # activationScripts are executed every time you boot the system or run `nixos-rebuild` / `darwin-rebuild`.
    activationScripts.postUserActivation.text = ''
      # activateSettings -u will reload the settings from the database and apply them to the current session,
      # so we do not need to logout and login again to make the changes take effect.
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';

    defaults = {
      menuExtraClock.Show24Hour = true;  # show 24 hour clock

      # customize dock
#      dock = {
#        autohide = true;
#        show-recents = false;  # disable recent apps

        # customize Hot Corners(触发角, 鼠标移动到屏幕角落时触发的动作)
#        wvous-tl-corner = 2;  # top-left - Mission Control
#        wvous-tr-corner = 13;  # top-right - Lock Screen
#        wvous-bl-corner = 3;  # bottom-left - Application Windows
#        wvous-br-corner = 4;  # bottom-right - Desktop
#      };

      # customize finder
#      finder = {
#        _FXShowPosixPathInTitle = true;  # show full path in finder title
#        AppleShowAllExtensions = true;  # show all file extensions
#        FXEnableExtensionChangeWarning = false;  # disable warning when changing file extension
#        QuitMenuItem = true;  # enable quit menu item
#        ShowPathbar = true;  # show path bar
#        ShowStatusBar = true;  # show status bar
#      };

      # customize trackpad
      trackpad = {
        # tap - 轻触触摸板, click - 点击触摸板
        Clicking = true;  # enable tap to click(轻触触摸板相当于点击)
        TrackpadRightClick = true;  # enable two finger right click
        TrackpadThreeFingerDrag = true;  # enable three finger drag
      };

      # customize settings that not supported by nix-darwin directly
      # Incomplete list of macOS `defaults` commands :
      #   https://github.com/yannbertrand/macos-defaults
      NSGlobalDomain = {
        # `defaults read NSGlobalDomain "xxx"`
        "com.apple.swipescrolldirection" = false;  # enable natural scrolling(default to true)
        "com.apple.sound.beep.feedback" = 0;  # disable beep sound when pressing volume up/down key
        AppleInterfaceStyle = "Dark";  # dark mode
        AppleKeyboardUIMode = 3;  # Mode 3 enables full keyboard control.
        ApplePressAndHoldEnabled = true;  # enable press and hold

        # If you press and hold certain keyboard keys when in a text area, the key’s character begins to repeat.
        # This is very useful for vim users, they use `hjkl` to move cursor.
        # sets how long it takes before it starts repeating.
        InitialKeyRepeat = 15;  # normal minimum is 15 (225 ms), maximum is 120 (1800 ms)
        # sets how fast it repeats once it starts.
        KeyRepeat = 3;  # normal minimum is 2 (30 ms), maximum is 120 (1800 ms)

        NSAutomaticCapitalizationEnabled = false;  # disable auto capitalization(自动大写)
        NSAutomaticDashSubstitutionEnabled = false;  # disable auto dash substitution(智能破折号替换)
        NSAutomaticPeriodSubstitutionEnabled = false;  # disable auto period substitution(智能句号替换)
        NSAutomaticQuoteSubstitutionEnabled = false;  # disable auto quote substitution(智能引号替换)
        NSAutomaticSpellingCorrectionEnabled = false;  # disable auto spelling correction(自动拼写检查)
        NSNavPanelExpandedStateForSaveMode = true;  # expand save panel by default(保存文件时的路径选择/文件名输入页)
        NSNavPanelExpandedStateForSaveMode2 = true;
      };

      # Customize settings that not supported by nix-darwin directly
      # see the source code of this project to get more undocumented options:
      #    https://github.com/rgcr/m-cli
      #
      # All custom entries can be found by running `defaults read` command.
      # or `defaults read xxx` to read a specific domain.
      CustomUserPreferences = {
#        ".GlobalPreferences" = {
#          # automatically switch to a new space when switching to the application
#          AppleSpacesSwitchOnActivate = true;
#        };
        NSGlobalDomain = {
          # Add a context menu item for showing the Web Inspector in web views
          WebKitDeveloperExtras = true;
        };
        "com.apple.finder" = {
          ShowExternalHardDrivesOnDesktop = true;
          ShowHardDrivesOnDesktop = true;
          ShowMountedServersOnDesktop = true;
          ShowRemovableMediaOnDesktop = true;
          _FXSortFoldersFirst = true;
          # When performing a search, search the current folder by default
          FXDefaultSearchScope = "SCcf";
        };
        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };
#        "com.apple.spaces" = {
#          "spans-displays" = 0; # Display have seperate spaces
#        };
#        "com.apple.WindowManager" = {
#          EnableStandardClickToShowDesktop = 0; # Click wallpaper to reveal desktop
#          StandardHideDesktopIcons = 0; # Show items on desktop
#          HideDesktop = 0; # Do not hide items on desktop & stage manager
#          StageManagerHideWidgets = 0;
#          StandardHideWidgets = 0;
#        };
#        "com.apple.screensaver" = {
#          # Require password immediately after sleep or screen saver begins
#          askForPassword = 1;
#          askForPasswordDelay = 0;
#        };
#        "com.apple.screencapture" = {
#          location = "~/Desktop";
#          type = "png";
#        };
        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };
        # Prevent Photos from opening automatically when devices are plugged in
        "com.apple.ImageCapture".disableHotPlug = true;
      };

#      loginwindow = {
#        GuestEnabled = false;  # disable guest user
#        SHOWFULLNAME = true;  # show full name in login window
#      };
    };

    # keyboard settings is not very useful on macOS
    # the most important thing is to remap option key to alt key globally,
    # but it's not supported by macOS yet.
    keyboard = {
      enableKeyMapping = true;  # enable key mapping so that we can use `option` as `control`

      # NOTE: do NOT support remap capslock to both control and escape at the same time
      remapCapsLockToControl = true;  # remap caps lock to control, useful for emac users
      remapCapsLockToEscape  = false;   # remap caps lock to escape, useful for vim users

      # swap left command and left alt
      # so it matches common keyboard layout: `ctrl | command | alt`
      #
      # disabled, caused only problems!
      swapLeftCommandAndLeftAlt = false;
    };
  };


  # TODO To make this work, homebrew need to be installed manually, see https://brew.sh
  #
  # The apps installed by homebrew are not managed by nix, and not reproducible!
  # But on macOS, homebrew has a much larger selection of apps than nixpkgs, especially for GUI apps!
  homebrew = {
    enable = true;

    #onActivation = {
    #  autoUpdate = false;
    #  # 'zap': uninstalls all formulae(and related files) not listed here.
    #  cleanup = "zap";
    #};

    # Applications to install from Mac App Store using mas.
    # You need to install all these Apps manually first so that your apple account have records for them.
    # otherwise Apple Store will refuse to install them.
    # For details, see https://github.com/mas-cli/mas
    #masApps = {
      # TODO Feel free to add your favorite apps here.

      #Xcode = 497799835;
      # Wechat = 836500024;
      # NeteaseCloudMusic = 944848654;
      # QQ = 451108668;
      # WeCom = 1189898970;  # Wechat for Work
      # TecentMetting = 1484048379;
      # QQMusic = 595615424;
    #};

    taps = [
      "homebrew/services"
    ];

    # `brew install`
    # TODO Feel free to add your favorite apps here.
    #brews = [
      #"wget" # download tool
      #"curl" # no not install curl via nixpkgs, it's not working well on macOS!
      #"aria2" # download tool
      #"httpie" # http client
    #];

    # `brew install --cask`
    # TODO Feel free to add your favorite apps here.
    #casks = [
    #  "firefox"
    #  "google-chrome"
    #  "visual-studio-code"

      # IM & audio & remote desktop & meeting
    #  "telegram"
    #  "discord"

      #"anki"
      #"iina" # video player
    #  "raycast" # (HotKey: alt/option + space)search, caculate and run scripts(with many plugins)
    #  "stats" # beautiful system monitor
      #"eudic" # 欧路词典

      # Development
    #  "insomnia" # REST client
    #  "wireshark" # network analyzer
    #];
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPath = [ config.homebrew.brewPrefix ];
}
