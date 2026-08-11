{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "tunitz";
        email = "labillar@tunitz.com";
      };
      init.defaultBranch = "main";
    };
  };
}