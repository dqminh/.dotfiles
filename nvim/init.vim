" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set encoding=utf-8

call plug#begin()
Plug 'scrooloose/nerdtree'
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
Plug 'Shougo/echodoc.vim'
Plug 'majutsushi/tagbar'
Plug 'mhinz/vim-grepper'
Plug 'jiangmiao/auto-pairs'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-eunuch'

Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-sayonara'

Plug 'fatih/vim-go'
Plug 'lepture/vim-jinja'
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'moorereason/vim-markdownfmt', {'for': 'markdown'}
Plug 'robbles/logstash.vim'
Plug 'saltstack/salt-vim'
Plug 'b4b4r07/vim-hcl'

Plug 'vim-utils/vim-cscope'
Plug 'vim-scripts/a.vim'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" themes
Plug 'vim-airline/vim-airline'
Plug 'chriskempson/base16-vim'
call plug#end()

filetype plugin indent on
syntax on
set secure
set mouse=a

" Use system clipboard
" Writes to the unnamed register also writes to the * and + registers. This
" makes it easy to interact with the system clipboard
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
     set clipboard& clipboard+=unnamedplus
  else
     set clipboard& clipboard+=unnamed
  endif
endif

" Theme
set termguicolors
" for true color inside tmux
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" How i want my editor to present content
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set number                     " Show line number
set encoding=utf-8             " Enable utf-8 encoding by default
set undofile                   " Enable undofile
set undodir=/tmp               " Set the undo destination to tmp
set undolevels=700             " Set how many undo vim has to remember
set autoread                   " Set autoread when a file is changed from outside
set history=1000               " Sets how many lines of history vim has to remember
set so=7                       " Set 7 lines to the cursor when moving vertical
set textwidth=88               " Default maximum textwidth is 88
set synmaxcol=300              " not slow when highlight long line
set colorcolumn=80,120         " Highlight column 80 and 120 to remind us that we should open a new line
set pumblend=20                " pseudo-transparency of popup-menu
set winblend=20                " pseudo-transparency for floating-window
set signcolumn=yes             " always so signcolumn
set cmdheight=1                " Commandbar height
set scrolloff=5                " keep 5 lines when scrolling
set laststatus=2               " always display status line
set number                     " Show line number
set numberwidth=5              " Max number is 99999
set title                      " always set terminal title
set titlelen=95
let &g:titlestring="
      \ %{expand('%:p:~:.')}%(%m%r%w%)
      \ %<\(%{fnamemodify(getcwd(), ':~')}\) - VIM"
set showtabline=0
if has('cmdline_info')
  set ruler
  set showcmd
endif
set list listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:· " Display extra whitespace

" Windows and buffer
set hidden            " Change buffer without saving
set switchbuf=useopen " Use opened buffer instead of creating new one
set splitright " set direction of split
set winwidth=30
set winheight=1
set noequalalways
set previewheight=8
set helpheight=12
if exists('+previewpopup')
  set previewpopup=height:10,width:60
endif
au VimResized * :wincmd = " Resize splits when the window is resized

" Disable bell.
set t_vb=
set novisualbell
set belloff=all

set shortmess=atIcF   " Abbreviate messages
set noshowmode " Do not display the completion messages
set fo=tcrqo " t autowraps text using textwidth
             " c autowraps comments using textwidth
             " r autoinserts the current comment leader
             " q allows formatting of comments
             " o auto insert comment leader when press o or O

set wildmenu
set wildmode=full
set wildoptions+=pum
set showfulltag

" No backup
set nobackup   " Disable backup file
set nowritebackup
set noswapfile " Disable swap file
set backupdir-=.

" Search
set hlsearch   " Highlight search
set incsearch  " incremental searching
set ignorecase " ignore case when searching
set smartcase
set wrapscan   " Search wraps at EOF
set gdefault
set showmatch

" Disable modelines
set modelines=0
set nomodeline

" Folding
set foldlevelstart=99
set foldmethod=manual

" Indent
set autoindent smartindent
set tabstop=2
set softtabstop=2
set shiftround
set shiftwidth=2
set expandtab
set nowrap

" Update and key timeout
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10
set ttyfast

" shada instead of viminfo
set shada=!,'300,<50,s10,h

" Completion setting.
set completeopt=menuone
if exists('+completepopup')
  set completeopt+=popup
  set completepopup=height:4,width:60,highlight:InfoPopup
endif
" Don't complete from other buffer.
set complete=.
" Set popup menu max height.
set pumheight=20
set iskeyword-=- " do not use - as a word separator

set inccommand=nosplit " Shows the effects of a command incrementally, as you type.

" PLUGINS

let g:deoplete#enable_at_startup = 1
let g:python_host_prog  = '/usr/bin/python2'
let g:python3_host_prog = '/usr/bin/python3'

" Remove whitespace on save
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" NerdTree
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTREEWinSize=30
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$', '\.o.d$', '\..\.cmd$', '\.egg-info$', '\.ko$', '\.mod.c$', '\.order$', '\.symvers$', '\.ko.cmd$']
let NERDTreeHighlightCursorline=1
let NERDTreeDirArrowExpandable = ""
let NERDTreeDirArrowCollapsible = ""

" vim-grepper
let g:grepper = {
    \ 'quickfix': 0,
    \ 'tools': ['rg'],
    \ 'rg': {
    \   'escape': '\^$.*+?()[]{}|',
    \   'grepformat': '%f:%l:%c:%m',
    \   'grepprg': 'rg -H --no-heading --vimgrep --smart-case --hidden'
    \ }}

" vim-go
let g:go_def_mode= "gopls"
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1

" Language server
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'python': ['/home/dqminh/.local/bin/pyls', '--log-file', '/tmp/pyls.log', '-v'],
    \ 'go': ['/home/dqminh/bin/gopls'],
    \ 'c': ['/usr/local/bin/ccls'],
    \ 'cpp': ['/usr/local/bin/ccls'],
    \ }
" To use the language server with Vim's formatting operator |gq|
set formatexpr=LanguageClient#textDocument_rangeFormatting()

" JSON
let g:vim_json_syntax_conceal = 0

" Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_new_list_item_indent = 2

" yankring
let g:yankring_clipboard_monitor=0 " fix for neovim

" buf-explorer
let g:bufExplorerShowRelativePath=1

" deoplete
call deoplete#custom#option({
      \ 'auto_refresh_delay': 10,
      \ 'camel_case': v:true,
      \ 'skip_multibyte': v:true,
      \ 'prev_completion_mode': 'length',
      \ 'auto_preview': v:true,
      \ })



"------------------------------------------------------------------------------
" KEYMAPS
"------------------------------------------------------------------------------
let mapleader = ","

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" <Leader>1: Toggle between paste mode
nnoremap <silent> <Leader>1 :set paste!<cr>

" Press Shift+P while in visual mode to replace the selection without
" overwriting the default register
vmap P p :call setreg('"', getreg('0')) <CR>

" <TAB>: completion.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ deoplete#manual_complete()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<C-h>"

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

" NERDCommenter
map <leader>/ <plug>NERDCommenterToggle<CR>
nmap <silent><leader>nt :NERDTreeToggle<CR>
nmap <silent><leader>nf :NERDTreeFind<CR>

" fzf
nmap <leader><leader> :Files<CR>
" for example gsW, gsiw to search
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)
nmap <leader>f :Grepper -tool rg -jump<cr>

"remove highlight when press enter
nnoremap <CR> :noh<CR><CR>

" +/-: Increment number
nnoremap + <c-a>
nnoremap - <c-x>

" Language Server
nnoremap <leader>ld :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lf :call LanguageClient#textDocument_formatting_sync()<CR>
nnoremap <leader>lt :call LanguageClient#textDocument_typeDefinition()<CR>
nnoremap <leader>lx :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>la :call LanguageClient_workspace_applyEdit()<CR>
nnoremap <leader>lh :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>ls :call LanguageClient_textDocument_documentSymbol()<CR>
nnoremap <leader>lm :call LanguageClient_contextMenu()<CR>

" tag bar
nmap <F8> :TagbarToggle<CR>

"------------------------------------------------------------------------------
" FILETYPES
"------------------------------------------------------------------------------
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
au BufNewFile,BufRead *.c set noexpandtab tabstop=4 shiftwidth=4
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

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
