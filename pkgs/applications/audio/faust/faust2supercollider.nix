{ faust
, supercollider
, pkg-config
, makeWrapper
, stdenv
}@args:

stdenv.mkDerivation ((faust.faust2ApplBase (args // {
  baseName = "faust2supercollider";
})) // {

  nativeBuildInputs = [ pkg-config makeWrapper ];

  propagatedBuildInputs = [ faust supercollider];

  postInstall = ''
  '';

#        --prefix PKG_CONFIG_PATH : "$PKG_CONFIG_PATH" \
#        --set NIX_CFLAGS_COMPILE "$NIX_CFLAGS_COMPILE" \
#        --set NIX_LDFLAGS "$NIX_LDFLAGS -lpthread" \
#        --prefix LIBRARY_PATH "$libPath"
#        --prefix PATH : "$PATH" 

  postFixup = ''
    # export parts of the build environment
    for script in "$out"/bin/*; do
      wrapProgram "$script" \
        --set SUPERCOLLIDER_HEADERS "${supercollider}/include/SuperCollider/" \
        --set FAUSTLDDIR "${faust}/lib" \
        --set FAUSTLIB "${faust}/share/faust" \
        --set FAUSTINC "${faust}/include/faust" \
        --set FAUSTARCH "${faust}/share/faust" \
    done
  '';
})
