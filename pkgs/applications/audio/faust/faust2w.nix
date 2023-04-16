{ faust
, makeWrapper
, stdenv
}@args:

stdenv.mkDerivation {

  name = "faust2w";

  dontUnpack = true;
 
  nativeBuildInputs = [ makeWrapper ];

  propagatedBuildInputs = [ faust ];

  installPhase = ''
  '';
  postFixup = ''
    ln  -s "${faust}/bin/faust" "$out/faust2w" 
    # export parts of the build environment
    wrapProgram "$out/faust2w" \
        --add-flags "-I ${faust}/share/faust" \
        --add-flags "-A ${faust}/include"
  '';
}
