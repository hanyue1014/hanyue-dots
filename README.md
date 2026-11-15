# hanyue-dots

My dotfiles, managed by `stow`

---

# Dependencies

There are a few things that are already assumed to be on the system, some configs won't work without them

1. [GNU `stow`](https://www.gnu.org/software/stow/), this should already be in most repositories of most Linux distributions, if not, please look for the installation instructions online
2. The respective fonts used in the configs, for now, the safe install lists are 

All the other dependencies are assumed to be installed, for example, if you install the nvim config, it obviously assumes that you have `nvim` on your system, and if you installed the niri configuration, it obviously assumes that you would be using niri as your window manager

# How to use

## 1. Clone this repository (partially, or fully if you want everything)

If all configs are needed, clone the entire repo

```sh
git clone https://github.com/hanyue1014/hanyue-dots.git
cd hanyue-dots
```

### Shallow clone with no checkouts

This shallow clones the repo and sparse-checkouts only `dot-setup.sh` (important because `dot-setup.sh` relies on this sparse checkout step to detect whether the repo is cloned fully or is sparse-checkout'ed to reliably detect in the future whether to sparse-checkout other configs or no extra actions is needed)

```sh
# 1. Clone shallow, without history, without blob content, and without checkout
git clone --depth 1 --no-checkout --filter=blob:none https://github.com/hanyue1014/hanyue-dots.git
cd hanyue-dots

# 2. Pull down just the setup script so you can execute it
# IMPORTANT: this also marks the repo as sparse-checkout and the setup script relies on this to determine whether to manage the sparse-checkout directories or do nothing in the future when you decide to stow a new config or unstow one
git sparse-checkout set dot-setup.sh
git checkout main
```

## 2. Use `dot-setup.sh` to stow the configs

```sh
chmod +x dot-setup.sh # in theory shouldn't be needed
./dot-setup.sh <package> [package2 [package3...]]
```

Running `./dot-setup.sh` when using a sparse checkout version automatically adds the package to the sparse checkout list of the repository, pulls them (by checking out `main` again), stows them and runs the `post-stow.sh` script in the packages

Running `./dot-setup.sh` when the repo is fully cloned does nothing with git itself but still stows the packages and runs the `post-stow.sh` script in the packages

### `post-stow.sh`

This script will act as a hook that runs everytime a package is stow-ed with the `dot-setup.sh` script, for post-stow checks (for example dependency checking) and extra actions (for example setup the `~/.pathrc` for shells, see [Path Loading](#path-loading)) that were supposed to be executed

# Shells

I try to make my shells feel as close to each other as possible, so you would see the same prompt, aliases and path loading mechanisms across bash, zsh and fish, and I don't tune them too much other than the prompts, I pretty much use them out of the box

## Path Loading

When the shell starts, it looks for `~/.pathrc` and attempts to load the list of directories in the file into `$PATH`, if the configs are stow-ed by the `dot-setup.sh` script, they automatically runs a post-stow script that creates `~/.pathrc` and writes `~/.local/bin` in it

## Aliases

Currently I only have 3:

```sh
alias l     ls
alias la    ls -a
alias ll    ls-la
```
