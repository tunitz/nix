{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      esbenp.prettier-vscode
      bbenoist.nix
      ms-azuretools.vscode-docker
    ] ++ [
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "bun-vscode";
        publisher = "oven";
        version = "0.0.32";
        sha256 = "sha256-VlruOHiF5/wVhVVW1rq6DEc90u3IwbxD/tpTXyphD+U=";
      })
      (pkgs.vscode-utils.extensionFromVscodeMarketplace {
        name = "hono";
        publisher = "hono";
        version = "0.0.3";
        sha256 = "sha256-Tu/Zx4rjrXn4GschwZhZvF7A/gDn3mk+RzpeSb3J1Zg=";
      })
    ];
  };
}