# gotests-nvim

There is [gotests-vim](https://github.com/buoto/gotests-vim) as a plugin to handle [gotests](https://github.com/cweill/gotests) with vim.

This is a Lua rewrite for Neovim.

## Required

- [gotests](https://github.com/cweill/gotests)

## Installation
Gotests-vim requires **gotests** to be available in your `$PATH`. Alternatively you
can provide path to **gotests** using `g:gotests_bin` setting.

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
  "yanskun/gotests.nvim",
  ft = "go",
  config = function()
    require("gotests").setup()
  end,
},
```

### [packer.nvim](https://github.com/wbthomason/packer.nvim)

```lua
use {
  'yanskun/gotests.nvim',
  ft = 'go',
  config = function()
    require('gotests').setup()
  end
}
```

## Usage

Command|Description
--|--
`:GoTests`| generate tests for functions at the current line or functions selected in visual mode.
`:GoTestsAll`| generate tests for all functions and methods

## Settings
If you want you can set path to your **gotests** binary if it's not in your path, for example:

    let g:gotests_bin = '/home/user/go/bin/gotests'

You can also set custom template directory:

    let g:gotests_template_dir = '/home/user/templates/'
