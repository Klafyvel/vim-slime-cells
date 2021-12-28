# vim-slime-cells
A plugin on top of [vim-slime](https://github.com/jpalardy/vim-slime) to enhance its cell feature. It adds the possibility to jump between cells and to send the current cell then jump to the next one.

## Installation

You can use Vim-Plug:
```vim
Plug 'klafyvel/vim-slime-cells'
```

## Configuration

Here is an example of how you can configure vim-slime and vim-slime-cells to work together.

```vim
" vim-slime
let g:slime_target = "tmux"
let g:slime_cell_delimiter = "^\\s*##"
let g:slime_default_config = {"socket_name": "default", "target_pane": "0"}
let g:slime_bracketed_paste = 1
let g:slime_no_mappings = 1
nmap <c-c>v <Plug>SlimeConfig

" vim-slime-cells
nmap <c-c><c-c> <Plug>SlimeCellsSendAndGoToNext
nmap <c-c>n <Plug>SlimeCellsNext
nmap <c-c>p <Plug>SlimeCellsPrev
```

## Documentation

See `:help slime-cells`.
