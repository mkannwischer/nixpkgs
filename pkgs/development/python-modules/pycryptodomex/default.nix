{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  gmp,
  setuptools,
}:

# pycryptodomex is discontinued since 4.0; upstream only patches the 3.x branch.
buildPythonPackage rec {
  pname = "pycryptodomex";
  version = "3.24.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "Legrandin";
    repo = "pycryptodome";
    tag = "v${version}x";
    hash = "sha256-g0JPH82j/uVDbvgvv9ZVHGIPGUfthTurXXFyDst9ato=";
  };

  postPatch = ''
    substituteInPlace lib/Crypto/Math/_IntegerGMP.py \
      --replace-fail 'load_lib("gmp"' 'load_lib("${gmp}/lib/libgmp.so.10"'
  '';

  build-system = [ setuptools ];

  pythonImportsCheck = [ "Cryptodome" ];

  meta = {
    description = "Self-contained cryptographic library (Cryptodome namespace)";
    homepage = "https://github.com/Legrandin/pycryptodome";
    changelog = "https://github.com/Legrandin/pycryptodome/blob/${src.tag}/Changelog.rst";
    license = with lib.licenses; [
      bsd2 # and
      asl20
    ];
    maintainers = with lib.maintainers; [ fab ];
  };
}
