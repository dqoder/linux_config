source $VIMRUNTIME/defaults.vim

set nu
set tabstop=4 " no. of col that a tab displays as
set shiftwidth=4 " no. of col to indent when hitting the TAB key
set softtabstop=4 " no. of col to index when using SHIFT OPERATION (>> and <<)
" set expandtab " convert tab key to specified number of spaces
" set smarttab " insert blanks when hitting tab in front of line
set autoindent


" vim-plug START
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins
Plug 'KarimElghamry/vim-auto-comment'
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'fladson/vim-kitty'
Plug 'tpope/vim-vinegar'
Plug 'ycm-core/YouCompleteMe'

" list ends here.
call plug#end()
" vim-plug END

" vim-auto-comment
" Block comment mapping
vnoremap <silent><C-k> :AutoBlockComment<CR>
nnoremap <silent><C-k> :AutoBlockComment<CR>

let g:block_comment_dict = {
		\'/*': ["js", "ts", "cpp", "c", "dart"],
		\'"""': ['py'],
		\}

" vim-rainbow
let g:rainbow_active = 1

" setting colorcolumn
set colorcolumn=80
highlight ColorColumn ctermbg=darkgrey

" cursor line (line under current line)
set cursorline

" code folding
set foldenable
set foldlevelstart=10
" nnoremap <space> za
set foldmethod=indent " fold based on indent

" project drawer -- hide banner
let g:netrw_banner=0
" 1 - new Hsplit ; 2 - new Vsplit ; 3 - new tab ; 4 - prev window ; 0 - cur
let g:netrw_browse_split = 4
" NERDTree like setup
let g:netrw_liststyle = 3
let g:netrw_altv = 1
let g:netrw_winsize = 25
augroup ProjectDrawer
	autocmd!
	autocmd VimEnter * :Vexplore
augroup END
 
" text width set
set textwidth=80

" highlight search (enter :noh) to remove highlight after search
set hlsearch 

" see - https://www.alexeyshmalko.com/2014/using-vim-as-c-cpp-ide/
" allows vim to check for local (in cwd) .vimrc
set exrc
" allows only limited command to be run on that .vimrc
set secure


