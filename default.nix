let
  lock = builtins.fromJSON (builtins.readFile ./flake.lock);
  inherit (lock.nodes.flake-compat.locked) rev;
  flake-compat = builtins.fetchTarball {
    url = "https://github.com/edolstra/flake-compat/archive/${rev}.tar.gz";
    sha256 = lock.nodes.flake-compat.locked.narHash;
  };
in

{ pkgs ? import <nixpkgs> {} }:

let
  pkgs' = pkgs.extend ((import flake-compat { src =  ./.; }).defaultNix.overlay);
in

{
  inherit (pkgs') vimExtraPlugins;
}
