" Neovim specific configuration file

" Thanks to @tweekmonster for thinking of this.
" I've provided some modifications.

let g:_vimrc_base = expand('<sfile>:p:h')
let g:_vimrc_plugins = g:_vimrc_base.'/plugins'
let g:_vimrc_init = isdirectory(g:_vimrc_plugins)

let g:_vimrc_sources = get(g:, '_vimrc_sources', {})

if has('unix')
    let g:plugin_path = '~/.vim/plugged'
else
    let g:plugin_path = expand('$HOME') . '\nvim_plug'
endif

" Source all scripts in a directory
" They around found in `g:_vimrc_plugins`
function! s:source(dir) abort
  " Onlysource files that have the `.vim` extension
  for filename in sort(glob(g:_vimrc_base.'/'.a:dir.'/*.vim', 0, 1))
    " Old item from tweekmonster, I don't use it currently.
    " if !g:_vimrc_init && str2nr(fnamemodify(filename, ':t')[:1]) > 3
    "   continue
    " endif

    let mtime = getftime(filename)
    if !has_key(g:_vimrc_sources, filename) || g:_vimrc_sources[filename] < mtime
      let g:_vimrc_sources[filename] = mtime
      execute 'source '.filename
    endif
  endfor
endfunction

call s:source('init')

" vim:foldmethod=marker:foldlevel=0
