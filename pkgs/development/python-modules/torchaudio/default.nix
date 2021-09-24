{ lib
, symlinkJoin
, buildPythonPackage
, fetchFromGitHub
, ninja
, which
, numpy
, pytorch
, pytest
}:
buildPythonPackage rec {
  pname = "torchaudio";
  version = "0.9.0";

  src = fetchFromGitHub {
    owner = "pytorch";
    repo = "audio";
    rev = "v${version}";
    sha256 = "0qj9bi4zihgbj1cklphsrf3n61nzlfx01j2q3dipga09ka4c97c1";
  };

  nativeBuildInputs = [ ninja which ];

  buildInputs = [ ];

  propagatedBuildInputs = [ numpy pytorch ];

  # tries to download many datasets for tests
  doCheck = false;

  checkPhase = ''
    HOME=$TMPDIR py.test test --ignore=test/test_datasets_download.py
  '';

  checkInputs = [ pytest ];

  meta = with lib; {
    description = "PyTorch audio library";
    homepage = "https://pytorch.org/";
    license = licenses.bsd3;
    platforms = with platforms; linux ++ darwin;
    maintainers = with maintainers; [ junjihashimoto ];
  };
}
