set nocompatible              " required
filetype off                  " required
" encoding
set encoding=utf-8

" set the runtime path to include Vundle and initialize
let using_neovim = has('nvim')
if using_neovim
    set rtp+=~/.config/nvim/bundle/Vundle.vim
    call vundle#begin('~/.config/nvim/bundle/')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" add all your plugins here (note older versions of Vundle
" used Bundle instead of Plugin)
" themes
Plugin 'patstockwell/vim-monokai-tasty'
" Airline
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
"Plugin 'tmhedberg/SimpylFold'
"Plugin 'Konfekt/FastFold'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'preservim/nerdtree'
Plugin 'sheerun/vim-polyglot'
"Plugin 'aliev/vim-compiler-python'
"Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'vim-python/python-syntax'
" R support
Plugin 'jalvesaq/Nvim-R'
" fzf
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'junegunn/fzf.vim'
" Git integration
Plugin 'tpope/vim-fugitive'
" Git diff highlighting
Plugin 'airblade/vim-gitgutter'
" Session management
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
" Undotree
Plugin 'mbbill/undotree'
" auto close parenthesis etc
Plugin 'Raimondi/delimitMate'
" surrounding helper
Plugin 'tpope/vim-surround'
" Relative numbering
Plugin 'myusuf3/numbers.vim'
" Nice icons in the file explorer and file type status line.
"Plugin 'ryanoasis/vim-devicons'

" ...

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" undo files
if has("persistent_undo")
    if using_neovim
        let vim_path = expand('~/.config/nvim')
        let target_path = expand('~/.config/nvim/undodir')
    else
        let vim_path = expand('~/.vim/')
        let target_path = expand('~/.vim/undodir')
    endif
    if !isdirectory(vim_path)
        call mkdir(vim_path, "", 0770)
    endif
    if !isdirectory(target_path)
        call mkdir(target_path, "", 0700)
    endif
    let &undodir=target_path
    set undofile
endif

" set mapleader to spacebar
nnoremap <SPACE> <Nop>
let mapleader=" "
" set local mapleader to §
nnoremap <§> <Nop>
let maplocalleader="§"
" activate mouse
set mouse=a

" clear search result
nnoremap <silent> <leader>/ :noh<CR>

" Window switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" help/info
nmap <leader>h <plug>(YCMHover)
map <C-M>    :NERDTree<CR>
" goto definition
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Undotree hotkey
nnoremap <F5> :UndotreeToggle<CR>

set updatetime=100
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
au BufRead, BufNewFile * match BadWhitespace /\s\+$/
" remove trailing whitespace on save
"autocmd FileType sh,h,c,cpp,java,py,md,tex
autocmd BufWritePre *.py,*.pyw,*.c,*.cc,*.cpp,*.h,*.java,*.md,*.sh,*.tex :%s/\s\+$//e

let g:python_highlight_all = 1

" close autocomplete window after tab
let g:ycm_autoclose_preview_window_after_completion=1
" set correct path for python. Works with venv
let g:ycm_python_binary_path = 'python3'
" disable docstring window auto-popup
let g:ycm_auto_hover = ''

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
highlight! link NERDTreeFlags NERDTreeDir
" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" map <- in R files
let R_assign_map = '<C-s>'

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
    let g:vim_monokai_tasty_italic = 1
    colorscheme vim-monokai-tasty
else
    colorscheme delek
endif

" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227


" save as sudo
ca w!! w !sudo tee "%"

" keep cursor 3 lines away from screen border when scrolling
set scrolloff=3

" Airline ------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 1
let g:webdevicons_enable = 1

