set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
if has('nvim')
    set rtp+=~/.config/nvim/bundle/Vundle.vim
else
    set rtp+=~/.vim/bundle/Vundle.vim
endif
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'Konfekt/FastFold'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'preservim/nerdtree'
Plugin 'sheerun/vim-polyglot'
"Plugin 'aliev/vim-compiler-python'
"Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'vim-python/python-syntax'
Plugin 'tpope/vim-fugitive'
" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" set mapleader to spacebar
nnoremap <SPACE> <Nop>
let mapleader=" "

nnoremap <C-C> :noh<CR>
:command C let @/=""

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" help/info
nmap <leader>h <plug>(YCMHover)
map <C-M>    :NERDTree<CR>
" goto definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


set nu
" proper indentation
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
" Mark extra whitespace
au BufRead, BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/
" remove trailing whitespace on save
"autocmd FileType sh,h,c,cpp,java,py,md,tex
autocmd BufWritePre <buffer> %s/\s\+$//e

let g:python_highlight_all = 1
" encoding
set encoding=utf-8

" close autocomplete window after tab
let g:ycm_autoclose_preview_window_after_completion=1
" set correct path for python. Works with venv
let g:ycm_python_binary_path = 'python3'
" disable docstring window auto-popup
let g:ycm_auto_hover = ''

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

