with import <nixpkgs> {};


pkgs.stdenv.mkDerivation {
   name = "cuda-env-shell";
   buildInputs = with pkgs; with pkgs.python39Packages; [
     git gitRepo gnupg autoconf curl ffmpeg-full
     procps gnumake utillinux m4 gperf unzip
     cudatoolkit linuxPackages.nvidia_x11
     cudaPackages.cudnn
     libGLU libGL
     xorg.libXi xorg.libXmu freeglut
     xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
     ncurses5 stdenv.cc binutils
    linuxPackages.nvidia_x11
    cudatoolkit 
    python39
    tts
    tensorflow-bin
    pytorch-bin
    flask
    simpleaudio
    wasabi
    cymem
    tqdm
    unidecode
    inflect
    librosa
    pandas
    jupyter
    pyaudio
    webrtcvad
    spinners
    termcolor
    stt
    virtualenv
    absl-py

   ];
   shellHook = ''
      export CUDA_PATH=${pkgs.cudatoolkit}
      export LD_LIBRARY_PATH=${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.cudatoolkit}/lib:${pkgs.cudaPackages.cudnn}/lib:${pkgs.cudatoolkit.lib}/lib:$LD_LIBRARY_PATH
      export EXTRA_LDFLAGS="-L/lib -L${pkgs.linuxPackages.nvidia_x11}/lib"
      export EXTRA_CCFLAGS="-I/usr/include"
   '';          
 }

