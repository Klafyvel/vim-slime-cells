if exists('g:loaded_slime_cells') || &cp || v:version < 700
  finish
endif
let g:loaded_slime_cells = 1

noremap <unique> <script> <silent> <Plug>SlimeCellsNext :<c-u>call slime_cells#go_to_next_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsPrev :<c-u>call slime_cells#go_to_previous_cell()<cr>
noremap <unique> <script> <silent> <Plug>SlimeCellsSendAndGoToNext :<c-u>call slime#send_cell()<cr>:call slime_cells#go_to_next_cell()<cr>
