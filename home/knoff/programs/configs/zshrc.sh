# ~/.zshrc

## DirEnv Config
eval "$(direnv hook zsh)"

# Silence Direnv output:
export DIRENV_LOG_FORMAT=

new_kitty() {
    kitty --detach --directory "$(pwd)"
}

# Open in chrome:
# I want to intigrate this into nixx, so you can specify arguments per package. or mute output.
chrome() {
  nix-shell -p ungoogled-chromium --run "(chromium $1 &>/dev/null) &"
}

# nix shell made "easy"
nixx () {
  _sudo=0
  package=$1;
  if [[ $1 == "sudo" ]]; then
    package=$2
    _sudo=1
  fi;

  # Check some local database/ dict, that takes package as arg, and then looks up executable.
  if [[ $_sudo == 1 ]]; then
    nix-shell -p "$package" --run "sudo $package";
    return
  fi

  nix-shell -p "$package" --run "$package";
}
PS1=" %F{3}%3~ %f%# "

# Should search for a matching word in apps
function nx () {
  config_dir="/home/knoff/Nix-Config" #$(realpath "~/nix-config")
  if [ ! "$1" ]; then
    exa -T $config_dir
  else
    case $1 in
      rb)
        sudo nixos-rebuild switch --flake $config_dir/#lapix
        ;;
      rh)
        home-manager switch --flake $config_dir/#knoff@lapix
        ;;
      rt)
        sudo nixos-rebuild test --flake $config_dir/#knoff
        ;;
      cd)
        file=$(fd . $config_dir/ --type=d -E .git -H | fzf --query "$@")
        if [[ $file == "" ]]; then return; fi
        cd "$file"
        ;;
      cf)
        file=$(fd . $config_dir/*/configs/ -E .git -E .nix -H | fzf --query "$@")
        if [[ $file == "" ]]; then return; fi
        nvim "$file"
        ;;
      *)
        file=$(fd . $config_dir -e nix -E .git -H | fzf --query "$@")
        if [[ $file == "" ]]; then return; fi
          nvim "$file"
        ;;
    esac
  fi
}

function nix-shellgen () {
  if [[ ! -f ./.envrc ]]; then
    echo "use nix" > .envrc;
  fi

  if [[ ! -f ./shell.nix ]]; then
    printf "{ pkgs ? import <nixpkgs> {},  unstable ? import <unstable> {}}:\npkgs.mkShell {\n  buildInputs = [\n  ];\n  shellHook = ''\n  '';\n}\n" > shell.nix;
  fi
  direnv allow
}


qr () {
  if [[ $1 == "--share" ]]; then
    declare -f qr | qrencode -t UTF8;
  return
  fi
  local S
  if [[ "$#" == 0 ]]; then
    IFS= read -r S
    set -- "$S"
  fi
  echo "${1}" | qrencode -t UTF8
}

