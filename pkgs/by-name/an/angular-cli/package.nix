{
  lib,
  buildNpmPackage,
  fetchurl,
}:
buildNpmPackage rec {
  pname = "angular-cli";
  version = "18.2.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/@angular/cli/-/cli-${version}.tgz";
    hash = "sha256-OVKwAKpLP/kuXCuBIFtuXmeit/mU9Ttb/kHHAH3q6jk=";
  };

  npmDepsHash = "sha256-oVqMsPxDZHj3gQgGPbLffL8HKev0Az8NF7RWLQkHu3E=";

  postPatch = ''
    cp ${./package-lock.json} ./package-lock.json
  '';

  npmInstallFlags = [ "--omit dev" ];

  dontNpmBuild = true;

  meta = {
    changelog = "https://github.com/angular/angular-cli/releases/tag/v${version}";
    description = "CLI tool for Angular";
    homepage = "https://angular.dev/cli";
    license = lib.licenses.mit;
    mainProgram = "angular-cli";
    maintainers = with lib.maintainers; [ goulartdev ];
  };
}
