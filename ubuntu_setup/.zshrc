# set -e
source ~/computers.git/mac/zsh/.zshrc-git
source ~/computers.git/mac/zsh/.zshrc-tab-completions
source ~/computers.git/mac/zsh/.zshrc-key-bindings
source ~/computers.git/mac/zsh/.zshrc-misc
source ~/computers.git/dotfiles_and_scripts/.aliases

ln -srf ~/computers.git/ubuntu/bin ~/
ln -srf ~/computers.git/dotfiles_and_scripts/.dir_colors

PROMPT='%F{164}docker %F{068}%D{%a %d %B %G} %F{139}%t>%f '


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
