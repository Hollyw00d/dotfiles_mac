###### Location of this File ######
# File located at: `Users/mattj/.oh-my-zsh/custom/aliases.zsh`

###### Setup Files ######
alias npmglobalwrite='SCRIPT_PATH="$HOME/setup-scripts/write-npm-packages.sh"; chmod +x "$SCRIPT_PATH" && bash "$SCRIPT_PATH"'
alias npmglobalinstall='SCRIPT_PATH="$HOME/setup-scripts/install-npm-packages.sh"; chmod +x "$SCRIPT_PATH" && bash "$SCRIPT_PATH"'
alias chezmoiadd='SCRIPT_PATH="$HOME/setup-scripts/chezmoi-add-items.sh"; chmod +x "$SCRIPT_PATH" && bash "$SCRIPT_PATH"'

###### Profile Files ######
# zprofile
alias profile="cd; vim ~/.zshrc"
alias profileopen="cd; code .zshrc"
alias refresh="source ~/.zshrc"
alias envrefresh="source ~/.zshenv"

# oh my zsh profile
alias aliases="cd ~/.oh-my-zsh/custom; vim aliases.zsh;"
alias aliasesopen="cd ~/.oh-my-zsh/custom; code aliases.zsh; cd;"

# Open "resources" directory
alias resourcesopen="cd ~/Desktop/updates/resources; code .;"

###### Hosts File ######
alias hostscmds="echo 'cd; sudo vim /etc/hosts'; echo 'sudo killall -HUP mDNSResponder'"
alias hostsopen="cd /etc; code hosts"
alias hostskillcache="sudo killall -HUP mDNSResponder"

###### Homebrew Commands ######
alias brewcmds="echo -e 'brew update\nbrew upgrade\nbrew doctor'"

###### SSH Commands ######
mjsshkey="mj_private"
alias sshcmds="ls -al ~/.ssh; echo 'ssh-add ~/.ssh/$mjsshkey'; echo 'pbcopy < ~/.ssh/$mjsshkey.pub'; echo 'ssh-add -l'; echo 'ssh-add -D'; echo -e 'eval \$(ssh-agent -s)'; echo 'ssh-copy-id username@webhost.com'; echo 'ssh-add -K'"

mjsshadd="ssh-add ~/.ssh/$mjsshkey"
sshagent="eval \$(ssh-agent -s);"
mjsshaddk="ssh-add --apple-use-keychain ~/.ssh/$mjsshkey;"

# Run all SSH commands at once to authenticate with GitHub, GitLab, other services
alias sshauth="$mjsshadd $sshagent $mjsshaddk"

###### Show Node.js, nvm (Node Version Manager), Homebrew, MongoDB Commands ######
alias nodecmds="echo '**Mac Homebrew to Update Node**'; echo 'brew update'; echo 'brew doctor'; echo 'brew upgrade node'; echo ''; echo '**Node ONLY**'; echo 'node-v'; echo 'npm list -g --depth=0'; echo 'node init'; echo 'npm install express --save'; echo ''; echo '**Node Version Manager**'; echo 'nvm ls'; echo 'nvm install 5.5.0'; echo 'nvm use 5.5.0'; echo 'nvm uninstall 5.5.0'; echo 'nvm alias default system'; echo 'nvm use system'; echo ''; echo '**MongoDB Startup**'; echo 'cd; cd mongo/bin'; echo './mongod --dbpath ~/mongo-data'; echo ''; echo '**Start Mongo Using Homebrew**'; echo 'brew services start mongo'; echo 'OR'; echo 'mongod';"
alias nodechangev="node -v; echo '**Upgrade to v16.10.0**'; echo 'npm i -g n'; echo 'sudo n 16.10.0'; echo ''; echo '**Downgrade to v14.17.0**'; echo 'npm i -g n'; echo 'sudo n 14.17.0';"

###### PHP ######
## Change PHP version function, example:
## `phpv 7.2` to switch to PHP version 7.2
function phpv() { 
  if ! command -v brew > /dev/null 2>&1 || ! brew list brew-php-switcher > /dev/null 2>&1 || [[ -z "$1" ]]; then
    echo "Unfortunately, your PHP version change attempt failed.\n\n- An example of this command is 'phpv 7.2' to change to PHP ver. 7.2.\n- Also you must have both the Homebrew and 'brew-php-switcher' Homebrew packages installed."
    # Exit script with an error
    return 1
  fi

  local version="$1"
  # Install the specified PHP version
  brew install --quiet php@"$version"
  # Switch to the specified PHP version
  brew-php-switcher "$version"

  if command -v apachectl > /dev/null 2>&1; then
    # Stop apache from running, as this
    # causes port 80 conflicts with Localwp.com app
    # and possible other localhost software 
    sudo apachectl stop
  fi
  # Display the active PHP version
  php -v
}

###### Localwp, Apache, and Port 80 Probs Fix ######
## Stop Apache
alias apachestop="sudo apachectl stop"
## Start Apache
alias apachestart="sudo apachectl start"
## View port 80 processes
## that may need to be killed for Localwp to work
alias port80view="sudo lsof -i :80"
## Example to kill a process
## for Localwp to work
alias killprocess="echo -e 'EXAMPLE PROCESS TO KILL:\nkill -9 7741'"
## Run Localwp shell that kicks off WP-CLI & 
## access to mysql shell
alias localshell='sh "$(ls -t ~/Library/Application\ Support/Local/ssh-entry/*.sh | head -n 1)"'

###### Git and GitHub CLI Commands ######
# View last 10 commands in --oneline format
alias gitlogsm="git log -10 --oneline"

# Install GitHub CLI on a Mac (see https://github.com/cli/cli#installation):
# brew install gh

# Authenticate with a GitHub host
alias ghauth="gh auth login"

# variables assigned to git info
## View current branch
currentgitbranch=\$(git symbolic-ref --short HEAD)

# General git aliases
## Push newly created branch to Github
alias gitnewpush="git push -u origin $currentgitbranch"
## Delete all local git branches except for "develop"
alias gitpurge='git branch | egrep -v "(develop|staging|production|main)" | xargs git branch -D'

# gh cli aliases
## View default branch in GitHub website
alias ghmainrepo="gh repo view --web"
## Open current branch in GitHub website
alias ghrepo="gh repo view --web --branch $currentgitbranch"

###### Copy command output to clipboard ######
## Example:
## cpycmd brew doctor
function cpyout() {
  ## Trim leading/trailing spaces and check if input is empty or "cpy"
  if [[ -z "${*// /}" ]]; then
    return 0  # Exit silently with no output
  fi

  ## IF `clipboard-cli` npm package is installed globally,
  ## copy command output with this `clipboard` to clipboard
  ## (from `clipboard-cli` npm package) and output command to terminal,
  ## ELSE echo that command failed as `clipboard-cli` npm package
  ## must be installed globally to make it work
  if command -v clipboard > /dev/null 2>&1; then
    "$@" 2>&1 | clipboard
    "$@"
  else 
    echo "Command failed as you must install the 'clipboard-cli' npm package globally by doing: 'npm install -g clipboard-cli'"
  fi
}

###### Output image sizes in current directory ######
## Use `exiftool` Hombrew package and `sort` (installed on Mac and Linux)
function imgsizes() {
  exiftool -p '$FileName ($ImageWidth x $ImageHeight) $FileSize' . | sort -t. -k2
}

###### Miscellaneous ######
# Delete .DS_Store junk file on Mac
alias deletejunk="rm -rf .DS_Store"

# Show/hide files
alias showfiles="defaults write com.apple.finder AppleShowAllFiles true; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles false; killall Finder"

###### Directory Navigation, Run Scripts, Open Files with VS Code ######
# .sh Scripts directory
alias scriptsopen="cd ~/Desktop/updates/scripts; code .;"
alias openurls="cd ~/Desktop/updates/scripts; ./open-urls.sh"

# Open notes
alias notesopen="cd ~/Desktop/updates/resources; code zzz-notes.txt; cd;"
alias notesdiropen="cd ~/Desktop/updates/resources; code .; cd;"

# Go to Desktop or Projects
alias desktop="cd ~/Desktop"
alias projects="cd ~/Desktop/projects"

# MJ.net
alias mjnet="cd ~/Desktop/projects/mj.net/app/public"
alias mjnettheme="cd ~/Desktop/projects/mj.net/app/public/wp-content/themes/MJ-net-2012"

# Learning
## React 18 Tutorial and Projects Course (2023) -- Udemy by John Smilga
alias udemy1="cd ~/Desktop/projects/create-react-app-udemy-course1"
## Introduction to React JS - Bare Bones
alias reactvite="cd ~/Desktop/projects/introduction-to-react-js-bare-bones"
## Mastering React With Interview Questions,eStore Project-2023 (Udemy course) by Nirmal Joshi
alias udemy3="cd ~/Desktop/projects/mastering-react-with-interview-questions-udemy"
## The Ultimate Authentication Course with NodeJS and React (Udemy) by Antonio Papa - https://www.udemy.com/course/react-node-authentication
alias nodeauth="cd ~/Desktop/projects/auth-with-node-react-json-web-tokens"

# React Projects
## React Setup from Scratch using Functional Components and with AirBnB and A11y (Accessibility) ESLint Rules
alias reactjs="cd ~/Desktop/projects/react-setup-from-scratch-with-functional-components-airbnb-a11y-linting"
## React Setup from Scratch using TypeScript and Functional Components and with AirBnB and A11y (Accessibility) ESLint Rules
alias reactts="cd ~/Desktop/projects/react-setup-from-scratch-with-typescript-functional-components-airbnb-a11y-linting"

# WP Playground
alias wpplay="cd ~/Desktop/projects/mjwpprod/app/public"
alias wpplugins="cd ~/Desktop/projects/mjwpprod/app/public/wp-content/plugins"

# Custom Plugins
alias weekly1="cd ~/Desktop/projects/mjwpprod/app/public/wp-content/plugins/weekly-meetings-list-block"
alias json1="cd ~/Desktop/projects/mjwpprod/app/public/wp-content/plugins/json-placeholder-block"


# Random
alias godaddy1="cd ~/Desktop/projects/godaddy1/app/public"
alias godaddy1theme="cd ~/Desktop/projects/godaddy1/app/public/wp-content/themes/astra-child"
alias godaddy1block="cd ~/Desktop/projects/godaddy1/app/public/wp-content/plugins/meetings-table-block"