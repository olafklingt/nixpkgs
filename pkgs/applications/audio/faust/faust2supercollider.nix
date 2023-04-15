{ faust
, supercollider
, makeWrapper
, stdenv
}@args:

stdenv.mkDerivation (faust.faust2ApplBase (args // {
  baseName = "faust2supercollider";
})) // {

  nativeBuildInputs = [ makeWrapper ];

  propagatedBuildInputs = [ faust supercollider];

  postInstall = ''
  '';

  postFixup = ''
    # export parts of the build environment
    for script in "$out"/bin/*; do
       wrapProgram "$script" \
        --set SUPERCOLLIDER_HEADERS "${supercollider}/include/SuperCollider/" \
         --prefix PATH : "$PATH"
     done
   '';
}
