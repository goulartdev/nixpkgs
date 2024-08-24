{
  lib,
  buildNpmPackage,
  fetchurl,
  nodejs,
}:
buildNpmPackage rec {
  pname = "angular-language-server";
  version = "18.2.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/@angular/language-server/-/language-server-${version}.tgz";
    hash = "sha256-UvYOxs59jOO9Yf0tvX96P4R/36qPeEne+NQAFkg9Eis=";
  };

  npmDepsHash = "sha256-ixNxbkozEiNolVWUGFFIomq2/D9xYGo4ibiw3urTrrs=";

  postPatch = ''
    cp ${./package-lock.json} ./package-lock.json
  '';

  npmInstallFlags = [ "--omit dev" ];

  dontNpmBuild = true;

  postInstall = ''
    makeWrapper ${nodejs}/bin/node $out/bin/ngserver --add-flags "$out/lib/node_modules/@angular/language-server/bin/ngserver --ngProbeLocations $out/lib/node_modules/@angular/language-server"
  '';

  meta = {
    changelog = "https://github.com/angular/vscode-ng-language-service/releases/tag/v${version}";
    description = "LSP server for Angular Language Service";
    homepage = "https://github.com/angular/vscode-ng-language-service";
    license = lib.licenses.mit;
    mainProgram = "angular-language-server";
    maintainers = with lib.maintainers; [ goulartdev ];
  };
}
