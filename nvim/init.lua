require 'impatient'
local vim = vim
local keymap = vim.keymap.set
local vopt = vim.opt
local g = vim.g

local LSP = {
  "sumneko_lua", "clangd", "gopls", "tsserver", "pyright"
}


local function setup_auto_format(ft, command)
  if not command then
    command = "lua vim.lsp.buf.format()"
  end
  vim.cmd(string.format("autocmd BufWritePost *.%s %s", ft, command))
end

local nnoremap = function(lhs, rhs)
  keymap("n", lhs, rhs, { noremap = true, silent = true })
end

local inoremap = function(lhs, rhs)
  keymap("i", lhs, rhs, { noremap = true, silent = true })
end

g.mapleader = ","
g.loaded = 1
g.loaded_netrwPlugin = 1
g.catppuccin_flavour = "mocha"
-- remove whitespace on save
g.better_whitespace_enabled = 1
g.strip_whitespace_on_save = 1
g.strip_whitespace_confirm = 0
g.coq_settings = {
  auto_start = 'shut-up',
  ["display.ghost_text.enabled"] = false,
  ["display.pum.fast_close"] = false,
}

local opts = {
  termguicolors = true,
  number = true,
  encoding = 'utf-8',
  undofile = true,
  undodir = '/tmp',
  undolevels = 700,
  autoread = true,
  history = 1000,
  so = 7,
  backspace = 'indent,eol,start',
  synmaxcol = 300,
  colorcolumn = "80,120",
  signcolumn = "yes",
  mouse = "a",
  laststatus = 3, -- set global statusline

  -- disable bell
  visualbell = false,
  belloff = "all",

  -- no backup and swap
  backup = false,
  writebackup = false,
  swapfile = false,

  -- search
  hlsearch = true,
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  wrapscan = true,
  showmatch = true,

  -- indent
  autoindent = true,
  smartindent = true,
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  shiftround = true,
  expandtab = true,
  wrap = false,

  -- timeout for toyping etc.
  updatetime = 300,
  timeout = false,
  ttimeout = true,
  ttimeoutlen = 10,
  ttyfast = true,

  --  Shows the effects of a command incrementally, as you type.
  inccommand = "nosplit",

  -- modelines
  modelines = 0,
  modeline = false,

  completeopt = "menu,menuone,noselect"
}

for k, v in pairs(opts) do
  vopt[k] = v
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'lewis6991/impatient.nvim'
  use "nvim-lua/plenary.nvim"
  use 'neovim/nvim-lspconfig'
  use { 'junegunn/fzf', run = './install --bin' }
  use 'junegunn/vim-easy-align'
  use 'ntpeters/vim-better-whitespace'
  use 'jlanzarotta/bufexplorer'

  use 'tpope/vim-surround'
  use 'tpope/vim-endwise'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'

  use 'jiangmiao/auto-pairs'
  use 'preservim/nerdcommenter'
  use 'preservim/nerdtree'

  use 'stevearc/dressing.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'beauwilliams/statusline.lua'
  use { "ms-jpq/coq_nvim", branch = "coq", }
  use { "ms-jpq/coq.artifacts", branch = 'artifacts' }
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_uninstalled = "✗",
            package_pending = "⟳",
          },
        },
      })
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    requires = { 'williamboman/mason.nvim' },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = LSP,
      })
    end
  }
  use 'nvim-telescope/telescope.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', requires = { 'nvim-telescope/telescope.nvim' }, run = 'make' }
  use { 'nvim-telescope/telescope-smart-history.nvim',
    requires = { 'kkharji/sqlite.lua', 'nvim-telescope/telescope.nvim' } }
  use 'nvim-telescope/telescope-live-grep-args.nvim'
  use 'kkharji/sqlite.lua'
  use 'lewis6991/gitsigns.nvim'

  use 'editorconfig/editorconfig-vim'
  use 'sheerun/vim-polyglot'
  use 'simrat39/rust-tools.nvim'
  use 'vim-scripts/YankRing.vim'
  use 'mattn/vim-goimports'

  -- special colorscheme
  use 'base16-project/base16-vim'
  use {
    'rebelot/kanagawa.nvim',
    config = function()
      require('kanagawa').setup()
    end
  }
  use {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        integraions = {
          ["gitsigns"] = true,
          ["cmp"] = true,
          ["telescope"] = true,
          ["symbols_outline"] = true,
          ["lsp_saga"] = true,
        }
      })
    end
  }

  use {
    'simrat39/symbols-outline.nvim',
    config = function()
      require("symbols-outline").setup({
        keymaps = { -- These keymaps can be a string or a table for multiple keys
          close = { "<Esc>", "q" },
          goto_location = "<Cr>",
          focus_location = "o",
          hover_symbol = "<C-space>",
          toggle_preview = "K",
          rename_symbol = "r",
          code_actions = "a",
          fold = "h",
          unfold = "l",
          fold_all = "W",
          unfold_all = "E",
          fold_reset = "R",
        },
      })
    end
  }

  use {
    'glepnir/lspsaga.nvim',
    branch = "main",
    config = function()
      require('lspsaga').init_lsp_saga({
        finder_action_keys = {
          open = "<cr>",
          vsplit = "s",
          split = "i",
          tabe = "t",
          quit = "q",
        },
      })
    end
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.black,
          null_ls.builtins.completion.spell,
        },
      })
    end
  }
end)

vim.cmd [[
" NERDCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

au BufNewFile,BufRead *.sls set filetype=jinja.yaml

" NerdTree
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTREEWinSize=30
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$', '\.o.d$', '\..\.cmd$', '\.egg-info$', '\.ko$', '\.mod.c$', '\.order$', '\.symvers$', '\.ko.cmd$']
let NERDTreeHighlightCursorline=1

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
]]

if vim.env.BASE16_THEME then
  local color = 'base16-' .. vim.env.BASE16_THEME
  if vim.env.BASE16_THEME == "kanagawa" then
    color = "kanagawa"
  elseif vim.env.BASE16_THEME == "catppuccin" then
    color = "catppuccin"
  end
  vim.cmd('colorscheme ' .. color)
else
  vim.cmd 'colorscheme catppuccin'
end

-- Use system clipboard
-- Writes to the unnamed register also writes to the * and + registers. This
-- makes it easy to interact with the system clipboard
vim.cmd [[
if (!has('nvim') || $DISPLAY != '') && has('clipboard')
  if has('unnamedplus')
     set clipboard& clipboard+=unnamedplus
  else
     set clipboard& clipboard+=unnamed
  endif
endif
]]

-- setup fzf
local telescope = require("telescope")


telescope.setup({
  defaults = {
    history = {
      path = '~/.local/share/nvim/telescope_history.sqlite3',
      limit = 100,
    },
    mappings = {
      i = {
        ["<C-Down>"] = require('telescope.actions').cycle_history_next,
        ["<C-Up>"] = require('telescope.actions').cycle_history_prev,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
    },
  }
})

telescope.load_extension("live_grep_args")
telescope.load_extension('fzf')
telescope.load_extension('smart_history')

-- setup LSP
local lspconfig = require("lspconfig")
local coq = require('coq')
local rt = require('rust-tools')

nnoremap('<leader>e', vim.diagnostic.open_float)
nnoremap('[d', vim.diagnostic.goto_prev)
nnoremap(']d', vim.diagnostic.goto_next)
nnoremap('<leader>q', vim.diagnostic.setloclist)

-- lspsaga config
nnoremap('gd', '<cmd>Lspsaga lsp_finder<cr>')
nnoremap('gD', '<cmd>Lspsaga peek_definition<cr>')
nnoremap('K', '<cmd>Lspsaga hover_doc<cr>')
nnoremap('<leader>cd', '<cmd>Lspsaga show_line_diagnostic<cr>')
nnoremap('<leader>rn', '<cmd>Lspsaga rename<CR>')
nnoremap("[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
nnoremap("]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- Only jump to error
nnoremap("[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
nnoremap("]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end)
-- Outline
nnoremap("<leader>o", "<cmd>SymbolsOutline<CR>")
keymap({ "n", "v" }, "<leader>sa", "<cmd>Lspsaga code_action<cr>", { silent = true, noremap = true })


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach_lsp(_, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  keymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  keymap('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  keymap({ 'n', 'v' }, 'fr', vim.lsp.buf.range_formatting, bufopts)
  keymap({ 'n', 'v' }, 'ff', vim.lsp.buf.format, bufopts)
end

for _, lsp in pairs(LSP) do
  local opt = {
    on_attach = on_attach_lsp,
    flags = {
      debounce_text_changes = 150
    }
  }
  if lsp == 'clangd' then
    opt.init_options = {
      clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    }
  elseif lsp == 'sumneko_lua' then
    opt.settings = {
      single_file_support = true,
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file('', true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    }
  end
  lspconfig[lsp].setup(coq.lsp_ensure_capabilities(opt))
end

rt.setup({
  inlay_hints = {
    auto = true,
    only_current_line = true,
  },
  server = {
    on_attach = on_attach_lsp,
  },
})

-- Setup autoformat for file types that we surely want to do so
for _, ft in pairs({
  'go', 'rs',
}) do
  setup_auto_format(ft)
end

-- Keymap
nnoremap("<leader>1", ":set paste!<cr>") -- <Leader>1: Toggle between paste mode
nnoremap("<leader><leader>", "<cmd>Telescope find_files<cr>")
nnoremap("gs", "<cmd>Telescope grep_string<cr>")
nnoremap("<leader>f", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>")

-- arrow key resize
nnoremap("<left>", "<C-w>5>")
nnoremap("<up>", "<C-w>5-")
nnoremap("<down>", "<C-w>5+")
nnoremap("<right>", "<C-w>5<")

-- Disable arrow keys when in insert-mode
inoremap("<up>", "<nop>")
inoremap("<down>", "<nop>")
inoremap("<left>", "<nop>")
inoremap("<right>", "<nop>")

nnoremap("<leader>nt", ":NERDTreeToggle<cr>")
nnoremap("<leader>nf", ":NERDTreeFind<cr>")
nnoremap("<leader>gs", ":Git<cr>")
nnoremap("<leader>gb", ":Git blame<cr>")
nnoremap("<leader>gd", ":Gdiffsplit<cr>")
nnoremap("<leader>dp", ":diffput<cr>")
nnoremap("<leader>dg", ":diffget<cr>")
nnoremap("<leader>q", ":close<cr>")

keymap({ 'n', 'v' }, '<leader>/', "<plug>NERDCommenterToggle<cr>")
keymap({ 'n', 'v' }, 'ga', "<plug>(EasyAlign)")

-- remove highlight when press enter
nnoremap("<cr>", ":noh<cr><cr>")
