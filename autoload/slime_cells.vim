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
