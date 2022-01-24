{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dbmate";
  version = "1.13.0";

  src = fetchFromGitHub {
    owner = "amacneil";
    repo = "dbmate";
    rev = "v${version}";
    sha256 = "sha256-j7u8TidiuaA5SbXoD+p23wwTsePi6/hzNdVS5IJMEh0=";
  };

  vendorSha256 = "sha256-GEJ8n0VN9Qt73dRj7Qjx1DAomSy+hQEH74Dx2h/hv9M=";

  doCheck = false;

  meta = with lib; {
    description = "Database migration tool";
    homepage = "https://github.com/amacneil/dbmate";
    license = licenses.mit;
    maintainers = [ maintainers.manveru ];
    platforms = platforms.unix;
  };
}
