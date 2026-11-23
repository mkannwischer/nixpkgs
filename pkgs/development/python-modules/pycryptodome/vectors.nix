{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
}:

buildPythonPackage rec {
  pname = "pycryptodome-test-vectors";
  version = "1.0.34";
  pyproject = true;

  src = fetchPypi {
    pname = "pycryptodome_test_vectors";
    inherit version;
    hash = "sha256-2CZ7jUs0FmvEwk7aPZrEO9lG+qjOO7IdSc431DhRPcA=";
  };

  nativeBuildInputs = [ setuptools ];

  # Module has no tests
  doCheck = false;

  pythonImportsCheck = [ "pycryptodome_test_vectors" ];

  meta = {
    description = "Test vectors for PyCryptodome cryptographic library";
    homepage = "https://www.pycryptodome.org/";
    license = with lib.licenses; [
      bsd2 # and
      asl20
    ];
    maintainers = with lib.maintainers; [ fab ];
  };
}
