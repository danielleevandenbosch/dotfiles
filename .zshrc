# Luke's config for the Zoomer Shell

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/history"

# Load aliases and shortcuts if existent.
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/shortcutrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/aliasrc"
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc" ] && source "${XDG_CONFIG_HOME:-$HOME/.config}/shell/zshnameddirrc"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp -uq)"
    trap 'rm -f $tmp >/dev/null 2>&1 && trap - HUP INT QUIT TERM PWR EXIT' HUP INT QUIT TERM PWR EXIT
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' '^ulfcd\n'

bindkey -s '^a' '^ubc -lq\n'

bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'

bindkey '^[[P' delete-char

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# Load syntax highlighting; should be last.
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

# List all files in long format
alias ll='ls -alh'

# List all files, including hidden files, in long format
alias la='ls -la'

# Clear the screen
alias cls='clear'

# Alias for grep with color
alias grep='grep --color=auto'


# windows back compat

# Clear the terminal screen
alias cls='clear'

# Display the IP configuration
alias ipconfig='ip a'

# Ping with a default of 4 attempts (similar to the default behavior in Windows)
alias ping='ping -c 4'

# Display disk usage in a human-readable format
alias diskusage='df -h'

# Show free memory
alias mem='free -h'

# List open network ports
alias netstat='ss -tulwn'

# Copy, move, and remove operations, prefixed with 'win' to avoid naming conflicts
alias copy='cp'
alias move='mv'
alias del='rm -rf'
alias ren='mv'

alias vim="nvim"


function headll {
    ll | head
}
function tailll {
    ll | tail
}

alias headll=headll
alias tailll=tailll
clip() {
  if [ -f "$1" ]; then
    cat "$1" | xclip -selection clipboard
    echo "Contents of $1 copied to clipboard."
  else
    echo "File not found: $1"
  fi
}

export EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias cdhtml='cd /var/www/html'

gacp()
{
    git add -A
    echo "Enter commit message: "
    read commitMessage
    git commit -m "$commitMessage"
    git push
}

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
export PATH=$JAVA_HOME/bin:$PATH
xset r rate 300 50

# Zsh History Configuration
setopt APPEND_HISTORY
setopt SHARE_HISTORY
HISTSIZE=10000
SAVEHIST=20000
HISTFILE=~/.zsh_history

alias olddatagrip='/opt/DataGrip-2020.2.3/bin/datagrip.sh'
alias nano="vim"
alias logout='pkill -KILL -u $USER'
alias teams="flatpak run com.github.IsmaelMartinez.teams_for_linux"
alias outlook="flatpak run io.github.mahmoudbahaa.outlook_for_linux"
alias atom="flatpak run io.atom.Atom"

export PATH=$PATH:~/gpt4all/bin

# Alias for Teams for Linux
alias teams="flatpak run com.github.IsmaelMartinez.teams_for_linux"

# Alias for Visual Studio Code
alias code="flatpak run com.visualstudio.code"

# Alias for Atom Editor
alias atom="flatpak run io.atom.Atom"

# Alias for Outlook for Linux
alias outlook="flatpak run io.github.mahmoudbahaa.outlook_for_linux"

# Alias for Eclipse Java IDE
alias eclipse="flatpak run org.eclipse.Java"
alias datagrip='/snap/bin/datagrip'

mkassets() {
  mkdir -p assets/css assets/js assets/api assets/images
  touch assets/css/index.css
  touch assets/js/index.js
  touch assets/api/index.php
  echo "Directory structure and files created successfully in $(pwd)"
}

alias notepad="leafpad"

alias mistral-commit="$HOME/dotfiles/mistral-commit.sh"

alias l="clear"


lfcd() {
    tmp="$(mktemp)"
    (lf -last-dir-path="$tmp" "$@")
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && cd "$dir"
    fi
}

