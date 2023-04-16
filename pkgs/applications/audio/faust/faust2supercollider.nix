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


#        --set "$nix_cc_wrapper_target_host" "''${!nix_cc_wrapper_target_host}" \
#        --set "$nix_bintools_wrapper_target_host" "''${!nix_bintools_wrapper_target_host}" \

  postFixup = ''
    # export parts of the build environment
    for script in "$out"/bin/*; do
      # e.g. NIX_CC_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu
      nix_cc_wrapper_target_host="$(printenv | grep ^NIX_CC_WRAPPER_TARGET_HOST | sed 's/=.*//')"
      # e.g. NIX_BINTOOLS_WRAPPER_TARGET_HOST_x86_64_unknown_linux_gnu
      nix_bintools_wrapper_target_host="$(printenv | grep ^NIX_BINTOOLS_WRAPPER_TARGET_HOST | sed 's/=.*//')"
      wrapProgram "$script" \
        --set SUPERCOLLIDER_HEADERS "${supercollider}/include/SuperCollider/" \
        --set FAUSTLDDIR "${faust}/lib" \
        --set FAUSTLIB "${faust}/share/faust" \
        --set FAUSTINC "${faust}/include/faust" \
        --set FAUSTARCH "${faust}/share/faust" \
        --prefix PATH : "$PATH" \
        --prefix PKG_CONFIG_PATH : "$PKG_CONFIG_PATH" \
        --set NIX_CFLAGS_COMPILE "$NIX_CFLAGS_COMPILE" \
        --set NIX_LDFLAGS "$NIX_LDFLAGS -lpthread" \
        --prefix LIBRARY_PATH "$libPath"
    done
  '';
})
