" Rishabh's vimrc

source $VIMRUNTIME/defaults.vim

" color scheme
	" material colorscheme is used (via plugin) - configured @pluginConfiguration section

let mapleader=","

" vim-plug START
	call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')
	" Declare the list of plugins
		Plug 'KarimElghamry/vim-auto-comment'
		Plug 'frazrepo/vim-rainbow'
		Plug 'jiangmiao/auto-pairs'
		Plug 'fladson/vim-kitty'
		Plug 'tpope/vim-vinegar'
		Plug 'ycm-core/YouCompleteMe'
		Plug 'junegunn/goyo.vim'
		Plug 'junegunn/limelight.vim'
		Plug 'kaicataldo/material.vim', { 'branch': 'main' }
		Plug 'itchyny/lightline.vim'
	" list ends here.
	call plug#end()
" vim-plug END

" basic settings
	set nocompatible
	set nu relativenumber numberwidth=6
	set autoindent
	set encoding=utf-8
	set t_Co=256

	filetype plugin indent on

	" +xterm_clipboard (in vim --version)
	" check -- :echo has('clipboard')
	" not possible in manjaro -- workaround -- uninstall vim --
	" install gvim (and use vim after that )
	set	clipboard=unnamed

	set tabstop=4 " no. of col that a tab displays as
	set shiftwidth=4 " no. of col to indent when hitting the TAB key
	set softtabstop=4 " no. of col to index when using SHIFT OPERATION (>> and <<)
	" set expandtab " convert tab key to specified number of spaces
	" set smarttab " insert blanks when hitting tab in front of line

	set textwidth=80
	set hlsearch
	set cursorline

	" code folding
	set foldenable
	set foldlevelstart=10
	set foldmethod=indent

" disable auto comment on new line
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
" splitting defaults to right & bottom
	set splitbelow splitright
" Automatically deletes trailing whitespaces
	autocmd BufWritePre * %s/\s\+$//e

" plugin configurations
	" vim-rainbow
	let g:rainbow_active = 1

	" vim-auto-comment
		" it might happen that changes here would not reflect -> change source
		" file (vim-auto-comment.vim)
		" changes made (apart from below) : added &filetype check (prev : only
		" extention check -- || <similarToExt>(&filetype) )
		let g:autocomment_map_keys = 0
		nnoremap <silent><C-_> :AutoInlineComment<CR>
		vnoremap <silent><C-_> :AutoInlineComment<CR>

		" NOTE: check whether <C-k> is available
		vnoremap <silent><C-k> :AutoBlockComment<CR>
 		nnoremap <silent><C-k> :AutoBlockComment<CR>

		let g:block_comment_dict = {
				\'/*': ["js", "ts", "cpp", "c", "dart", "java"],
				\'"""': ['py'],
				\}

		let g:inline_comment_dict = {
					\'"':["vim"],
					\'#':["py", "sh"],
					\'//':["js", "ts", "cpp", "c", "dart", "java"],
					\}

	" Goyo
		" see - https://github.com/junegunn/goyo.vim/issues/160
		" let g:goyo_height=85
		autocmd! User GoyoLeave silent! source $HOME/.vimrc

	" Limelight
		" see - https://github.com/junegunn/limelight.vim#options
		" Color name (:help cterm-colors) or ANSI code
		let g:limelight_conceal_ctermfg = 'gray'
		let g:limelight_conceal_ctermfg = 240

		" Color name (:help gui-colors) or RGB color
		let g:limelight_conceal_guifg = 'DarkGray'
		let g:limelight_conceal_guifg = '#777777'

		" Default: 0.5
		let g:limelight_default_coefficient = 0.7

		" Number of preceding/following paragraphs to include (default: 0)
		let g:limelight_paragraph_span = 3

		" Beginning/end of paragraph
		"   When there's no empty line between the paragraphs
		"   and each paragraph starts with indentation
		let g:limelight_bop = '^\s'
		let g:limelight_eop = '\ze\n^\s'

		" Highlighting priority (default: 10)
		"   Set it to -1 not to overrule hlsearch
		let g:limelight_priority = -1

	" material colorscheme
		let g:material_terminal_italics = 1
		let g:material_theme_style = 'default'
		colorscheme material
 		let g:lightline = { 'colorscheme': 'material_vim' }

	" lightlime
		set laststatus=2


" coloring
	hi CursorLine cterm=bold ctermbg=233
	hi CursorLineNr cterm=bold ctermfg=black ctermbg=white
	hi LineNr ctermfg=darkgrey ctermbg=232

	" change Cursor color
	" see - https://vim.fandom.com/wiki/Configuring_the_cursor
	if &term =~ "xterm\\|rxvt"
		" use an magenta2 cursor in insert mode
		let &t_SI = "\<Esc>]12;magenta2\x7"
		" use a white cursor otherwise
		let &t_EI = "\<Esc>]12;white\x7"
		silent !echo -ne "\033]12;white\007"
		" reset cursor when vim exits
		autocmd VimLeave * silent !echo -ne "\033]112\007"
		" use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
	endif
	" change cursor shape
	if &term =~ "xterm\\|rxvt"
		" blinking block
		let &t_SI .= "\<Esc>[1 q"
		" blinking underscore
		let &t_EI .= "\<Esc>[3 q"
		" 1 -> blinking block
		" 2 -> solid block
		" 3 -> blinking underscore
		" 4 -> solid underscore
		" Recent versions of xterm (282 or above) also support
		" 5 -> blinking vertical bar
		" 6 -> solid vertical bar
	endif


" File exploring in vim
	" project drawer -- hide banner
	let g:netrw_banner=0
	" 1 - new Hsplit ; 2 - new Vsplit ; 3 - new tab ; 4 - prev window ; 0 - cur
	let g:netrw_browse_split = 4
	let g:netrw_liststyle = 3
	let g:netrw_altv = 1
	let g:netrw_winsize = 25


" custom functions
	" ------------------------------
	" toggle netrw explorer
	" ------------------------------
	let g:NetrwIsOpen=0
	function! ToggleNetrw()
		if g:NetrwIsOpen
			let i = bufnr("$")
			while (i >= 1)
				if (getbufvar(i, "&filetype") == "netrw")
					silent exe "bwipeout " . i
				endif
				let i-=1
			endwhile
			let g:NetrwIsOpen=0
		else
			let g:NetrwIsOpen=1
			silent Lexplore
		endif
	endfunction

	" ------------------------------
	" toggle limelight
	" ------------------------------
	let g:LimelightOn=0
	function! ToggleLimeLight()
		let s:comnd_ext = g:LimelightOn?"!":""
		silent exe "Limelight" . s:comnd_ext
		let g:LimelightOn=!g:LimelightOn
	endfunction




" setting map
	nnoremap <silent> <Leader>e :call ToggleNetrw()<CR>
	vnoremap <silent> <Leader>e :call ToggleNetrw()<CR>

	nnoremap <silent> <Leader>n :set nu! relativenumber!<CR>

	nnoremap <silent> <Leader>f :normal za<CR>
	vnoremap <silent> <Leader>f :normal za<CR>

	nnoremap <silent> <Leader>g :Goyo \| set linebreak<CR>
	nnoremap <silent> <Leader>l :call ToggleLimeLight()<CR>

	nnoremap <silent> <Leader>x :noh<CR>


" local (directory specific) .vimrc
	" see - https://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/
	set exrc
	set secure
