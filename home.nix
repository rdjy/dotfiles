{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "dingji";
  home.homeDirectory = "/Users/dingji";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    tmux
    jq yq-go
    pass
    qemu
    # qrencode imagemagick
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dingji/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.yaml-mode
      epkgs.color-theme-sanityinc-solarized
    ];
  };
  programs.gpg = {
    enable = true;
  };
  programs.ssh = {
    enable = true;
    matchBlocks = {
    zion = {
      host = "zion";
      hostname = "192.168.1.230";
      extraOptions = { 
      controlPath = "~/.ssh/sock.zion";
      controlMaster = "auto";
      controlPersist = "10m";
      };
    };
    };
  };
  programs.git = {
    enable = true;
    userName = "Richard Yang";
    userEmail = "richard@dingji.info";
    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
      br = "branch";
      };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      selection.save_to_clipboard = true;
      window = {
        opacity = 0.97;
        dynamic_padding = true;
        blur = true;
        title = "term";
        dynamic_title = true;
        option_as_alt = "OnlyLeft";
        padding = {
          x = 5;
          y = 5;
        };
      };
      font.size = 12.0;
      font.normal.family = "DejaVu Sans Mono";
      mouse.hide_when_typing = true;
      shell.program = "/bin/zsh";
      shell.args = ["--login" "-c" "$HOME/.nix-profile/bin/tmux" "-u"];
      live_config_reload = true;
      # import = ["~/.config/alacritty/solarized_dark.toml"];
      colors.primary = {
        background = "#002b36";
        foreground = "#839496";
      };
      colors.normal = {
        black   = "#073642";
        red     = "#dc322f";
        green   = "#859900";
        yellow  = "#b58900";
        blue    = "#268bd2";
        magenta = "#d33682";
        cyan    = "#2aa198";
        white   = "#eee8d5";
      };
      colors.bright = {
        black   = "#002b36";
        red     = "#cb4b16";
        green   = "#586e75";
        yellow  = "#657b83";
        blue    = "#839496";
        magenta = "#6c71c4";
        cyan    = "#93a1a1";
        white   = "#fdf6e3";
      };
    };
  };
}
