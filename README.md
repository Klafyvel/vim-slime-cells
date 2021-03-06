# vim-slime-cells
A plugin on top of [vim-slime](https://github.com/jpalardy/vim-slime) to enhance its cell feature. It adds the possibility to jump between cells and to send the current cell then jump to the next one.

There is also a nice syntax-highlighting feature for cell boundaries.

## Preview

[![asciicast](https://asciinema.org/a/459056.svg)](https://asciinema.org/a/459056)

## Installation

You need [vim-slime](https://github.com/jpalardy/vim-slime) installed.

You can use Vim-Plug:
```vim
Plug 'klafyvel/vim-slime-cells'
```

Or with packer (example configuration for Julia):
```lua
use {
  'klafyvel/vim-slime-cells',
  requires = {{'jpalardy/vim-slime', opt=true}},
  ft = {'julia'},
  config=function ()
    vim.g.slime_target = "tmux"
    vim.g.slime_cell_delimiter = "^\\s*##"
    vim.g.slime_default_config = {socket_name="default", target_pane="0"}
    vim.g.slime_dont_ask_default = 1
    vim.g.slime_bracketed_paste = 1
    vim.g.slime_no_mappings = 1
    vim.cmd([[
    nmap <leader>cv <Plug>SlimeConfig
    nmap <leader>cc <Plug>SlimeCellsSendAndGoToNext
    nmap <leader>cj <Plug>SlimeCellsNext
    nmap <leader>ck <Plug>SlimeCellsPrev
    ]])
  end
}
```

## Configuration

Here is an example of how you can configure vim-slime and vim-slime-cells to work together. Those settings are used in the preview.

```vim
" vim-slime
let g:slime_target = "tmux"
let g:slime_cell_delimiter = "^\\s*##"
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
let g:slime_dont_ask_default = 1
let g:slime_bracketed_paste = 1
let g:slime_no_mappings = 1
nmap <c-c>v <Plug>SlimeConfig

" vim-slime-cells
nmap <c-c><c-c> <Plug>SlimeCellsSendAndGoToNext
nmap <c-c><c-Down> <Plug>SlimeCellsNext
nmap <c-c><c-Up> <Plug>SlimeCellsPrev
```

## Documentation

See `:help slime-cells`.

## Credits

[vim-slime](https://github.com/jpalardy/vim-slime) is a very nice plugin developped by [Jonathan Palardy](https://github.com/jpalardy).

The original idea that makes the syntax-highlighting feature in vim-slime-cells work is from [@bensmrs](https://github.com/bensmrs), and the macro he came up with deserves a place here for posterity.

```vim
hi Match ctermbg=162
sig define highlightline linehl=Match
au TextChanged,TextChangedI,TextChangedP,BufWinEnter,BufWritePost,FileWritePost * if expand("%:p") != "" | exe("call map(range(1,1000), {i->execute('sig unplace 999 file='.expand('%:p'))})") | call map(getline(1, '$'), {idx, val -> execute('if val =~ "^\\s*##" | exe "sig place 999 line=".expand(idx+1)." name=highlightline file=".expand("%:p") | endif')}) | endif
```
