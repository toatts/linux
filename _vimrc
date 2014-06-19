" ========================= 
" VIMRC
" =========================

" General
" =========================
" Safely reset options for re-sourcing .vimrc                        
set nocompatible

" Lines of history remembered by Vim
set history=700

" Enable filetype plugins and auto-indentations
filetype indent plugin on

" Set to autoread when a file is changed from the outside
set autoread

" Map leader key to ,
let mapleader = ","

" Backup directory options set or removed
set nobackup
set nowb
set noswapfile
" OR
" set backupdir=.\_backup,.,C:\Temp
" set directory=.,.\_backup,C:\Temp

" User Interface
" =========================
" Background colorscheme settings 
set background=dark
colorscheme elflord

" Enable syntax highlighting 
syntax on

" Set encoding to UTF-8
set encoding=utf8

" Set 7 lines to the cursor for easier movement with j/k
set so=7

" Enable wildmenu for better command-line completion
set wildmenu

" Use Linux style wildmenu
set wildmode=longest:list,full

" Always show cursor position on the last line of the screen
set ruler

" Set the command window height to 2 lines, avoids "Press to continue" options
set cmdheight=2

" Allows you to re-use the same window and switch from an unsaved buffer without 
" saving it first. Also allows you to keep an undo history for multiple files 
" when re-using the same window in this way. Note that using persistent undo also 
" lets you undo in multiple files even in the same window, but is less efficient 
" and is actually designed for keeping undo history after closing Vim entirely. 
" Vim will complain if you try to quit without saving, and swap files will keep 
" you safe if your computer crashes.
set hidden

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" TODO: not sure if I will like this. 
" Wraps cursor back to previous/next line
set whichwrap+=<,>,h,l

" Wraps lines without line break
set wrap
set formatoptions=1
set lbr

" Don't redraw while executing macros (for performance)
set lazyredraw

" For regular expressions, turn magic on 
set magic

" Show matching brackets when text indicator is on them
set showmatch
" and blink every 0.2 seconds when matching
set mat=2

" Remove error bells
set noerrorbells
set novisualbell
" Reset terminal code for the visual bell. 
set t_vb=

" Use spaces instead of tabs
set expandtab

" Set tab width to four spaces 
set shiftwidth=4
set tabstop=4

" Keep indenting at the same level you are currently on with newline         
set autoindent

" Automatically adds extra indent in some cases
" TODO: may break different languages
set smartindent

" Enable use of the mouse for all modes
set mouse=a

" Display line numbers on the left
set number

" Show partial commands in the last line of the screen
set showcmd

" Show current mode
set showmode

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Automatically make working directory the current directory
set autochdir

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Always display the status line, even if only one window is displayed
set laststatus=2

set statusline=%F       " Full filename
set statusline+=%h      " Help file flag
set statusline+=%m      " Modified flag
set statusline+=%r      " Read only flag
set statusline+=\ %y    " Filetype
set statusline+=%=      " Left/Right separator
set statusline+=%c:     " Cursor column
set statusline+=%l/%L   " Cursor line/total lines
set statusline+=\ %P    " Percent through file

" Use <F10> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F10>

" Searching
" =========================

" Ignore case when searching
set ignorecase

" Smart case searching
set smartcase

" Move cursor to next matched string while typing pattern
set incsearch

" Highlight searches, to remove highlighting, use :nohl
set hlsearch

" Search highlighted text while in visual mode
vnoremap <silent> * :call VisualSelection('f', '')<CR>

" Mappings
" =========================
" Fast saving
nmap <leader>w :w!<CR>

" Mappings for this file and sourcing it
" Linux
" map <F11> :e $HOME/.vimrc<CR>
" map <F12> :so $HOME/.vimrc<CR>
" Windows
map <F11> :e  $VIM\_vimrc<CR>
map <F12> :so $VIM\_vimrc<CR>

" Change j and k to work better in wrap
map j gj
map k gk

" Map tab movement to control left/right 
map <C-l>     :tabnext<CR>
map <C-Right> :tabnext<CR>
map <C-h>     :tabprevious<CR>
map <C-Left>  :tabprevious<CR>
map <C-n>     :tabnew<CR>
map <leader>te :tabedit <c-r>=expand("%:p:h")<CR>/

" Map buffer movement to control up/down 
map <C-Up>   :bp<CR>
map <C-k>    :bp<CR>
map <C-Down> :bn<CR>
map <C-j>    :bn<CR>

" Map page movement to leader
nmap <leader>h          :wincmd h<CR>
nmap <silent> <A-Left>  :wincmd h<CR>
nmap <leader>l          :wincmd l<CR>
nmap <silent> <A-Right> :wincmd l<CR>
nmap <leader>k          :wincmd k<CR>
nmap <silent> <A-Up>    :wincmd k<CR>
nmap <leader>j          :wincmd j<CR>
nmap <silent> <A-Down>  :wincmd j<CR>

" Disable highlighting 
map <silent> <leader><CR> :nohl<CR>

" Misc.    
" =========================
" Set tags to search current directory first, and then search up directories if not found
set tags=./tags,tags;

" Auto Commands
" =========================
" Delete trailing whitespace, add file extensions as necessary
autocmd BufWrite *.py :call DeleteTrailingWS()

" System Verilog options
autocmd BufRead,BufNewFile *.v,*.vh set filetype=verilog
autocmd BufRead,BufNewFile *.sv,*.svh set filetype=verilog_systemverilog

" Functions     
" =========================
" Delete trailing white space on save
function! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Visual selection searching
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction
