{ ... }:

{
  programs.niri.config = builtins.readFile ./config.kdl;

  # programs.niri.settings = {
  #   binds = {
  #     "Mod+T" = {
  #       action.spawn = [ "ptyxis" "--new-window" ];
  #       hotkey-overlay.title = "Open a Terminal";
  #     };
  #   };

  #   window-rules = [
  #     {
  #       geometry-corner-radius = {
  #         top-left     = 16.0;
  #         top-right    = 16.0;
  #         bottom-left  = 16.0;
  #         bottom-right = 16.0;
  #       };
  #       clip-to-geometry = true;
  #     }
  #   ];
  # };
}
