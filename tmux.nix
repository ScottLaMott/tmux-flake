# Nix configuration for system-wide tmux
# It is used by all users and shall stay pretty much identical
{ pkgs, lib, ... }:

# Whatever additional plugins are required can be added here
# and added to plugins
let plugins = with pkgs; [];
in {
  environment.systemPackages = plugins ++ (with pkgs; [
    tmux
  ]);
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    keyMode = "vi";
    baseIndex = 1;
    escapeTime = 1;
    extraConfig = ''
      ${builtins.readFile ./tmux.conf}

      # Plugins
      ${lib.concatStrings (map (x: "run-shell ${x.rtp}\n") plugins)}
    '';
  };
}
