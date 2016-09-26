" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set encoding=utf-8

call plug#begin()
Plug 'fatih/vim-go'
Plug 'ntpeters/vim-better-whitespace'
Plug 'vim-scripts/YankRing.vim'
Plug 'godlygeek/tabular'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-endwise'
Plug 'plasticboy/vim-markdown'
Plug 'crosbymichael/vim-cfmt'
Plug 'elzr/vim-json'
Plug 'moorereason/vim-markdownfmt'
Plug 'rust-lang/rust.vim'
Plug 'klen/python-mode'
Plug 'racer-rust/vim-racer'
Plug 'ervandew/supertab'
Plug 'mhartington/oceanic-next'
Plug 'joshdick/onedark.vim'
Plug 'w0ng/vim-hybrid'
Plug 'junegunn/seoul256.vim'
Plug 'nanotech/jellybeans.vim'
Plug 'freeo/vim-kalisi'
Plug 'morhetz/gruvbox'
Plug 'zefei/cake16'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

filetype plugin indent on
syntax on

let mapleader = ","
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" Use system clipboard
" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has('clipboard')
  if has ('unnamedplus')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
endif

set termguicolors
set number             " Show line number
set encoding=utf-8     " Enable utf-8 encoding by default
set nobackup           " Disable backup file
set nowritebackup
set noswapfile         " Disable swap file
set undofile           " Enable undofile
set undodir=/tmp       " Set the undo destination to tmp
set undolevels=700     " Set how many undo vim has to remember
set autoread           " Set autoread when a file is changed from outside
set history=1000       " Sets how many lines of history vim has to remember
set so=7               " Set 7 lines to the cursor when moving vertical
set textwidth=79       " Default maximum textwidth is 79

" Theme
set background=dark
set synmaxcol=500      " not slow when highlight long line
set colorcolumn=80,120 " Highlight column 80 and 120 to remind us that we should open a new line
colorscheme gruvbox

set cmdheight=1        " Commandbar height
set hid                " Change buffer without saving
set switchbuf=useopen  " Use opened buffer instead of creating new one
set nowrap
set autoindent
set foldlevelstart=99
set foldmethod=manual
set hlsearch           " Highlight search
set incsearch          " incremental searching
set ignorecase         " ignore case when searching
set smartcase
set tabstop=2
set softtabstop=2
set shiftround
set shiftwidth=2
set expandtab
set modelines=0
set showmode
set showmatch
set gdefault
set scrolloff=5        " keep 5 lines when scrolling
set hidden
set laststatus=2
set number " Show line number
set numberwidth=5 "Max number is 99999
" Resize splits when the window is resized
au VimResized * :wincmd =

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

if has('cmdline_info')
  set ruler
  set showcmd
endif

set shortmess=atI   " Abbreviate messages
set fo=tcrqo " t autowraps text using textwidth
             " c autowraps comments using textwidth
             " r autoinserts the current comment leader
             " q allows formatting of comments
             " o auto insert comment leader when press o or O

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Turn on wildmenu
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.obj,.git,*.rbc,*.class,*.pyc,.svn,vendor/gems/*

" Tags
set tags=./tags;

" Supertab
" Let omnifunc and completefunc take precendence
set complete-=i
set completeopt=menu,menuone,longest " no scratch
set iskeyword+=- " do not use - as a word separator

" Remove whitespace on save
autocmd BufWritePre <buffer> :%s/\s\+$//e

"------------------------------------------------------------------------------
" KEYMAPS
"------------------------------------------------------------------------------

" <Leader>1: Toggle between paste mode
nnoremap <silent> <Leader>1 :set paste!<cr>

" Kill buffer
nnoremap K :bw<cr>

" Unfuck my screen
nnoremap U :syntax sync fromstart<cr>:redraw!<cr>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" Duplicate a selection
" Visual mode: D
vmap D y'>p

" map Y to make it consistent with C and D
nnoremap Y y$

" Maps arrow key resize
nnoremap <left> <C-w>5>
nnoremap <up> <C-w>5-
nnoremap <down> <C-w>5+
nnoremap <right> <C-w>5<

" Disable arrow keys when in insert-mode
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Quickfix
nmap <leader>c :copen<cr>
nmap <leader>e :Errors<cr>
nmap <leader>C :cclose<cr>
nmap <leader>cn :cnext<CR>
nmap <leader>cp :cprevious<CR>

" Navigate
nmap <leader>av :AV<CR>
nmap <leader>aa :A<CR>

" Nerdtree
let NERDTreeMinimalUI=1
let NERDTREEWinSize=30
nmap <silent><leader>nt :NERDTreeToggle<CR>
nmap <silent><leader>nf :NERDTreeFind<CR>

" Fugitive
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>dp :diffput<CR>
nnoremap <leader>dg :diffget<CR>

" reselect the text that was the pasted
nnoremap <leader>v V`]
nnoremap <silent> <leader>W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" Ack
map <leader>f :Ag! -i<space>

" NERDCommenter
map <leader>/ <plug>NERDCommenterToggle<CR>

" Insert hashrocket
imap <C-L> <Space>=><Space>

" fzf
nmap <leader><leader> :Files<CR>
nmap <leader>be :Buffers<CR>
nmap <leader>f :Ag<CR>

"remove highlight when press enter
nnoremap <CR> :noh<CR><CR>

" +/-: Increment number
nnoremap + <c-a>
nnoremap - <c-x>

" Goimport
let g:go_fmt_command = "goimports"

" Supertab
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" vim-racer
let g:racer_cmd = "racer"
let $RUST_SRC_PATH="/usr/local/rust/src/"

" Cfmt
let g:cfmt_style = '-linux'

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

"------------------------------------------------------------------------------
" FILETYPES
"------------------------------------------------------------------------------

au BufNewFile,BufRead *.txt setfiletype text
au BufNewFile,BufRead *.hbs set syntax=mustache
au BufNewFile,BufRead *.pde set filetype=c syntax=c cindent
au BufNewFile,BufRead *.html set textwidth=999
au BufNewFile,BufRead {Dockerfile} setlocal wrap linebreak nolist textwidth=120 syntax=off
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
autocmd BufWritePre *.c,*.h Cfmt
au FileType text setlocal textwidth=78

" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
" hacks from above (the url, not jesus) to delete fugitive buffers when we
" leave them - otherwise the buffer list gets poluted
" add a mapping on .. to view parent tree
au BufReadPost fugitive://* set bufhidden=delete
au BufReadPost fugitive://*
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END
