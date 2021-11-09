{ lib
, stdenv
, buildPythonPackage
, fetchurl
, isPy37
, isPy38
, isPy39
, patchelf
, python
, pytorch-bin
}:

let
  pyVerNoDot = lib.replaceStrings [ "." ] [ "" ] python.pythonVersion;
  srcs = import ./binary-hashes.nix version;
  unsupported = throw "Unsupported system";
  version = "0.10.0";
in buildPythonPackage {
  inherit version;

  pname = "torchaudio";

  format = "wheel";

  src = fetchurl srcs."${stdenv.system}-${pyVerNoDot}" or unsupported;

  disabled = !(isPy37 || isPy38 || isPy39);

  nativeBuildInputs = [
    patchelf
  ];

  propagatedBuildInputs = [
    pytorch-bin
  ];

  # The wheel-binary is not stripped to avoid the error of `ImportError: libtorch_cuda_cpp.so: ELF load command address/offset not properly aligned.`.
  dontStrip = true;

  pythonImportsCheck = [ "torchaudio" ];

  postFixup = let
    rpath = lib.makeLibraryPath [ stdenv.cc.cc.lib ];
  in ''
    # Note: after patchelf'ing, libcudart can still not be found. However, this should
    #       not be an issue, because PyTorch is loaded before torchvision and brings
    #       in the necessary symbols.
    patchelf --set-rpath "${rpath}:${pytorch-bin}/${python.sitePackages}/torch/lib:" \
      "$out/${python.sitePackages}/torchaudio/_torchaudio.so"
  '';

  meta = with lib; {
    description = "PyTorch audio library";
    homepage = "https://pytorch.org/";
    changelog = "https://github.com/pytorch/audio/releases/tag/v${version}";
    # Includes CUDA and Intel MKL, but redistributions of the binary are not limited.
    # https://docs.nvidia.com/cuda/eula/index.html
    # https://www.intel.com/content/www/us/en/developer/articles/license/onemkl-license-faq.html
    license = licenses.bsd3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ junjihashimoto ];
  };
}
