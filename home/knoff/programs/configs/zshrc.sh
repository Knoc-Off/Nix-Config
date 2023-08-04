# ~/.zshrc

PS1=" %F{3}%3~ %f%# "

## DirEnv Config
eval "$(direnv hook zsh)"

# Silence Direnv output:
export DIRENV_LOG_FORMAT=

new_kitty() {
    kitty --detach --directory "$(pwd)"
}

# Open in chrome:
chrome() {
  nix-shell -p ungoogled-chromium --run "(chromium $1 &>/dev/null) &"
}

nixx () {
    if [[ $1 == "sudo" ]]; then
        sudo nix-shell -p $2 --run "$2 ${@:3}"
    else
        nix-shell -p $1 --run "$1 ${@:2}"
    fi
}

# Open in firefox:
# open in specific profile
# open in profile with name minimal
firefox() {
    if [[ $1 == "--profile" ]]; then
        nix-shell -p firefox --run "(firefox --profile $2 $3 &>/dev/null) &"
    elif [[ $1 == "--private" ]]; then
        nix-shell -p firefox --run "(firefox --private-window $2 &>/dev/null) &"
    else
        nix-shell -p firefox --run "(firefox $1 &>/dev/null) &"
    fi
}


# function to start a wireguard connection with a given config
# uses nix-shell -p wireguard-tools --run (wg-quick up $1 &>/dev/null) &
# check if the first argument is up/down
wg() {
    if [[ $1 == "up" ]]; then
        nix-shell -p wireguard-tools --run "sudo wg-quick up $2"
    elif [[ $1 == "down" ]]; then
        nix-shell -p wireguard-tools --run "sudo wg-quick down $2"
    else
        echo "Usage: wg up/down <config>"
    fi
}


# Should search for a matching word in apps
function nx () {
    config_dir="/home/knoff/Nix-Config" #$(realpath "~/nix-config")
    case $1 in
      rb)
        sudo nixos-rebuild switch --flake $config_dir/#lapix
        ;;
      rh)
        home-manager switch --flake $config_dir/#knoff@lapix
        ;;
      rt)
        sudo nixos-rebuild test --flake $config_dir/#lapix
        ;;
      vm)
          # get output of command, find line with the directory,
          # starts with: /nix/store/ ... -vm
          #  then run that file

          sudo nixos-rebuild build-vm --flake $config_dir/#lapix
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

sanitized_input="$*"

  echo "${sanitized_input}" | qrencode -t UTF8
}
