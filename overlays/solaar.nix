final: prev:
let
  lib = prev.lib;
in
{
  solaar = prev.solaar.overrideAttrs (old: rec {
    version = "1.1.19";
    src = prev.fetchFromGitHub {
      owner = "pwr-Solaar";
      repo = "Solaar";
      tag = version;
      hash = "sha256-KYxG0VdRpfqkcRLmur3HTg8iYycv9oZYz3JWTpxutFI=";
    };
    preConfigure = ''
      substituteInPlace lib/solaar/listener.py \
      --replace-fail getfacl "${lib.getExe' prev.acl "getfacl"}"
    '';
  });
}
