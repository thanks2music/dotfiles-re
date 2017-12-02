if &compatible
  set nocompatible
endif

augroup MyAutoCmd
  autocmd!
augroup END

function! s:source_rc(path, ...) abort "{{{
	let use_global = get(a:000, 0, !has('vim_starting'))
	let abspath = resolve(expand('~/.vim/nvim/' . a:path))
	if !use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let content = map(readfile(abspath),
				\ 'substitute(v:val,
	"^\\W*\\zsset\\ze\\W",
	"setglobal", "")')
	let tempfile = tempname()
	try
		call writefile(content,
		tempfile)
		execute 'source'
		fnameescape(tempfile)
	finally
		if
			filereadable(tempfile)
			call
			delete(tempfile)
		endif
	endtry
endfunction"}}}

if exists('g:nyaovim_version')
  let s:dein_cache_path = expand('~/.cache/nyaovim/dein')
elseif has('nvim')
  let s:dein_cache_path = expand('~/.cache/vim/dein')
else
  let s:dein_cache_path = expand('~/.cache/vim/dein')
endif

let s:dein_dir = s:dein_cache_path
                 \ .'/repos/github.com/Shougo/dein.vim'

if &runtimepath !~ '/dein.vim'
  if !isdirectory(s:dein_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_dir
  endif
  execute 'set runtimepath+=' . fnamemodify(s:dein_dir, ':p')
endif

if dein#load_state(s:dein_cache_path)
  call dein#begin(s:dein_cache_path)

  call dein#load_toml('~/dotfiles-re/dot.vim/nvim/dein.toml', {'lazy' : 0})
  call dein#load_toml('~/dotfiles-re/dot.vim/nvim/dein_lazy.toml', {'lazy' : 1})

  if exists('g:nyaovim_version')
    call dein#add('rhysd/nyaovim-popup-tooltip')
    call dein#add('rhysd/nyaovim-markdown-preview')
    call dein#add('rhysd/nyaovim-mini-browser')
  endif

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

runtime! options.rc.vim
runtime! keymap.rc.vim
