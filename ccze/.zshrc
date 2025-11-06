## TODO: I wonder if we should reorganize this by obsolescence groups (e.g. emacs)

# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"
cat <<'EOF' > ~/computers.git/common/.zshrc-aliases.auto
alias	b='cd /Volumes/index_books/'
alias	bb='bbedit'
alias	c='cd ~/computers.git/'
alias	cs='cscope'
alias	t='cd ~/trash/'
alias	bat='batcat --style=plain --paging=never --language sh --theme TwoDark'
alias	ct='crontab -l | grep -v "^#" | bat --language sh --paging never --style=plain --theme TwoDark'
alias	ce='crontab -e'
alias	cev='crontab_edit_vscode.sh && EDITOR=/tmp/code-wait.sh crontab -e'
alias	di='du_inodes.sh'
alias	dii='du_inodes_non_recursive.sh'
alias	dss='du_sum_striped.sh | tee du_sum_striped.txt'
alias	fd='sudo find . -depth -empty -type d -exec rmdir -v '\''{}'\'' \;'
alias	fe='find -empty -type d'
alias	gh='cd ~/github'
alias	grep='grep --color=auto'
alias   g='cd /Volumes/git'
alias	gc='git clone '
alias	mkdir='mkdir -p'
alias	m='cd ~/mwk.git/'
alias	n='cd ~/new/'
alias	r='rsync -h -a -v --progress --backup --suffix=.`date -I` --prune-empty-dirs ---remove-source-files '
alias	re='rsync_stripe_by_extension2.sh '
alias	s='cd ~/sarnobat.git/'
alias	sr='cd ~/src.git/'
alias	v='cd ~/videos/'
alias	vi="vim -u ~/.vimrc -O"
alias	vim="vim -u ~/.SpaceVim/vimrc -O"
alias	svim="vim -u ~/.SpaceVim/vimrc -0"
alias	vq='vim -q <(grep  -n "Untested" *) -c "copen"; echo "try M-q instead"'
EOF

#  _____________________
# /\                    \
# \_| key bindings (vi) |
#   |                   |
#   |   ________________|_
#    \_/__________________/

cat <<'EOF' > ~/computers.git/common/.zshrc-key-bindings.vim.auto


# man zshzle							# manpages for bindkey
# bindkey -l							# list modes
# bindkey_zsh_examples_list.sh					# list all modes
# bindkey_zsh_examples.sh
# bindkey -lL main						# show current mode

# Highlight text for visual mode
# (but I don't think vi can copy to system clipboard without using xclip)
zle_highlight=('region:bg=168,fg=251')



# (-) I'm not sure yet but I think viins is the better mode to start in than vicmd
# by default. Having to press i just to begin a command (even searching back 
# through history) feels like too much unnecessary effort.
#
# (-) looks like you can't set vicmd as a default

# we can't clear all bindings because it will destroy git bindings that take lower precedence
#bindkey		-d					# clear all keybindings
bindkey			-v			-m		# use viins mode, with M-... defaults for unused combos
#bindkey			-L					# list all key bindings

# I think the "vi-" functions only apply in insert mode. So we need 2 bindings for backward delete word
bindkey				"^[^?"		backward-delete-word
bindkey				"^H"		vi-backward-char

bindkey				"^[[1;3A"	history-beginning-search-backward
bindkey				"^[[1;3B"	history-beginning-search-forward
bindkey				"^[[1;3C"	forward-word
bindkey  -M	vicmd		"^[[1;3C"	forward-word
bindkey				"^[[1;3D"	backward-word
bindkey  -M	vicmd		"^[[1;3D"	backward-word

 
bindkey -s			"^[="		"popd\n"

# -s only applies in insert mode unfortunately. Looks like you need to press i before these
 

bindkey -s			"^[s"		'git -c color.status=always status --untracked-files --short\n'

bindkey -s			"^[b"		'bbedit ~/bin/^[[D^[[D^[[D^[[D^[[D^[[D'
bindkey -s			"^[f"		'find $PWD -maxdepth 10 -type f -iname "**"^[[D^[[D'
bindkey -s			"^[l"		'ls -lr --time=ctime --color=auto --classify --almost-all --reverse --human-readable --group-directories-first --ignore="._*" --literal\n'

bindkey	-s			"^[e"		"bindkey -lL main | perl -pe 's{bindkey....(.*)main}{\$1}'\n" # show current mode
bindkey	-s			"^[E"		"bindkey -e\nsource ~/computers.git/common/.zshrc-key-bindings.auto\nsource ~/computers.git/common/.zshrc-misc.auto\n"
bindkey -s			"^[z"		"source ~/.zshrc\n"
#bindkey -s			"^Z"		"source ~/computers.git/common/.zshrc-key-bindings.emacs.auto\n"

# vicmd bindings are important if we want to get the ease of emacs bindings without switching.
# It is double duty unfortunately
bindkey -s			"^[Z"		"source ~/computers.git/common/.zshrc.git.common.auto\n"
bindkey -M	vicmd -s	"^[Z"		"source ~/computers.git/common/.zshrc.git.common.auto\n"

bindkey				"^[4"		insert-last-word
bindkey				"^[5"		copy-prev-shell-word
bindkey -s			"^[-"		"cd -\n"
bindkey -s			"^[p"		" | perl -pe 's{}{}g'^[[D^[[D^[[D^[[D^[[D"

#bindkey -s			'\eZ'		"source ~/computers.git/common/.zshrc.git.common.auto\n"

bindkey -M	viins		'jj'		vi-cmd-mode
bindkey -v			'^?'		backward-delete-char

EOF

# zle -N toggle_vi_emacs
# bindkey		'\ei'		toggle_vi_emacs

#  ________________________
# /\                       \
# \_| key bindings (emacs) |
#   |                      |
#   |   ___________________|_
#    \_/_____________________/

cat <<'EOF2' | tee ~/computers.git/common/.zshrc-key-bindings.emacs.auto  > ~/computers.git/common/.zshrc-key-bindings.auto

## use emacs keybindings (e.g. Alt backspace - delete backwards)
# For vim mode, use bindkey -v (then press esc and you can use vi key bindings). 
# Alternatively just use fc (fix command), 
# though in practice it's too tricky to find the previous command.

# bindkey -e

bindkey -s			"^[2"		" 2> /dev/null"
bindkey -s			"^[-"		"cd -\n"
bindkey -s			"^[,"		'df.sh | grep -v -e pool | sort -h -k 3\n'
bindkey -s			"^[."		"cd ..\n"
bindkey -s			"^[;"		"tput cuu 2\n" # iterm delete current line
bindkey -s			"^[="		"popd\n"
bindkey -s			"^[C"		'git commit --all --reuse-message=HEAD --amend^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D'
bindkey -s			"^[d"		"du_non_recursive.sh\n"
bindkey -s			"^[D"		"du.sh\n"
bindkey -s			"^[F"		'find $PWD -maxdepth 10 -type d -iname "**"^[[D^[[D'
bindkey -s			"^[f"		'find $PWD -maxdepth 10 -type f -iname "**"^[[D^[[D'
bindkey -s			"^[l"		'ls -lr --time=ctime --ignore-backups --color=auto --classify --almost-all --reverse --human-readable --group-directories-first --ignore="._*" --literal\n'
bindkey -s			"^[p"		" | perl -pe 's{}{}g'^[[D^[[D^[[D^[[D^[[D"
bindkey -s			"^[q"		" | tee /tmp/grep.out; vim -q /tmp/grep.out -c 'copen'"
# bindkey -s			"^[v"		" | tee /tmp/grep.out; vim -q /tmp/grep.out -c 'copen'"
bindkey -s			"^[v"		"crontab -e\n"
#bindkey -s			"^[r"		'rsync -h -a --progress --backup --suffix=.`date -I`  ---remove-source-files -e "ssh -p 222" sarnobat@netgear.r23c.com:'\''"/media/sarnobat/3TB/new/"'\'' | tee /tmp/rsync.log && xmessage -geometry 300x100+500+1000 "rsync complete"^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D'
bindkey -s			"^[r"		'rsync -a -v -h --progress --append -e "ssh -p 22 -i  ~/.ssh/google_compute_engine 34.69.137.166 ssh -p 22222"  localhost:/media/sarnobat/zfs_master_3TB/new/ ^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D'
bindkey -s			"^[z"		"source ~/.zshrc\n"
bindkey -s			"^[Z"		"source ~/computers.git/common/.zshrc.git.common.auto\n"
bindkey -s			"^[Y"		'yt-dlp --extract-audio --audio-format mp3  ""  ^[[D^[[D^[[D'
bindkey -s			"^[y"		'yt-dlp --cookies-from-browser=chrome --trim-filenames 100 --restrict-filename "" &^[[D^[[D^[[D'
bindkey				"^[[1;3A"	history-beginning-search-backward
bindkey				"^[[1;3B"	history-beginning-search-forward
bindkey				"^[[1;3C"	forward-word
bindkey				"^[[1;3D"	backward-word
bindkey				"^[[F"		end-of-line  
bindkey	-s			"^[E"		"bindkey -v\nsource ~/computers.git/common/.zshrc-key-bindings.vim.auto\nsource ~/computers.git/common/.zshrc-misc.auto\n"
bindkey	-s			"^[e"		"bindkey -lL main | perl -pe 's{bindkey....(.*)main}{\$1}'\n"

bindkey				"^[[H"		beginning-of-line
bindkey				"^[4"		insert-last-word
bindkey				"^[5"		copy-prev-shell-word
bindkey				"^[k"		vi-kill-eol
bindkey -s			"^[g"		'^[[F | xargs --delimiter "\\n" grep --with-filename --directories=skip --color=auto --binary-files=without-match --ignore-case --line-number ""^[[D'
bindkey -s			"^[x"		'^[[F |  xargs --delimiter '\''\\n'\'' --max-args=1 '
EOF2


cat <<'EOF' > ~/computers.git/common/.zshrc-tab-completions.auto

##
## Alias tab expansion
## Both lines are needed together
##
zstyle                  ':completion:*' completer _expand_alias _complete _ignored
# slow
autoload -Uz compinit; compinit 

##
## case-insensitive (all),partial-word and then substring completion
## Given by Brian Wolf
##
## :completion:<function>:<completer>:<command>:<argument>:<tag>
zstyle                  ':completion:*:complete:*' matcher-list '' '+m:{a-zA-Z}={A-Za-z}' '+m:{-_}={_-}'

##
## repeatedly pressing tab (like tcsh enhance)
## https://unix.stackexchange.com/a/12036/7000
##
setopt          bash_auto_list
setopt          no_auto_menu
unsetopt        ALWAYS_LAST_PROMPT

EOF

#  ______________________
# /\                     \
# \_| Directory Changing |
#   |                    |
#   |   _________________|_
#    \_/___________________/

cat <<'EOF' > ~/computers.git/common/.zshrc_change_directory_cd_pushd.auto
# CHASE_LINKS alias. Dereference the real path on cd
set -o          physical

# make cd push onto stack
setopt          AUTO_PUSHD

# do not display dir stack after pop
setopt          PUSHDSILENT

# dir name without cd performs cd
setopt          auto_cd
EOF

cat <<'EOF' > ~/computers.git/common/.zshrc-misc.auto

chmod a+x  ~/bin/*sh(.)

# disown will automatically also send SIGCONT
setopt  AUTO_CONTINUE

WORDCHARS=

# RPROMPT=`bindkey -lL main`' %F{178}%d%f   '
RPROMPT=' %F{178}%d%f '`bindkey -lL main | perl -pe 's{bindkey....(.*)main}{\$1}'`
# RPROMPT='`bindkey -lL main | perl -pe '\''s{bindkey....(.*)main}{\$1}'\''`'' %F{178}%d%f   '

EOF

cat <<'EOF' > ~/computers.git/common/.zshrc.git.common.auto

bindkey -s  "^[_"	'git checkout -'
bindkey -s  "^[a"	'git add --all . :/'
bindkey -s  "^[c"	'git commit --message="'`date -I`': " -- ^[[D^[[D^[[D^[[D^[[D'
#bindkey -s  "^[c"	'git commit --message="'`date -I`: `git diff --name-only --cached  |  xargs --delimiter \\"\\n\\" --max-args=1 basename | tr \\"\\n\\" \\" \\"`': " -- ^[[D^[[D^[[D^[[D^[[D'
bindkey -s  "^[c"	'git commit --message="'`date -I`': `git diff --name-only --cached | xargs --delimiter \"\\n\" --no-run-if-empty -n 1 basename | tr \"\\n\" \" \"`" -- ^[[D^[[D^[[D^[[D^[[D'

bindkey -s  "^[O"	'git checkout '
bindkey -s  "^[b"	'git branch\n'
bindkey -s  "^[d"	'git difftool --no-prompt --extcmd="/Applications/DiffMerge.app/Contents/MacOS/DiffMerge" '

bindkey -s  "^[m"	'git mergetool && git rebase --continue'
bindkey -s  "^[s"	'git -c color.status=always status --untracked-files --short\n'
bindkey -s  "^[L"	'git log --date=short --format="%C(cyan)%h %C(yellow)%ad %Creset%s %C(magenta) %cn %C(green)%d"  --graph --max-count=12\n'
bindkey -s  "^[r"	'git rebase --interactive --keep-empty HEAD~4^[[D^[[D^[[D^[[D^[[D^[[D'
EOF

#  __________
# /\         \
# \_| iTerm2 |
#   |        |
#   |   _____|_
#    \_/_______/

cat <<'EOF' > ~/computers.git/common/.zshrc.mac.iterm.auto

################################################################################
## iterm - Cycle tab order
################################################################################

# Preferences -> Keys -> Key Bindings you can map iTerm tab switching shortcuts to
# Next Tab / Previous Tab (or any other actions you prefer).
# The default is Cycle Tabs Forward / Cycle Tabs Backward.

################################################################################
## iterm - requires profile key remapping (Global)
## Also
################################################################################

# Alt-left : this works on Linux - I tested it with VirtualBox
# You need to:
# 1) create a key mapping in iTerm too, in the PROFILE -> KEYS subtab (not the KEYS top level tab), from:
#
#   Keyboard Shortcut: Option + cursor-left
#
# to:
#
#   Send Escape Sequence (not Send Text or Send Hex Code): ^[[1;3D
#
# On newer versions of iTerm it seems you only put [1;3D in the text box, and by virtue of being an "escape sequence" the other ^[ will be appende
#
# Yes it is double duty, but it's the best way to achieve your goal of a cross-compatible
# .zshrc file
# The complete list is:
#
#       Option + cursor-up      :       ^[[1;3A
#       Option + cursor-down    :       ^[[1;3B
#       Option + cursor-right   :       ^[[1;3C
#       Option + cursor-left    :       ^[[1;3D
#
#
# 2) Change (in the PROFILE -> KEYS subtab, not the KEYS top level tab):
#
#   "Left  option Key acts as"  to "+Esc"
#   "Right option Key acts as"  to "+Esc"
#
EOF

#  __________________
# /\                 \
# \_| Symbolic Links |
#   |                |
#   |   _____________|_
#    \_/_______________/

cat <<'EOF' > ~/computers.git/common/.zshrc.symlinks.common.auto
WD=$PWD
pushd $HOME
# beneficial for easy opening to edit, not for sourcing


ln -srf ~/computers.git/common/.zshrc-aliases.auto .aliases
ln -srf ~/computers.git/common/.zshrc-key-bindings.auto
ln -srf ~/computers.git/common/.zshrc-misc.auto
ln -srf ~/computers.git/common/.zshrc-tab-completions.auto
ln -srf ~/computers.git/common/.zshrc.git.common.auto
ln -srf ~/computers.git/common/.vim
ln -srf ~/computers.git/common/.vimrc

popd

EOF

cat <<'EOF' > ~/computers.git/common/.gitconfig
### autogenerated inside ~/computers/mac/.zshrc.mbp

[user]
	name          = Sridhar Sarnobat
	email         = ss401533@gmail.com

[merge]
        tool          = diffmerge

[mergetool "diffmerge"]
        cmd           = /Applications/DiffMerge.app/Contents/MacOS/DiffMerge --nosplash --merge --result=\"$MERGED\"        \"$LOCAL\" \"$BASE\" \"$REMOTE\"
        trustExitCode = true

EOF
#  ___________
# /\          \
# \_| History |
#   |         |
#   |   ______|_
#    \_/________/

cat <<EOF > ~/computers.git/common/.zshrc-history.auto
HISTFILE=$HOME/trash/.zsh-history
SAVEHIST=50000
# if ssh session isn't explicitly exited, you lose commands
setopt INC_APPEND_HISTORY
EOF

cat <<'EOF' > /tmp/colorize.sh
	cat - \
   | perl -pe '$|=1; s{^(.*junkmaster)}{\e[38;5;130m$1\e[0m}gi' \
   | perl -pe '$|=1; s{^(error)}{\e[38;5;160m$1\e[0m}gi' \
   | perl -pe '$|=1; s{^(.*debug.*)}{\e[38;5;255m$1\e[0m}gi' \
   | perl -pe '$|=1; s{^(.*info.*)}{\e[38;5;149m$1\e[0m}gi' \
   | perl -pe '$|=1; s{^(.*/.*)}{\e[38;5;159m$1\e[0m}gi' \
   | perl -pe '$|=1; s{^(.*finished)}{\e[38;5;136m$1\e[0m}gi'
EOF

cat <<EOF > ~/computers.git/common/.zshrc.mac.common.auto
cd
ln -srf ~/'Library/Mobile Documents/com~apple~CloudDocs/0_New' icloud

# Make sure all dirs start with lower case
# Actually this alone won't do the job
#rename -v 'y/A-Z/a-z/' ~/new/[A-Z]*(/)
#rename -v 'y/A-Z/a-z/' ~/icloud/*(/)
EOF

cat <<EOF > ~/computers.git/2025/mac/git/.gitignore_global
### autogenerated inside ~/computers/mac/zsh/.zshrc

# also use  .git/info/exclude

# We can't have this - we have personal scripts in sarnobat.git
#bin
*.orig
*.log.gz
cscope*
.DS_Store
du*txt
EOF

dircolors ~/computers.git/common/.dir_colors                   >  ~/computers.git/common/.zshrc-dircolors.auto
source    ~/computers.git/common/.zshrc-history.auto
source    ~/computers.git/common/.zshrc-tab-completions.auto
source    ~/computers.git/common/.zshrc-misc.auto
source    ~/computers.git/common/.zshrc-aliases.auto
source    ~/computers.git/common/.zshrc.symlinks.common.auto
source    ~/computers.git/common/.zshrc_change_directory_cd_pushd.auto
source    ~/computers.git/common/.zshrc-dircolors.auto
source    ~/computers.git/common/.zshrc-key-bindings.auto
source    ~/computers.git/common/.zshrc-key-bindings.vim.auto
source    ~/computers.git/common/.zshrc.mac.common.auto


chmod a+x ~/bin/*(.)

# /*       _\|/_
#          (o o)
#  +----oOO-{_}-OOo---+
#  | Macbook Pro 2024 |
#  +-----------------*/

##
## Machine specific
##

alias	a='cd /Volumes/index_audio/audio_by_volumes'
alias	A='cd /Volumes/index_audio/Audio'
alias	diffmerge='/Volumes/apps/Apps/DiffMerge.app/Contents/MacOS/DiffMerge'
alias	D='cd ~/Desktop/'
alias	d='cd ~/Downloads/'

alias	gvim='/opt/homebrew/bin/mvim +"Lexplore ~/bin/" --remote-tab-silent'

bindkey -s      '^[J'	  'autossh -M0 -p 22 -R 9001:localhost:22 sarnobat@netgear.r23c.com'
bindkey -s      "^[d"	'git difftool --no-prompt --extcmd="/Applications/DiffMerge.app/Contents/MacOS/DiffMerge" '

pushd ~/
ln      -sf     /Volumes/trash/trash
ln      -sf     /Volumes/new/new
ln      -sf     /Volumes/new/new/videos
ln      -sf     /Volumes/git/github
ln      -srf    ~/computers.git/mac/bin
ln	-srf	/Volumes/git/computers.git/2025/mac/git/.gitignore_global
popd



##
## PATH
##

# How does this get autopopulated? /nix/var/nix/profiles/default/bin

#
# System
#
# PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin/

#
# GNU
#

# PATH=/opt/homebrew/Cellar/findutils/*/libexec/gnubin:${PATH}
PATH=/opt/homebrew/bin/:${PATH}
PATH=/usr/libexec/:${PATH}
PATH=`/usr/libexec/java_home`/bin/:${PATH}

#
# brew GNU
#

# PATH=/opt/homebrew/Cellar/moreutils/*/bin/:${PATH}
PATH=/opt/homebrew/opt/libtool/libexec/gnubin/:${PATH}
# PATH=/opt/homebrew/opt/coreutils/libexec/gnubin:${PATH}
PATH=/opt/homebrew/opt/coreutils/libexec/gnubin/:${PATH}
PATH=/opt/homebrew/opt/grep/libexec/gnubin/:${PATH}
# PATH=/opt/homebrew/opt/grep/libexec/gnubin:${PATH}
PATH=/opt/homebrew/opt/findutils/libexec/gnubin/:${PATH}

#
# git personal
#
PATH=/Volumes/git/computers.git/mac/bin/:${PATH}
PATH=$HOME/computers.git/common/bin/:${PATH}

#
# installed
#
PATH=$HOME/.local/bin:${PATH}
PATH=$HOME/.cargo/bin:${PATH}
PATH=$HOME/go/bin:${PATH}
PATH=$HOME/.pyenv/shims/:${PATH}

PATH_CRON="$PATH"

#
# Apps
#
PATH=${PATH}:/Volumes/apps/install-tl-20240404/2024/bin/universal-darwin/
PATH="/Volumes/apps/Apps/IntelliJ IDEA CE.app/Contents/bin/":${PATH}
PATH="/Volumes/apps/Apps/IntelliJ IDEA CE.app/Contents/MacOS/":${PATH}
PATH="/Volumes/apps/Apps/Docker.app/Contents/Resources/bin/":${PATH}
PATH=/Volumes/apps/Apps/CLion.app/Contents/bin/gdb/mac/aarch64/bin/:${PATH} # for gdb on mac instead of lldb
PATH=${PATH}:"/Volumes/apps/Apps/Visual Studio Code.app/Contents/Resources/app/bin/"

#
# Github
#
PATH=$HOME/github/mx:${PATH}
PATH=$HOME/github/2024/binaries/cross-platform/bin/:${PATH}
PATH=$HOME/github/2024/binaries/mac.m1/bin/:${PATH}
PATH=$HOME/github/2024/binaries/mac.intel/bin/:${PATH}
PATH=${PATH}:/tmp/bin/

#
# Docker tab completion
#

cat <<'EOF' > /tmp/add_docker_plugins.zsh
# --- Ensure docker and docker-compose plugins are enabled in Oh My Zsh ---

# Path to your existing plugins array
if ! grep -q '^plugins=' ~/.zshrc; then
    echo "plugins=(git docker docker-compose)" >> ~/.zshrc
else
    # Add docker and docker-compose if missing
    # Uses zsh parameter expansion to read plugins line
    plugins_line=$(grep '^plugins=' ~/.zshrc)
    # Remove parentheses and split
    current_plugins=(${plugins_line//[()]/})
    new_plugins=()
    for p in docker docker-compose; do
        if [[ ! " ${current_plugins[@]} " =~ " $p " ]]; then
            new_plugins+=("$p")
        fi
    done
    if [ ${#new_plugins[@]} -gt 0 ]; then
        # Append new plugins to existing line
        sed -i.bak "s/^plugins=(\(.*\))/plugins=(\1 ${new_plugins[*]})/" ~/.zshrc
    fi
fi
EOF

source /tmp/add_docker_plugins.zsh

##
## Unsorted?
##

PROMPT='%F{152}%m %F{210}%D{%a %d %B %G} %F{211}%t>%f '

export HAXE_STD_PATH="/opt/homebrew/lib/haxe/std"

export JAVA_HOME=`/usr/libexec/java_home` # Mac only

tput setaf 12

echo "ansi colors:\t\033[38;5;12m colortest_ansi_codes.sh\033[0m"
tput setaf 3

echo "Cron output errors"
cat /var/mail/sarnobat | grep -i -e ': No' -B 8  | grep -v -e 'X-Cron' -e Message-Id -e '^$' | perl -pe 's{^}{        }' | cut -c -160 | tail -5
tput init
echo "Cron errors:\t\033[38;5;226mcat /var/mail/sarnobat | grep -e ': No' -B 8  | grep -v -e 'X-Cron' -e Message-Id -e '^$' | tail\033[0m"  | perl -pe 's{^}{        }' 


tput setaf 12
crontab -l | grep -v "^#" | bat --language sh --paging never --style=plain --theme TwoDark | grep % | grep -v '\\%' | grep --color '%'
tput setaf 13

REMOTE="--remote-tab-silent"
LEXPLORE='+"Lexplore $HOME/bin/"'
BACKGROUND="-g -a"
# REMOTE=
# LEXPLORE=
# BACKGROUND=

# Does not work
cat <<EOF > /tmp/out.zsh
# sleep 1
# open  $BACKGROUND "/opt/homebrew/Cellar/macvim/9.1.1128/MacVim.app" 
# sleep 1
open  $BACKGROUND "/opt/homebrew/Cellar/macvim/9.1.1128/MacVim.app"   --args $REMOTE $LEXPLORE   && echo "launched vimrc"	
open  $BACKGROUND "/opt/homebrew/Cellar/macvim/9.1.1128/MacVim.app" --args  $REMOTE ~/.vimrc  && echo "launched vimrc"	
sleep 1
# open  $BACKGROUND "/opt/homebrew/Cellar/macvim/9.1.1128/MacVim.app"  ~/.gvimrc --args $REMOTE && echo "launched gvimrc"
# sleep 1
# open  $BACKGROUND "/opt/homebrew/Cellar/macvim/9.1.1128/MacVim.app" --args $REMOTE $LEXPLORE
sleep 1
EOF




# works (but not in background without hack)
cat <<EOF > /tmp/gvim.sh
/opt/homebrew/Cellar/macvim/9.1.1128/MacVim.app/Contents/bin/mvim --remote-tab-silent  +"Lexplore $HOME/bin/" ~/.vimrc
sleep 0.2s
# osascript -e 'tell application "iTerm2" to activate'
osascript -e 'tell application "System Events" to set visible of process "MacVim" to false'

EOF

cat <<EOF > /tmp/emacs.sh
#open -g -a /opt/homebrew/Cellar/emacs-plus@30/30.1/Emacs.app ~/.emacs
pgrep Emacs || /opt/homebrew/Cellar/emacs-plus@30/30.1/bin/emacs ~/.emacs
sleep 1s
# osascript -e 'tell application "Emacs" to hide'
osascript -e 'tell application "System Events" to set visible of process "Emacs" to false'
EOF

# source /tmp/out.zsh &
# (source /tmp/gvim.sh  &)
# (source /tmp/emacs.sh  &)

open -g -a /Applications/BBEdit.app								\
	~/.vimrc										\
	~/.zshrc
# 	~/"Library/Application Support/Code/User/settings.json"	\
#	~/mwk.git/new_sliceable.mwk								\

source /Users/sarnobat/.config/broot/launcher/bash/br

bindkey -m 2>/dev/null
bindkey -v 2>/dev/null

cat <<EOF
vi-mode bindkey: It seems like single escape switches from viins to vicmd mode
	
		bindkey "^[" vi-cmd-mode
	
	TIP: You can toggle bindkey using (M-Shift-e) to toggle mode if viins is too challenging.
EOF
# Amazon Q post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"

popd
osascript -e '
tell application "System Events"
    set visible of every process whose visible is true and name is not "iTerm2" and name is not "Google Chrome" to false
end tell
'
tput setaf 12
tput setaf 196
cat <<EOF
Cron Syntax Errors
EOF
crontab -l | grep '%' | grep -v '\\%' | grep -v escape
crontab -l | grep '\$' | grep -v '\\\$' | grep -v escape | grep -v "PATH=" | grep -v OLD_VOLUME
tput setaf 28
[ -f "/Users/sarnobat/.ghcup/env" ] && . "/Users/sarnobat/.ghcup/env" # ghcup-env

PATH="/Users/sarnobat/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/Users/sarnobat/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/Users/sarnobat/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/Users/sarnobat/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/sarnobat/perl5"; export PERL_MM_OPT;
plugins=(git docker docker-compose)
