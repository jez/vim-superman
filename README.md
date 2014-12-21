# Vim SuperMan

Read Unix `man` pages faster than a speeding bullet!

Unix man pages by default open with the `less` pager. Getting them to open with
Vim can be a little bit of a pain, but in recent versions of Vim there's a
plugin (`$VIMRUNTIME/ftplugin/man.vim`) that makes this easy.

This is a simple Vim plugin and sh function that makes replacing `man` from the
command line a cinch.

## Installation

Use your favorite plugin manager. If you don't have one, I'd recommend Vundle,
though you should probably also take a look at Pathogen, as it's more common.

```bash
# if your ~/.vim folder isn't under source control:
git clone https://github.com/Z1MM32M4N/vim-superman ~/.vim/bundle/

# if your ~/.vim folder is under source control:
git submodule add https://github.com/Z1MM32M4N/vim-superman ~/.vim/bundle/
```

Then, add the following to your `.bashrc`, `.bash_profile`, `.zshrc`, or
whatever file you use to configure your shell:

```bash
vman() {
  vim -c "SuperMan $*"

  if [ "$?" != "0" ]; then
    echo "No manual entry for $*"
  fi
}
```

Close and reopen your terminal and you're set!

## Usage

To open the man page for `vim`:

```
vman vim
```

It's that simple. The underlying `:Man` command supports specifying a specific
section, so you could also do something like

```
vman 3 printf
```

To see the man page for the C `printf()` library call.

## FAQ

### Jake, why not just call the bash function `man`?

The actual `man` command supports many more features than the Vim plugin does
(for a complete list, see `man(1)`). If you shadow the real `man` command,
things start to break, for example `apropos`, which uses `man` under the hood.

## License

MIT License. See LICENSE.



