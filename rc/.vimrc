source $VIMRUNTIME/defaults.vim

set nu
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent


" vim-plug START
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins
Plug 'KarimElghamry/vim-auto-comment'
Plug 'frazrepo/vim-rainbow'
Plug 'jiangmiao/auto-pairs'
Plug 'fladson/vim-kitty'

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
