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
" Fold python code properly
Plugin 'tmhedberg/SimpylFold'
" Faster folding
Plugin 'Konfekt/FastFold'
Plugin 'neoclide/coc.nvim'
Plugin 'preservim/nerdtree'
Plugin 'sheerun/vim-polyglot'
"Plugin 'aliev/vim-compiler-python'
"Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'vim-python/python-syntax'
" jupyter notebooks
Plugin 'goerz/jupytext.vim'
" R support
Plugin 'jalvesaq/Nvim-R'
" Execute code in REPL
Plugin 'jpalardy/vim-slime'
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
"Plugin 'myusuf3/numbers.vim'
" Nice icons in the file explorer and file type status line.
Plugin 'ryanoasis/vim-devicons'
if using_neovim
    Plugin 'mfussenegger/nvim-dap'
endif

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

" set target for piping code
if using_neovim
    let g:slime_target = "neovim"
else 
    let g:slime_target = "vimterminal"
endif
" configure slime correct when piping python
let file_ext = expand('%:e')
if file_ext == 'py' || file_ext == 'ipynb'
    let g:slime_python_ipython = 1
endif

" set mapleader to spacebar
noremap <SPACE> <Nop>
let mapleader=' '
" set local mapleader to §
nnoremap <§> <Nop>
let maplocalleader='§'
" activate mouse
set mouse=a

" clear search result
nnoremap <silent> <Leader>c :noh<CR>

" Window switching
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" help/info
nmap <leader>h <plug>(YCMHover)
map <C-M> :NERDTree<CR>
" goto definition
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Undotree hotkey
nnoremap <F5> :UndotreeToggle<CR>

" dap
if using_neovim
    lua <<EOF
    local dap = require('dap')
    dap.defaults.fallback.external_terminal = {
        command = '/usr/bin/alacritty';
        args = {'-e'}
    }
    dap.defaults.fallback.force_external_terminal = true
    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/lldb-vscode', -- adjust as needed
      name = "lldb"
    }
    dap.configurations.cpp = {
      {
        name = "Launch",
        type = "lldb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = {},

        -- 💀
        -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
        --
        --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
        --
        -- Otherwise you might get the following error:
        --
        --    Error on launch: Failed to attach to the target process
        --
        -- But you should be aware of the implications:
        -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

        runInTerminal = false,

        -- 💀
        -- If you use `runInTerminal = true` and resize the terminal window,
        -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
        -- To avoid that uncomment the following option
        -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
        postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
      },
    }
    -- If you want to use this for rust and c, add something like this:
    --dap.configurations.c = dap.configurations.cpp
    --dap.configurations.rust = dap.configurations.cpp

EOF

    nnoremap <leader>tp :lua require'dap'.toggle_breakpoint()<CR>
    nnoremap <leader>db :lua require'dap'.continue()<CR>
    nnoremap <F10> :lua require'dap'.step_over()<CR>
    nnoremap <F11> :lua require'dap'.step_into()<CR>
    nnoremap <leader>i :lua require'dap'.repl.open()<CR>
endif

set updatetime=300
set nu
if has("nvim-0.5.0") || has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif



" proper indentation
au BufNewFile, BufRead *.py
    \ set tabstop=4
    \ set softtabstop=4
    \ set shiftwidth=4
    \ set textwidth=79
    \ set expandtab
    \ set autoindent
    \ set fileformat=unix
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=79
set expandtab
set autoindent
set fileformat=unix
" Mark extra whitespace
au BufRead, BufNewFile * match BadWhitespace /\s\+$/
" remove trailing whitespace on save
"autocmd FileType sh,h,c,cpp,java,py,md,tex
autocmd BufWritePre *.py,*.pyw,*.c,*.cc,*.cpp,*.h,*.java,*.md,*.sh,*.tex :%s/\s\+$//e

let g:python_highlight_all = 1

let g:python3_host_prog = '/home/tiger/.pyenv/versions/neovim/bin/python'

" -------------------- coc settings --------------------
let g:coc_filetype_map = {'javascriptreact': '*.js'}
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" -------------------- end of coc settings --------------------

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

" keep cursor 5 lines away from screen border when scrolling
set scrolloff=5

" Airline ------------------------------
let g:airline_powerline_fonts = 1
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 1
let g:webdevicons_enable = 1

