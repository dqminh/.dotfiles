" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set encoding=utf-8

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'Raimondi/delimitMate'
Plug 'Yggdroot/indentLine'
Plug 'jlanzarotta/bufexplorer'
Plug 'ntpeters/vim-better-whitespace'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-rhubarb'
Plug 'vim-scripts/YankRing.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/gv.vim'
Plug 'fatih/vim-go'
Plug 'Shougo/echodoc.vim'
Plug 'majutsushi/tagbar'

Plug 'junegunn/fzf.vim'

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-eunuch'

Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'

Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-sayonara'

Plug 'lepture/vim-jinja'
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'moorereason/vim-markdownfmt', {'for': 'markdown'}
Plug 'rust-lang/rust.vim'
Plug 'robbles/logstash.vim'
Plug 'saltstack/salt-vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

Plug 'vim-utils/vim-cscope'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make', 'for': 'go'}
Plug 'vim-scripts/a.vim'
Plug 'janko-m/vim-test'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" themes
Plug 'itchyny/lightline.vim'
Plug 'chriskempson/base16-vim'
call plug#end()

call glaive#Install()
" Optional: Enable codefmt's default mappings on the <Leader>= prefix.
Glaive codefmt plugin[mappings]


filetype plugin indent on
syntax on

let mapleader = ","
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set mouse=a

" Use system clipboard
" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if has('clipboard')
  set clipboard+=unnamedplus
endif

set termguicolors
" for true color inside tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

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
set textwidth=88       " Default maximum textwidth is 88

" Theme
set synmaxcol=300      " not slow when highlight long line
set colorcolumn=80,120 " Highlight column 80 and 120 to remind us that we should open a new line
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

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

" set direction of split
set splitright

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
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·

" Turn on wildmenu
set wildmenu
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.o,*.obj,.git,*.rbc,*.class,*.pyc,.svn,vendor/gems/*

" Let omnifunc and completefunc take precendence
set complete-=i
set completeopt=menu,menuone,longest,noselect " no scratch
set iskeyword-=- " do not use - as a word separator

" Remove whitespace on save
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0


"------------------------------------------------------------------------------
" KEYMAPS
"------------------------------------------------------------------------------

" Terminal settings
tnoremap <Leader><ESC> <C-\><C-n>

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
nmap <leader>C :cclose<cr>
nmap <leader>e :Errors<cr>
nmap <leader>cn :cnext<CR>
nmap <leader>cp :cprevious<CR>

" delete the buffer
nnoremap <silent> <leader>q :Sayonara!<CR>

" Nerdtree
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTREEWinSize=30
nmap <silent><leader>nt :NERDTreeToggle<CR>
nmap <silent><leader>nf :NERDTreeFind<CR>
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$', '\.o.d$', '\..\.cmd$', '\.egg-info$', '\.ko$', '\.mod.c$', '\.order$', '\.symvers$', '\.ko.cmd$']
let NERDTreeHighlightCursorline=1
let NERDTreeDirArrowExpandable = ""
let NERDTreeDirArrowCollapsible = ""

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
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" fzf
nmap <leader><leader> :Files<CR>
nmap <leader>f :Rg<space>
nnoremap F :execute ':Rg '.expand('<cword>')<CR>

"remove highlight when press enter
nnoremap <CR> :noh<CR><CR>

" +/-: Increment number
nnoremap + <c-a>
nnoremap - <c-x>

" JSON
let g:vim_json_syntax_conceal = 0

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_new_list_item_indent = 2

" lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath', 'modified' ] ]
      \ }
      \ }

" yankring
" fix for neovim
let g:yankring_clipboard_monitor=0

" Language Server
let g:LanguageClient_serverCommands = {
      \ 'go': ['~/bin/gopls'],
      \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
      \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
      \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
      \ 'python': ['pyls', '--log-file=/tmp/pyls.log'],
      \ }

let g:LanguageClient_rootMarkers = {
      \ 'cpp': ['compile_commands.json', 'build'],
      \ 'c': ['compile_commands.json', 'build'],
      \ }

" https://github.com/autozimu/LanguageClient-neovim/issues/379 LSP snippet is not supported
let g:LanguageClient_hasSnippetSupport = 0
let g:LanguageClient_loadSettings = 1 " Use an absolute configuration path if you want system-wide settings
let g:LanguageClient_settingsPath = '/home/dqminh/.config/nvim/settings.json'
set completefunc=LanguageClient#complete

" vim-go
let g:go_def_mode= "gopls"
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1

autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()
" autocmd BufWritePre *.py :call LanguageClient#textDocument_formatting_sync()

nnoremap <leader>gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>gr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>gt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>gx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>ga :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>gh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>gz :call LanguageClient#textDocument_formatting_sync()<CR>
nnoremap <leader>zf :call LanguageClient#textDocument_rangeFormatting_sync()<CR>
nnoremap <leader>gs :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>gm :call LanguageClient_contextMenu()<CR>


" caller
au FileType c,cpp nn <silent> xc :call LanguageClient#findLocations({'method':'$ccls/call'})<cr>
" callee
au FileType c,cpp nn <silent> xC :call LanguageClient#findLocations({'method':'$ccls/call','callee':v:true})<cr>
au FileType c setlocal noexpandtab

augroup LanguageClient_config
  au!
  au BufEnter * let b:Plugin_LanguageClient_started = 0
  au User LanguageClientStarted setl signcolumn=yes
  au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1lways draw the signcolumn.
  set signcolumn=yes

  au User LanguageClientStopped setl signcolumn=auto
  au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
augroup END

" these "Ctrl mappings" work well when Caps Lock is mapped to Ctrl
nmap <silent> t<C-n> :TestNearest<CR> " t Ctrl+n
nmap <silent> t<C-f> :TestFile<CR>    " t Ctrl+f
nmap <silent> t<C-s> :TestSuite<CR>   " t Ctrl+s
nmap <silent> t<C-l> :TestLast<CR>    " t Ctrl+l
nmap <silent> t<C-g> :TestVisit<CR>   " t Ctrl+g
let test#strategy = "neovim"

" tag bar
nmap <F8> :TagbarToggle<CR>

"------------------------------------------------------------------------------
" FILETYPES
"------------------------------------------------------------------------------

augroup autoformat_settings
  "autocmd FileType c,proto AutoFormatBuffer clang-format
  "autocmd FileType python AutoFormatBuffer yapf
augroup END

au BufRead,BufNewFile *.wuffs setf go
au BufRead,BufNewFile *.bzl,BUILD,sky setf python.skylark
au BufNewFile,BufRead Makefile.* setlocal nolist tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
au BufNewFile,BufRead *.sh setlocal nolist tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
au BufNewFile,BufRead *.xml setlocal softtabstop=2 tabstop=2 shiftwidth=2
au BufNewFile,BufRead *.go set nolist
au BufNewFile,BufRead *.txt setfiletype text
au BufNewFile,BufRead *.hbs set syntax=mustache
au BufNewFile,BufRead *.pde set filetype=c syntax=c cindent
au BufNewFile,BufRead *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
au BufNewFile,BufRead *.proto setlocal nolist tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
au BufNewFile,BufRead *.html set textwidth=999
au BufNewFile,BufRead {Dockerfile} setlocal wrap linebreak nolist textwidth=120 syntax=off
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au FileType text setlocal textwidth=78

" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
" hacks from above (the url, not jesus) to delete fugitive buffers when we
" leave them - otherwise the buffer list gets poluted
" add a mapping on .. to view parent tree
au BufReadPost fugitive://* set bufhidden=delete
au BufReadPost fugitive://*
  \ if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' |
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

" deoplete
if has('nvim')
  let g:deoplete#enable_at_startup = 1 " Run deoplete.nvim automatically
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
  let g:deoplete#sources#go#align_class = 1
  let g:python_host_prog = '/usr/bin/python'
  let g:python3_host_prog = '/usr/bin/python3'
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ deoplete#mappings#manual_complete()
  inoremap <silent><expr> <S-TAB>
        \ pumvisible() ? "\<C-p>" :
        \ <SID>check_back_space() ? "\<S-TAB>" :
        \ deoplete#mappings#manual_complete()
  function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
  endfunction"}}}
endif

" rust.vim
let g:rustfmt_autosave = 1
au FileType rust set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

" buf-explorer
let g:bufExplorerShowRelativePath=1

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
