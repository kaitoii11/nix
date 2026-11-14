{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Your Name"; # 要変更
      user.email = "you@example.com"; # 要変更
      init.defaultBranch = "main";
      pull.rebase = true;
      alias = {
        st = "status -sb";
        lg = "log --oneline --graph --decorate";
      };
    };
    ignores = [
      ".direnv/"
      "result"
      ".DS_Store"
    ];
  };
}
