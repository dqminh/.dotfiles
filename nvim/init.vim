" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set encoding=utf-8

call plug#begin()
" Plug 'scrooloose/nerdtree'
" Plug 'ntpeters/vim-better-whitespace'
" Plug 'jlanzarotta/bufexplorer'
" Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/YankRing.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/gv.vim'
Plug 'mhinz/vim-grepper'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-rhubarb'

Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary' }

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'branch': '0.1.x' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-live-grep-args.nvim'
Plug 'AckslD/nvim-neoclip.lua'
Plug 'fannheyward/telescope-coc.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-eunuch'

Plug 'airblade/vim-gitgutter'

Plug 'google/vim-maktaba'
Plug 'bazelbuild/vim-bazel'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'saltstack/salt-vim'
Plug 'teal-language/vim-teal'
Plug 'mmarchini/bpftrace.vim'
Plug 'lepture/vim-jinja'
Plug 'rust-lang/rust.vim'

" themes
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'chriskempson/base16-vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'haishanh/night-owl.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
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
set signcolumn=yes             " always so signcolumn
set cmdheight=1                " Commandbar height
set scrolloff=5                " keep 5 lines when scrolling
set laststatus=2               " always display status line
set number                     " Show line number
set numberwidth=5              " Max number is 99999
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

set shortmess+=c   " Abbreviate messages
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

" Set popup menu max height.
set pumheight=20
set iskeyword-=- " do not use - as a word separator

set inccommand=nosplit " Shows the effects of a command incrementally, as you type.

" PLUGINS

lua << EOF
local lga_actions = require("telescope-live-grep-args.actions")
local telescope = require("telescope")

telescope.load_extension("live_grep_args")
telescope.load_extension('fzf')

telescope.setup{
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
    },
  }
}
EOF

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
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTREEWinSize=30
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$', '\.o.d$', '\..\.cmd$', '\.egg-info$', '\.ko$', '\.mod.c$', '\.order$', '\.symvers$', '\.ko.cmd$']
let NERDTreeHighlightCursorline=1

" vim-grepper
let g:grepper = {
    \ 'quickfix': 0,
    \ 'tools': ['rg'],
    \ 'rg': {
    \   'escape': '\^$.*+?()[]{}|',
    \   'grepformat': '%f:%l:%c:%m',
    \   'grepprg': 'rg -H --no-heading --vimgrep --smart-case --hidden'
    \ }}

" yankring
let g:yankring_clipboard_monitor=0 " fix for neovim

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

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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
nnoremap <silent> <leader>q :close<CR>

" Nerdtree
nmap <silent><leader>nt :NERDTreeToggle<CR>
nmap <silent><leader>nf :NERDTreeFind<CR>

" Fugitive
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git status<CR>
nnoremap <leader>gd :Git diff<CR>
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
nmap <leader><leader> <cmd>Telescope find_files<cr>
nmap <leader>f <cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<cr>
nmap gs  <cmd>Telescope grep_string<cr>

"remove highlight when press enter
nnoremap <CR> :noh<CR><CR>

" +/-: Increment number
nnoremap + <c-a>
nnoremap - <c-x>

let g:rustfmt_autosave = 1

"------------------------------------------------------------------------------
" FILETYPES
"------------------------------------------------------------------------------
au BufRead,BufNewFile *.wuffs setf go
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

" dont match single quote for rust
au FileType rust let b:AutoPairs = {'(':')', '[':']', '{':'}','"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}
au BufRead,BufNewFile Cargo.toml setlocal textwidth=999

au FileType c,cpp setlocal nolist

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

"------------------------------------------------------------------------------
" LANG SERVER
"------------------------------------------------------------------------------

augroup coc
  autocmd!

  autocmd filetype c,cpp,rust,python,go nmap <silent> gd <Plug>(coc-definition)
  autocmd filetype c,cpp,rust,python,go nmap <silent> gy <Plug>(coc-type-definition)
  autocmd filetype c,cpp,rust,python,go nmap <silent> gi <Plug>(coc-implementation)
  autocmd filetype c,cpp,rust,python,go nmap <silent> gr <Plug>(coc-references)

  " Use K to show documentation in preview window.
  autocmd filetype c,cpp,rust,python,go nnoremap <silent> K :call <SID>show_documentation()<CR>

  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction

  " Symbol renaming.
  autocmd filetype c,cpp,rust,python,go nmap <leader>rn <Plug>(coc-rename)

  " Formatting selected code.
  autocmd filetype c,cpp,rust,python,go xmap <leader>lf <Plug>(coc-format-selected)
  autocmd filetype c,cpp,rust,python,go nmap <leader>lf <Plug>(coc-format-selected)
  autocmd FileType c,cpp,rust,python,go setl formatexpr=CocAction('formatSelected')

  " Do default action for next item.
  autocmd FileType c,cpp,rust,python,go noremap <silent><nowait> <space>j :<C-u>CocNext<CR>
  " Do default action for previous item.
  autocmd FileType c,cpp,rust,python,go nnoremap <silent><nowait> <space>k :<C-u>CocPrev<CR>
  " Resume latest coc list.
  autocmd FileType c,cpp,rust,python,go nnoremap <silent><nowait> <space>p :<C-u>CocListResume<CR>

  autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')
  autocmd BufWritePre *.cpp :silent call CocActionAsync('format')
augroup end

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
