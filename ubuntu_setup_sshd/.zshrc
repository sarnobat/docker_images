cat <<'EOF' > ~/computers.git/common/.zshrc-aliases.auto
alias		b='cd /Volumes/index_books/'
alias       c='cd ~/computers.git/'
alias       t='cd ~/trash/'
alias       bat='batcat --style=plain --paging=never --language sh --theme TwoDark'
alias       ct='crontab -l | grep -v "^#" | bat --language sh --paging never --style=plain --theme TwoDark'
alias       ce='crontab -e'
alias       di='du_inodes.sh'
alias       dii='du_inodes_non_recursive.sh'
alias       dss='du_sum_striped.sh | tee du_sum_striped.txt'
alias       fd='sudo find . -depth -empty -type d -exec rmdir -v '\''{}'\'' \;'
alias       gh='cd ~/github'
alias       grep='grep --color=auto'

alias       mkdir='mkdir -p'
alias       m='cd ~/mwk.git/'
alias       n='cd ~/new/'
alias       r='rsync -h -a -v --progress --backup --suffix=.`date -I` ---remove-source-files '
alias       re='rsync_stripe_by_extension2.sh '
alias       s='cd ~/sarnobat.git/'
alias       v='cd ~/videos/'
alias       vi="vim -u ~/.vimrc -O"
alias       vim="vim -u ~/.SpaceVim/vimrc -O"
alias       svim="vim -u ~/.SpaceVim/vimrc -0"
alias		vq='vim -q <(grep  -n "Untested" *) -c "copen"'; echo "try M-q instead"
EOF


# set -e

PROMPT='%F{164}docker %F{154}%n %F{068}%D{%a %d %B %G} %F{139}%t>%f '


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

bindkey -e

bindkey -s  			"^[2"   	 " 2> /dev/null"
bindkey -s  			"^[-" 	 	"cd -\n"
bindkey -s  			"^[,"	 	'df.sh | grep -v -e pool | sort -h -k 3\n'
bindkey -s  			"^[."	 	"cd ..\n"
bindkey -s  			"^[;" 	 	"tput cuu 2\n" # iterm delete current line
bindkey -s  			"^[="	 	"popd\n"
bindkey -s  			"^[C" 	 	'git commit --all --reuse-message=HEAD --amend^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D'
bindkey -s  			"^[d"	 	"du_non_recursive.sh\n"
bindkey -s  			"^[D"	 	"du.sh\n"
bindkey -s  			"^[F"	 	'find $PWD -maxdepth 10 -type d -iname "**"^[[D^[[D'
bindkey -s  			"^[f"	 	'find $PWD -maxdepth 10 -type f -iname "**"^[[D^[[D'
bindkey -s  			"^[l"	 	'ls -lr --time=ctime --ignore-backups --color=auto --classify --almost-all --reverse --human-readable --group-directories-first --ignore="._*" --literal\n'
bindkey -s  			"^[p"	 	" | perl -pe 's{}{}g'^[[D^[[D^[[D^[[D^[[D"
bindkey -s  			"^[q"	 	" | tee /tmp/grep.out; vim -q /tmp/grep.out -c 'copen'"
bindkey -s  			"^[v"	 	" | tee /tmp/grep.out; vim -q /tmp/grep.out -c 'copen'"
#bindkey -s 			 "^[r" 	 	'rsync -h -a --progress --backup --suffix=.`date -I`  ---remove-source-files -e "ssh -p 222" sarnobat@netgear.r23c.com:'\''"/media/sarnobat/3TB/new/"'\'' | tee /tmp/rsync.log && xmessage -geometry 300x100+500+1000 "rsync complete"^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D'
bindkey -s  			"^[r" 	 	'rsync -a -v -h --progress --append -e "ssh -p 22 -i  ~/.ssh/google_compute_engine 34.69.137.166 ssh -p 22222"  localhost:/media/sarnobat/zfs_master_3TB/new/ ^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D^[[D'
bindkey -s  			"^[z"	 	"source /tmp/.zshrc\n"
bindkey -s  			"^[Z"	 	"source ~/computers.git/common/.zshrc.git.common.auto\n"
bindkey -s  			"^[Y"	 	'yt-dlp --extract-audio --audio-format mp3  ""  ^[[D^[[D^[[D'
bindkey -s  			"^[y"	 	'yt-dlp --trim-filenames 100 --restrict-filename ""  ^[[D^[[D^[[D'
bindkey     			"^[[1;3A"	history-beginning-search-backward
bindkey     			"^[[1;3B"	history-beginning-search-forward
bindkey     			"^[[1;3C"	forward-word
bindkey     			"^[[1;3D"	backward-word
bindkey     			"^[[F"	 	end-of-line  
bindkey	-s				"^[E"		"bindkey -v\nsource ~/computers.git/common/.zshrc-key-bindings.vim.auto\nsource ~/computers.git/common/.zshrc-misc.auto"
bindkey	-s				"^[e"		"bindkey -lL main | perl -pe 's{bindkey....(.*)main}{\$1}'\n"

bindkey     			"^[[H"	 	beginning-of-line
bindkey     			"^[4"	 	insert-last-word
bindkey     			"^[5"	 	copy-prev-shell-word
bindkey     			"^[k"	 	vi-kill-eol
bindkey -s  			"^[g"	 	'^[[F | xargs --delimiter "\\n" grep --with-filename --directories=skip --color=auto --binary-files=without-match --ignore-case --line-number ""^[[D'
bindkey -s  			"^[x"	 	'^[[F |  xargs --delimiter '\''\\n'\'' --max-args=1 '
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

##
## Dotfile linking to home dir
##
cd
find ~/computers.git/    -type f -iname ".zshrc*" |  grep -v trash | grep -v work | xargs --delimiter '\n' --max-args=1 ln -sr 2>/dev/null
unlink .zshrc
#find ~/computers.git/antec -type f -iname ".zshrc" |  grep -v trash | xargs --delimiter '\n' --max-args=1 ln -sr
# ln -sr ~/computers.git/antec/.zshrc

PATH=${PATH}:$HOME/github/binaries/ubuntu/bin/

#touch ~/.hushlogin


alias bat='batcat --plain --paging=never'
alias m='mount_all_manually_local.sh'
alias cl='cleanup_videos_current_dir.sh 2>/dev/null'

bindkey -s "^[i"  'sh ~/bin/mv_promote_file_plus_1.sh '
bindkey -s "^[z"  'source ~/computers.git/docker/.zshrc\n'
bindkey -s "^[l"  'ls --color -lS --reverse --human-readable --almost-all\n'
bindkey -s "^l"  'locate.sh '
bindkey -s "^[d"      "du_non_recursive.sh\n"
bindkey -s "^[D"      "du.sh\n"
#bindkey -s "^[m"  'sh ~/bin/mv_promote_file_plus_1.sh '
bindkey -s "^[m"  'mv_file_to_subdir.sh '
bindkey -s "^[t"  'tail -10f /tmp/cron_ffplay_before_perl.log | sed --unbuffered '\''s/.*from //'\'' | sed --unbuffered '\''s/:$//'\''\n'
bindkey -s "^[e"  'epic_workspace_'
# alias e='epic_workspace_'
RPROMPT=' %F{178}%d%f '`bindkey -lL main | perl -pe 's{bindkey....(.*)main}{\$1}'`
cat <<'EOF' > ~/computers.git/common/.zshrc.git.common.auto

bindkey -s  "^[_" 	'git checkout -'
bindkey -s  "^[a"	'git add --all :/'
bindkey -s  "^[c"	'git commit --message="'`date -I`': " -- ^[[D^[[D^[[D^[[D^[[D'
#bindkey -s  "^[c"	'git commit --message="'`date -I`: `git diff --name-only --cached  |  xargs --delimiter \\"\\n\\" --max-args=1 basename | tr \\"\\n\\" \\" \\"`': " -- ^[[D^[[D^[[D^[[D^[[D'
bindkey -s  "^[c"   'git commit --message="'`date -I`': `git diff --name-only --cached | xargs --delimiter \"\\n\" --no-run-if-empty -n 1 basename | tr \"\\n\" \" \"`" -- ^[[D^[[D^[[D^[[D^[[D'

bindkey -s  "^[O" 	'git checkout '
bindkey -s  "^[b" 	'git branch\n'
bindkey -s  "^[d"   'git difftool --no-prompt --extcmd="/Applications/DiffMerge.app/Contents/MacOS/DiffMerge" '

bindkey -s  "^[m" 	'git mergetool && git rebase --continue'
bindkey -s  "^[s"	'git -c color.status=always status --untracked-files --short\n'
bindkey -s  "^[L"	'git log --date=short --format="%C(cyan)%h %C(yellow)%ad %Creset%s %C(magenta) %cn %C(green)%d"  --graph --max-count=12\n'
bindkey -s  "^[r" 	'git rebase --interactive --keep-empty HEAD~4^[[D^[[D^[[D^[[D^[[D^[[D'
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

# source ~/computers.git/mac/zsh/.zshrc-git
# source ~/computers.git/mac/zsh/.zshrc-tab-completions
# source ~/computers.git/mac/zsh/.zshrc-key-bindings
# source ~/computers.git/mac/zsh/.zshrc-misc
# source ~/computers.git/dotfiles_and_scripts/.aliases
# source ~/computers.git/common/.zshrc-dircolors.auto

ln -srf ~/computers.git/ubuntu/bin ~/
ln -srf ~/computers.git/dotfiles_and_scripts/.dir_colors


cd
unlink ~/videos; ln -s /media/sarnobat/3TB/disks/thistle/videos ~/
unlink ~/other; ln -s /media/sarnobat/e/misc_sync_master ~/other
unlink mediasarnobat; ln -s /media/sarnobat/ mediasarnobat
#unlink /media/sarnobat/sarnobat
popd >/dev/null
# Show dock on xrdp
cat <<EOF > ~/.xsessionrc
export GNOME_SHELL_SESSION_MODE=ubuntu
export XDG_CURRENT_DESKTOP=ubuntu:GNOME
export XDG_CONFIG_DIRS=/etc/xdg/xdg-ubuntu:/etc/xdg
gnome-terminal

TODO
----
(-) get NFS mount working (getting permission denied)
EOF

cd
