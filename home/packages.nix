{pkgs, vars, ...}:{
  home.packages = with pkgs; [
    prismlauncher
    cinny-desktop
    (blender-hip.override {cudaSupport = true; })
    mpc
    kanshi
    comma
    wttrbar
    inkscape
    hyfetch
    fastfetch
    pamixer
    pavucontrol
    gimp
    timidity
    transmission_4-qt
    vesktop
    vlc
    playerctl
    firefox
    v4l-utils
    vscode
    espanso-wayland
    wofi
    sddm-astronaut
  ] 
  
  ++ (if vars.class != "shitbox" then [
    gamescope 
    libgpod 
    bs-manager 
    libimobiledevice 
    strawberry 
    openscad 
    openutau 
    wlr-randr 
    grim 
    slurp 
    grimblast 
    swaynotificationcenter 
    udiskie 
    gtklock 
    swaybg 
    fzf 
    wl-clipboard 
    brightnessctl 
    nemo 
    xfce.ristretto 
    xfce.tumbler
  ] else [])
    
  ++ (if vars.class == "shitbox" then [
    ripcord
  ] else []);
}
