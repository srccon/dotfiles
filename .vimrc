" Vim Pathogen
" plugin management for vim runtime 
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()

" Add syntax highlighting
syntax on

" I think it does indenting in things like python
filetype plugin indent on

" ends compatibility with vi
set nocompatible

" adds line numbering
set number

" all to auto load buffer on external file change
set autoread

" highlight tabs and trailing spaces
"set listchars=tab:>-,trail:-
set list

" General
set linebreak	" Break lines at word (requires Wrap lines)
set showbreak= 	" Wrap-broken line prefix
" set textwidth=100	" Line wrap (number of cols)
set showmatch	" Highlight matching brace
set errorbells	" Beep or flash screen on errors
set wrapscan    " Searches wrap around end-of-file.

set hlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally
 
set autoindent	" Auto-indent new lines
set expandtab	" Use spaces instead of tabs
set shiftwidth=4	" Number of auto-indent spaces
set smartindent	" Enable smart-indent
set smarttab	" Enable smart-tabs
set softtabstop=4	" Number of spaces per Tab
set shiftround

set ttyfast     " Faster redrawing
set lazyredraw  " Only redraw when necessary

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

"" Advanced
set ruler	" Show row and column ruler information
set undolevels=1000	" Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour
  
" Ctrlp keybindings
"let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlP'

" line wrap jumping
map j gj
map k gk

" NERDTree bindings
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


" Dvorak Keybindings (eventaully)
" Dvorak it!
"no d h
"no h j
"no t k
"no n l
"no s :
"no S :
"no j d
"no l n
"no L N
"" Added benefits
"no - $
"no _ ^
"no N <C-w><C-w>
"no T <C-w><C-r>
"no H 8<Down>
"no T 8<Up>
"no D <C-w><C-r>

" Syntastic helpers
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo
