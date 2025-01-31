{
  lib,
  stdenv,
  fetchFromGitHub,
  callPackage,
}:
stdenv.mkDerivation {
  name = "gpu.cpp";
  version = "0.2.0";
  src = fetchFromGitHub {
    owner = "AnswerDotAI";
    repo = "gpu.cpp";
    rev = "ec68b142d82bcb09a08af41e3134adfcc1bde188";
    hash = "sha256-UM/g+F3PEmYfAtQcVEUNnCqDsqlsUdSwbQXPn/2Cxv4=";
  };

  phases = ["installPhase"];
  installPhase = ''
    mkdir -p $out/include
    cp $src/gpu.hpp $out/include
    cp -r $src/utils $out/include
    cp -r $src/numeric_types $out/include
    cp -r $src/experimental $out/include
  '';
  passthru.tests.cmake = callPackage ./test {
  };

  meta = with lib; {
    description = "A lightweight library for portable low-level GPU computation using WebGPU.";
    homepage = "https://github.com/AnswerDotAI/gpu.cpp";
    license = licenses.asl20;
    maintainers = with maintainers; [ junjihashimoto ];
  };
}
