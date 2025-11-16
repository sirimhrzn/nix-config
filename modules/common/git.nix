{
  lib,
  config,
  ...
}: let
  inherit (lib) mkAfter enabled merge mkIf;
in {
  home-manager.sharedModules = [
    (homeArgs: let
      config' = homeArgs.config;
      gitUrl = "https://github.com/";
    in {
      programs.nushell.configFile.text =
        mkAfter
        /*
        nu
        */
        ''
          # Sets the remote origin to the specified user and repository on my git instance
          def gsr [user_and_repo: string] {
            let user_and_repo = if ($user_and_repo | str index-of "/") != -1 {
              $user_and_repo
            } else {
              "sirimhrzn/" + $user_and_repo
            }

            git remote add origin ("${gitUrl}" + $user_and_repo)
          }
        '';

      programs.difftastic = enabled {
        git = enabled {};
      };
      programs.git = enabled {

        lfs = enabled;

        settings =
          merge {
            init.defaultBranch = "master";

            commit.verbose = true;

            log.date = "iso";
            column.ui = "auto";

            branch.sort = "-committerdate";
            tag.sort = "version:refname";

            diff.algorithm = "histogram";
            diff.colorMoved = "default";

            pull.rebase = true;
            push.autoSetupRemote = true;

            merge.conflictStyle = "zdiff3";

            rebase.autoSquash = true;
            rebase.autoStash = true;
            rebase.updateRefs = true;
            rerere.enabled = true;

            fetch.fsckObjects = true;
            receive.fsckObjects = true;
            transfer.fsckobjects = true;

            user.email = "sirimaharjan@proton.me";
            user.name = "sirimhrzn";
           

            # https://bernsteinbear.com/git
            alias.recent = "! git branch --sort=-committerdate --format=\"%(committerdate:relative)%09%(refname:short)\" | head -10";
          }
          <| mkIf config.isDesktop {
            core.sshCommand = "ssh -i ~/.ssh/id_rsa";
            url."ssh://git@github.com/".insteadOf = "https://github.com/";
            commit.gpgSign = true;
            tag.gpgSign = true;

            gpg.format = "ssh";
            user.signingKey = "~/.ssh/id";
          };
      };
    })
  ];
}
