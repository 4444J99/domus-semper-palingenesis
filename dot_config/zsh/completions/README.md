# Custom Zsh Completions

This directory contains custom completion functions for tools that don't ship with their own completions.

## Usage

This directory is added to `fpath` in `.zshrc` so completions are automatically loaded.

## Adding New Completions

1. Create a file named `_<command>` (e.g., `_mytool`)
2. Start with `#compdef <command>`
3. Implement the completion function
4. Reload shell or run `compinit`

## Resources

- [Zsh Completion System](https://zsh.sourceforge.io/Doc/Release/Completion-System.html)
- [Writing Zsh Completions](https://github.com/zsh-users/zsh-completions/blob/master/zsh-completions-howto.org)
