{
  description = "The Bareflank Processor Abstraction Layer";

  inputs = {
    mars-std.url = "github:mars-research/mars-std";
  };

  outputs = { self, mars-std, ... }: let
    # System types to support.
    supportedSystems = [ "x86_64-linux" ];

    # Rust nightly version.
    nightlyVersion = "2021-08-01";
  in mars-std.lib.eachSystem supportedSystems (system: let
    pkgs = mars-std.legacyPackages.${system};

    rustNightly = pkgs.rust-bin.nightly.${nightlyVersion}.default.override {
      extensions = [ "rust-src" "rust-analyzer-preview" ];
      targets = [ "x86_64-unknown-linux-gnu" ];
    };
  in {
    devShell = pkgs.mkShell {
      nativeBuildInputs = with pkgs; [
        rustNightly

        nasm cmake
      ] ++ (with pkgs.python3Packages; [
        lxml pyyaml colorama
      ]);
    };
  });
}
