{
     # Git config using Home Manager modules
  programs.git = {
    enable = true;
    userName = "zell992004";
    userEmail = "zell992004@gmail.com";
    aliases = {
      st = "status";
    };
  };
  programs.git-credential-oauth = {
	enable = true;
 };
}
