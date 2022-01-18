if exists('g:loaded_slime_cells') || &cp || v:version < 700
  finish
endif
let g:loaded_slime_cells = 1

noremap <unique> <script> <silent> <Plug>SlimeCellsSend :<c-u>call slime_cells#send_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsNext :<c-u>call slime_cells#go_to_next_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsPrev :<c-u>call slime_cells#go_to_previous_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsSendAndGoToNext :<c-u>call slime#send_cell()<cr>:call slime_cells#go_to_next_cell()<cr>

onoremap <silent> ic :<c-u>call slime_cells#select_current_cell(0)<cr>
onoremap <silent> ac :<c-u>call slime_cells#select_current_cell(1)<cr>
vnoremap <silent> ic :<c-u>call slime_cells#select_current_cell(0)<cr>
vnoremap <silent> ac :<c-u>call slime_cells#select_current_cell(1)<cr>

if !exists("g:slime_cells_highlight_from")
    let g:slime_cells_highlight_from = "SpecialComment"
endif

sig define SlimeCell linehl=CellBoundary

if !exists("g:slime_cells_no_highlight") || !g:slime_cells_no_highlight
    " Steal the style of g:slime_cells_highlight_from
    exe "hi! CellBoundary gui=underline cterm=underline" . 
        \" guifg=" . synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "fg", "gui") .
        \" ctermfg=" . synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "fg", "cterm") .
        \" guibg=" . synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "bg", "gui") .
        \" ctermbg=" . synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "bg", "cterm")
        
    autocmd TextChanged,TextChangedI,TextChangedP,BufWinEnter,BufWritePost,FileWritePost * :call slime_cells#sign_on_cell_boundaries()
endif
