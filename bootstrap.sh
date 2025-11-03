#!/usr/bin/env bash

# symlink by default, else i end up with discrepancy between my dotfiles and my dotfiles repos
# because of quick hacking in the heat of the moment...
METHOD="symlink";
FORCE=false;
DEST="$HOME";

function rsyncIt() {
  rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
    --exclude "README.md" --exclude "LICENSE-MIT.txt" -avh --no-perms . ~;
  source ~/.bash_profile;
}

function symlinkIt() {
  filesToLoop=$1;
  homeDir=$2;
  force=${3-false};

  if [[ -z "$filesToLoop" || -z "$homeDir" ]]; then
    echo "Missing params";
    exit;
  fi

  for fileName in $filesToLoop
  do
    if [ -d "$fileName" ]; then
      continue;
    fi

    if [[ -f "$homeDir/$fileName" || -L "$homeDir/$fileName" ]]; then
      if [ "$force" != true ]; then
        read -p "Override $fileName? (y/n) " -n 1;
        echo "";
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
          echo "Skipping...";
          continue;
        fi
      fi
    fi

    echo "Creating symlink...";
    ln -sf "`pwd`/$fileName" "$homeDir/$fileName";
  done
}

while getopts "m:f" OPTION
do
  case $OPTION in
      m)
        METHOD=${OPTARG};;
      f)
        FORCE=true;;
  esac
done

if [ "$METHOD" = "symlink" ]; then
  symlinkIt ".*" "$DEST" "$FORCE";
fi;

if [ "$METHOD" = "rsync" ]; then
  if [ "$FORCE" == true ]; then
    rsyncIt;
  else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      symlinkIt;
    fi;
  fi;
fi;

unset rsyncIt;
unset symlinkIt;
