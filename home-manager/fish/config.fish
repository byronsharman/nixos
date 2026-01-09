# don't know why, but stuff doesn't get properly added to the PATH without this
. /etc/nixos/home-manager/fish/default-profile.fish

# this is close to what the nix installer adds to your fish by default
# if test -e /nix/var/nix/profiles/default/etc/profile.d/nix.fish
#   . /nix/var/nix/profiles/default/etc/profile.d/nix.fish
# end

function fish_mode_prompt; end  # disable insert/normal mode indicator
fish_vi_key_bindings insert
set -g fish_greeting  # disable greeting

# cd on steroids, made by Grant & Lukas
# modified to use fish's psub instead of zsh's <()
function jmp
  # remove the -H from fd to omit hidden files
  set jmptarget "$(cat (fd --base-directory=$HOME -E archives/coronado_archives -E 'programs/aur/*' --type d -c never | awk '{print "~/"$0}' | sort | psub) (echo "~" | psub) | fzf $([ -z "$1" ] || echo "-q$1") --tac | sed "s#~#$HOME#g")"
  if test $jmptarget != ''
    cd $jmptarget
  end
  set -e jmptarget
end

set PATH $PATH /home/byron/.cargo/bin /home/byron/.go/bin
fzf --fish | source




# modified astronaut prompt
function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l prompt_status ""

    # don't abbreviate parent directory lengths
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '>'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    set _promptname (path basename $PWD)
    if test $PWD = $HOME
        set _promptname '~'
    end

    echo -s (whoami)@(prompt_hostname) ' ' $cwd_color $_promptname $normal ' ' $prompt_status $status_color $suffix ' ' $normal
end
