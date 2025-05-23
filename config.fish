if status is-interactive
    set -gx Desktop /mnt/c/Users/14777/Desktop
    if type -q starship
        starship init fish | source
    end
    if type -q cargo
        fish_add_path ~/.cargo/bin
    end
    if type -q go
        fish_add_path ~/go/bin
    end
    if type -q helix
        alias hx helix
    end
    fish_add_path ~/.ghcup/bin/
end
