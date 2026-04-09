{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems =
        function: nixpkgs.lib.genAttrs systems (system: function (nixpkgs.legacyPackages.${system}));
    in
    {
      devShells = forAllSystems (
        pkgs:
        let
          pythonEnv = pkgs.python310.withPackages (
            ps: with ps; [
              mininet-python
            ]
          );
        in
        {
          default = pkgs.mkShell {
            packages = with pkgs; [
              pythonEnv
              hping
              tcpdump
              inetutils
            ];

            env = { };

            shellHook = "";
          };
        }
      );
    };
}
