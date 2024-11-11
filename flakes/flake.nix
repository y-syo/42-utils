{
  description = "a development environment for the c programming language";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
  };

  outputs = { self, flake-utils, nixpkgs, ... }:
  flake-utils.lib.eachDefaultSystem(system:
  let
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.default = pkgs.mkShell {
	  packages = with pkgs; [ clang gcc norminette valgrind gdb ];
	  hardeningDisable = [ "all" ];
	  buildInputs = with pkgs; [];
	  shellHook = ''
		echo -e "\x1B[0;33mentering c environment...\x1B[0m"
	  '';
	};
  });
}
