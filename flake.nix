{
  description = "CrowdSec Blocklist Import - Python dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        pythonEnv = pkgs.python3.withPackages (
          ps: with ps; [
            requests
            prometheus-client
            python-dotenv
          ]
        );
      in
      {
        devShells.default = pkgs.mkShell {
          name = "blocklist-import";

          packages = [
            pythonEnv
          ];

          shellHook = ''
            echo "🐍 blocklist_import dev shell ready"
            echo "Python: $(python --version)"
            echo "Run: python blocklist_import.py"
          '';
        };
      }
    );
}
