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
    let parameters = ""

    if exists("g:slime_cells_fg_gui")
      let fg_gui=g:slime_cells_fg_gui
    else
      let fg_gui = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "fg", "gui")
    endif
    if len(fg_gui) > 0
      let parameters = parameters . " guifg=" . fg_gui
    endif


    if exists("g:slime_cells_fg_cterm")
      let fg_cterm=g:slime_cells_fg_cterm
    else
      let fg_cterm = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "fg", "cterm")
    endif
    if len(fg_cterm) > 0
      let parameters = parameters . " ctermfg=" . fg_cterm
    endif

    if exists("g:slime_cells_bg_gui")
      let bg_gui=g:slime_cells_bg_gui
    else
      let bg_gui = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "bg", "gui")
    endif
    if len(bg_gui) > 0
      let parameters = parameters . " guibg=" . bg_gui
    endif

    if exists("g:slime_cells_bg_cterm")
      let bg_cterm=g:slime_cells_bg_cterm
    else
      let bg_cterm = synIDattr(synIDtrans(hlID(g:slime_cells_highlight_from)), "bg", "cterm")
    endif
    if len(bg_cterm) > 0
      let parameters = parameters . " ctermbg=" . bg_cterm
    endif

    exe "hi! CellBoundary gui=underline cterm=underline" . parameters 
        
    autocmd TextChanged,TextChangedI,TextChangedP,BufWinEnter,BufWritePost,FileWritePost,BufEnter * :call slime_cells#sign_on_cell_boundaries()
endif
