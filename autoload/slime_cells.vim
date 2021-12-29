function! slime_cells#get_delimiter()
  if exists("b:slime_cell_delimiter")
    let cell_delimiter = b:slime_cell_delimiter
  elseif exists("g:slime_cell_delimiter")
    let cell_delimiter = g:slime_cell_delimiter
  else
    echoerr "b:slime_cell_delimeter is not defined"
    return ""
  endif
    return cell_delimiter
endfunction

" This function is directly adapted from vim-slime. (https://github.com/jpalardy/vim-slime)
function! slime_cells#send_cell() abort
  let cell_delimiter = slime_cells#get_delimiter()
  if cell_delimiter == ""
      return
  endif

  let line_ini = search(cell_delimiter, 'bcnW')
  let line_end = search(cell_delimiter, 'nW')

  " line after delimiter or top of file
  let line_ini = line_ini ? line_ini + 1 : 1
  " line before delimiter or bottom of file
  let line_end = line_end ? line_end - 1 : line("$")

  if line_ini <= line_end
    call slime#send_range(line_ini, line_end)
  endif
endfunction

function! slime_cells#go_to_next_cell()
  let cell_delimiter = slime_cells#get_delimiter()
  if cell_delimiter == ""
      return
  endif
  let line = search(cell_delimiter, 'eW')
  let line = line ? line : line("$")
  call cursor(line, 0)
endfunction

function! slime_cells#go_to_previous_cell()
  let cell_delimiter = slime_cells#get_delimiter()
  if cell_delimiter == ""
      return
  endif
  let line = search(cell_delimiter, 'Wbz')
  let line = line ? line : 1
  call cursor(line, 0)
endfunction

function! slime_cells#sign_on_cell_boundaries()
  if expand("%:p") != ""
    let cell_delimiter = slime_cells#get_delimiter()
    if cell_delimiter == ""
        return
    endif
    call sign_unplace("slime-cells")
    call map(getline(1, '$'), {idx, val ->val =~ cell_delimiter ? sign_place(0, "slime-cells", "SlimeCell", expand("%:p"), {"lnum": idx+1}) : 1})
  endif
endfunction

