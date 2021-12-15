{
  description = "My flake for NUR";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };
    vim-plugins.url = "github:m15a/nixpkgs-vim-plugins";
  };

  outputs = { self, nixpkgs, flake-utils, vim-plugins, ... }:
  {
    overlay = nixpkgs.lib.composeManyExtensions [
      vim-plugins.overlay
    ];
  } // (flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = import nixpkgs {
      inherit system;
      overlays = [ self.overlay ];
    };
  in
  {
    packages = {
      inherit (pkgs) vimExtraPlugins;
    };
  }));
}
