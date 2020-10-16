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
set autowrite  " Writes the content of the file automatically (save) when you call :make (vim-go)"

set backspace=indent,eol,start            " Fix backspace behavior on most terminals.


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

Plug 'tomasiser/vim-code-dark'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-unimpaired'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go'
Plug 'SirVer/ultisnips'

call plug#end()

colorscheme codedark         " Change a colorscheme.
" Ctrlp settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_working_path_mode = 'ra'

set tags=tags; " Look for tags file recursively in parent directories

autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Vim-go settings
let g:go_fmt_command = 'goimports' " Run goimports on current file on save
let g:go_auto_type_info = 1 " Status line types/signatures
let g:go_auto_sameids = 1 " automatically highlights matching identifiers

" run :GoBuild or :GoTestCompile based on the file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#test#Test(0, 1)
    elseif l:file =~# '^\f+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

autocmd Filetype go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd Filetype go nmap <leader>b <Plug>(go-build)
autocmd Filetype go nmap <leader>r <Plug>(go-run)
autocmd Filetype go nmap <leader>t <Plug>(go-test)

map <C-n> :cnext<CR>
map <C-m> :cprevious<CR>

