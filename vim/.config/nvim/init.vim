" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set encoding=utf-8

call plug#begin()
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'

Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'godlygeek/tabular'
Plug 'jlanzarotta/bufexplorer'
Plug 'ntpeters/vim-better-whitespace'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'mhinz/vim-grepper'
Plug 'vim-scripts/YankRing.vim'

Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'

Plug 'lepture/vim-jinja'
Plug 'crosbymichael/vim-cfmt'
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'moorereason/vim-markdownfmt', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'racer-rust/vim-racer', {'for': 'rust'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
Plug 'garyburd/go-explorer', {'for': 'go'}
Plug 'zchee/deoplete-jedi', {'for': 'python'}
Plug 'python-mode/python-mode', {'for': 'python'}
Plug 'robbles/logstash.vim'
Plug 'saltstack/salt-vim'

Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'nanotech/jellybeans.vim'
Plug 'jacoborus/tender.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
call plug#end()

filetype plugin indent on
syntax on

let mapleader = ","
set backspace=indent,eol,start " allow backspacing over everything in insert mode

" Use system clipboard
" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has('clipboard')
  set clipboard+=unnamedplus
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
" set background=dark
set synmaxcol=500      " not slow when highlight long line
set colorcolumn=80,120 " Highlight column 80 and 120 to remind us that we should open a new line
let g:jellybeans_use_gui_italics = 0
colorscheme jellybeans
" with material-theme display the split bar
" hi VertSplit guibg=bg guifg=fg

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

" Let omnifunc and completefunc take precendence
set complete-=i
set completeopt=menu,menuone,longest,noselect " no scratch
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
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$']

" Fugitive
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>dp :diffput<CR>
nnoremap <leader>dg :diffget<CR>

" reselect the text that was the pasted
nnoremap <leader>v V`]
nnoremap <silent> <leader>W :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>:retab<CR>

" NERDCommenter
map <leader>/ <plug>NERDCommenterToggle<CR>

" fzf
nmap <leader><leader> :Files<CR>

" vim-grepper
" bind K to grep word under cursor
nnoremap K :GrepperRg "\b<C-R><C-W>\b"<CR>:cw<CR>
" bind \ (backward slash) to grep shortcut
nmap <leader>f :GrepperRg --smart-case<SPACE>

" quickfix
nmap <leader>q :copen<CR>
nmap <leader>qc :cclose<CR>

"remove highlight when press enter
nnoremap <CR> :noh<CR><CR>

" +/-: Increment number
nnoremap + <c-a>
nnoremap - <c-x>

" Goimport
let g:go_fmt_command = "goimports"

" deoplete.vim
let g:deoplete#enable_at_startup = 1 " Run deoplete.nvim automatically
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Python
let g:pymode_rope_completion = 0
let g:pymode_options_max_line_length = 120
let g:pymode_lint_options_pep8 =
      \ {'max_line_length': g:pymode_options_max_line_length}

" JSON
let g:vim_json_syntax_conceal = 0

" vim-racer
let g:racer_cmd = "racer"
let $RUST_SRC_PATH="/usr/local/rust/src/"

" Cfmt
let g:cfmt_style = '-linux'

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_new_list_item_indent = 2

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" yankring
" https://github.com/neovim/neovim/issues/2642
let g:yankring_clipboard_monitor = 0

" tagbar
nmap <leader>tt :TagbarToggle<CR>

" lightline
let g:lightline = { 'colorscheme': 'nord' }

"------------------------------------------------------------------------------
" FILETYPES
"------------------------------------------------------------------------------

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
augroup END

au BufNewFile,BufRead Makefile.* setlocal nolist tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
au BufNewFile,BufRead *.sh setlocal nolist tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
au BufNewFile,BufRead *.go set nolist
au BufNewFile,BufRead *.txt setfiletype text
au BufNewFile,BufRead *.hbs set syntax=mustache
au BufNewFile,BufRead *.pde set filetype=c syntax=c cindent
au BufNewFile,BufRead *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.proto setlocal nolist tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
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
