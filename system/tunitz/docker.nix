{ pkgs, ... }:

{
  # Enable docker
	virtualisation.docker.enable = true;

  # Enable docker compose
  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}