" Map arrow keys to no-ops
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Immediately add a closing quotes or braces in insert mode
inoremap ' ''<esc>i
inoremap " ""<esc>i
inoremap ( ()<esc>i
inoremap { {}<esc>i
inoremap [ []<esc>i

syntax on                  " Enable syntax highlighting.
filetype plugin indent on  " Enable file type based indentation.

packloadall " Load all plugins
silent! helptags ALL " Load help files for all plugins

set number
set autoindent             " Respect indentation when starting a new line.
set expandtab              " Expand tabs to spaces. Essential in Python.
set tabstop=4              " Number of spaces tab is counted for.
set shiftwidth=4           " Number of spaces to use for autoindent.
set hlsearch
set incsearch

set backspace=2            " Fix backspace behavior on most terminals.

colorscheme codedark         " Change a colorscheme.

" Set up persistent undoing across files
set undofile
if !isdirectory("$HOME/.vim/undodir")
    call mkdir("$HOME/.vim/undodir", "p")
endif    
set undodir="$HOME/.vim/undodir"

set wildmenu
set wildmode=list:longest,full " Complete until longest string then open wildmenu

" Install vim-plug if it's not already installed.
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin() " Manage plugins with vim-plug

Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'sjl/gundo.vim'

call plug#end()

" Ctrlp settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_working_path_mode = 'ra'

set tags=tags; " Look for tags file recursively in parent directories
