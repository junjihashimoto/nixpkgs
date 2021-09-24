# Warning: use the same CUDA version as pytorch-bin.
#
# Precompiled wheels can be found at:
# https://download.pytorch.org/whl/torch_stable.html

# To add a new version, run "prefetch.sh 'new-version'" to paste the generated file as follows.

version : builtins.getAttr version {
  "0.9.0" = {
    x86_64-linux-37 = {
      name = "torchaudio-0.9.0-cp37-cp37m-linux_x86_64.whl";
      url = "https://download.pytorch.org/whl/torchaudio-0.9.0-cp37-cp37m-linux_x86_64.whl";
      hash = "sha256-GHY8Bct9haCLjqlg5A9phOlROwLnb0Um2SBJPHAbBnE=";
    };
    x86_64-linux-38 = {
      name = "torchaudio-0.9.0-cp38-cp38-linux_x86_64.whl";
      url = "https://download.pytorch.org/whl/torchaudio-0.9.0-cp38-cp38-linux_x86_64.whl";
      hash = "sha256-xhJlVtUp33O2duAjBjOI1VG+PAyy1CpP9cTP1E7z4BI=";
    };
    x86_64-linux-39 = {
      name = "torchaudio-0.9.0-cp39-cp39-linux_x86_64.whl";
      url = "https://download.pytorch.org/whl/torchaudio-0.9.0-cp39-cp39-linux_x86_64.whl";
      hash = "sha256-718LImRqlPlYaQAbQKuUBGixrjmdD/07xz1cQzQqATo=";
    };
  };
}
