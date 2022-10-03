if exists('g:loaded_slime_cells') || &cp || v:version < 700
  finish
endif
let g:loaded_slime_cells = 1

noremap <unique> <script> <silent> <Plug>SlimeCellsSend :<c-u>call slime_cells#send_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsNext :<c-u>call slime_cells#go_to_next_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsPrev :<c-u>call slime_cells#go_to_previous_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsSendAndGoToNext :<c-u>call slime_cells#send_cell_and_go_to_next()<cr>

onoremap <silent> ic :<c-u>call slime_cells#select_current_cell(0)<cr>
onoremap <silent> ac :<c-u>call slime_cells#select_current_cell(1)<cr>
vnoremap <silent> ic :<c-u>call slime_cells#select_current_cell(0)<cr>
vnoremap <silent> ac :<c-u>call slime_cells#select_current_cell(1)<cr>

if !exists("g:slime_cells_highlight_from")
    let g:slime_cells_highlight_from = "SpecialComment"
endif

sig define SlimeCell linehl=CellBoundary

if !exists("g:slime_cells_no_highlight") || !g:slime_cells_no_highlight
    let fg_gui = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "fg", "gui")
    if exists("g:slime_cells_fg_gui")
      let fg_gui=g:slime_cells_fg_gui
    elseif len(fg_gui) == 0
      let fg_gui = "White"
    endif

    let fg_cterm = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "fg", "cterm")
    if exists("g:slime_cells_fg_cterm")
      let fg_cterm=g:slime_cells_fg_cterm
    elseif len(fg_cterm) == 0
      let fg_cterm = "White"
    endif

    let bg_gui = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "bg", "gui")
    if exists("g:slime_cells_bg_gui")
      let bg_gui=g:slime_cells_bg_gui
    elseif len(bg_gui) == 0
      let bg_gui = 0
    endif

    let bg_cterm = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "bg", "cterm")
    if exists("g:slime_cells_bg_cterm")
      let bg_cterm=g:slime_cells_bg_cterm
    elseif len(bg_cterm) == 0
      let bg_cterm = 0
    endif

    exe "hi! CellBoundary gui=underline cterm=underline" . 
        \" guifg=" . fg_gui .
        \" ctermfg=" . fg_cterm .
        \" guibg=" . bg_gui .
        \" ctermbg=" . bg_cterm
        
    autocmd TextChanged,TextChangedI,TextChangedP,BufWinEnter,BufWritePost,FileWritePost,BufEnter * :call slime_cells#sign_on_cell_boundaries()
endif
