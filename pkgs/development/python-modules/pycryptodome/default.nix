{
  lib,
  buildPythonPackage,
  callPackage,
  fetchFromGitHub,
  python,
  pytest,
  setuptools,
}:

let
  test-vectors = callPackage ./vectors.nix { };
in
buildPythonPackage rec {
  pname = "pycryptodome";
  version = "4.6.0";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Legrandin";
    repo = "pycryptodome";
    tag = "v${version}";
    hash = "sha256-JZgNPikN4Wl4ky44zQt66zAVk1udA4B+HwPGbQKRdik=";
  };

  build-system = [ setuptools ];

  nativeCheckInputs = [
    pytest
    test-vectors
  ];

  checkPhase = ''
    runHook preCheck
    ${python.interpreter} -m Crypto.SelfTest --skip-slow-tests
    runHook postCheck
  '';

  pythonImportsCheck = [ "Crypto" ];

  meta = {
    description = "Self-contained cryptographic library";
    homepage = "https://github.com/Legrandin/pycryptodome";
    changelog = "https://github.com/Legrandin/pycryptodome/blob/${src.tag}/Changelog.rst";
    license = with lib.licenses; [
      bsd2 # and
      unlicense # and
      mit
    ];
    maintainers = with lib.maintainers; [ fab ];
  };
}
