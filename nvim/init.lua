local vim = vim
local keymap = vim.keymap.set

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

local nnoremap = function(lhs, rhs)
  vim.keymap.set("n", lhs, rhs, { noremap = true, silent = true })
end

local inoremap = function(lhs, rhs)
  vim.keymap.set("i", lhs, rhs, { noremap = true, silent = true })
end

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

local function setup_auto_format(ft, command)
  if not command then
    command = "lua vim.lsp.buf.format()"
  end
  vim.cmd(string.format("autocmd BufWritePost *.%s %s", ft, command))
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach_lsp(_, bufnr)
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap('n', '<leader>ss', "<cmd>Telescope lsp_workspace_symbols<cr>", bufopts)
  keymap("n", "gd", "<cmd>Lspsaga goto_definition<cr>", bufopts)
  keymap("n", "gD", "<cmd>Lspsaga lsp_finder<cr>", bufopts)
  keymap("n", "gK", vim.lsp.buf.signature_help, bufopts)
  keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<cr>", bufopts)
  keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", bufopts)

  keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
  keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", bufopts)
  keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", bufopts)

  keymap({ 'n', 'v' }, 'ff', vim.lsp.buf.format, bufopts)
end

local LSP = {
  "lua_ls", "clangd", "gopls", "tsserver", "pyright"
}

local global_opts = {
  mapleader = ",",
  maplocalleader = ",",
  catppuccin_flavour = "mocha",
  -- remove whitespace on save
  better_whitespace_enabled = 1,
  strip_whitespace_on_save = 1,
  strip_whitespace_confirm = 0,
}

for k, v in pairs(global_opts) do
  vim.g[k] = v
end

local opts = {
  termguicolors = true,
  clipboard = "unnamedplus",
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
  vim.opt[k] = v
end

-- Load lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "nvim-lua/plenary.nvim", lazy = false },
  "stevearc/dressing.nvim",
  { "catppuccin/nvim", lazy = false, name = "catppuccin" },

  { 'junegunn/fzf', build = './install --bin' },
  "preservim/nerdtree",
  "preservim/nerdcommenter",
  "jlanzarotta/bufexplorer",
  "tpope/vim-repeat",
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'ntpeters/vim-better-whitespace',
  'sheerun/vim-polyglot',
  {
    "echasnovski/mini.pairs",
    config = function()
      require('mini.pairs').setup()
    end
  },
  'editorconfig/editorconfig-vim',
  'vim-scripts/YankRing.vim',
  'junegunn/vim-easy-align',

  { 'lewis6991/gitsigns.nvim', event = { "BufReadPre", "BufNewFile" } },
  'simrat39/rust-tools.nvim',

  {
    'neovim/nvim-lspconfig',
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      'williamboman/mason.nvim',
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
  },
  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = function()
      require("lspsaga").setup({
        finder_action_keys = {
          open = "<cr>",
          vsplit = "s",
          split = "i",
          tabe = "t",
          quit = "q",
        },
      })
    end,
    dependencies = {
      'neovim/nvim-lspconfig',
      "nvim-tree/nvim-web-devicons",
      --Please make sure you install markdown and markdown_inline parser
      "nvim-treesitter/nvim-treesitter",
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Decrement selection", mode = "x" },
    },
    opts = {
      highlight = { enable = true },
      indent = { enable = true, disable = { "python" } },
      context_commentstring = { enable = true, enable_autocmd = false },
      ensure_installed = { "bash", "c", "rust", "lua", "python", "vim", "yaml", "go", "markdown", "markdown_inline"},
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },
    config = function(_, o)
      require("nvim-treesitter.configs").setup(o)
    end,
  },

  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim" },
    opts = function()
      local null_ls = require("null-ls")
      return {
        sources = {
          null_ls.builtins.formatting.usort,
          null_ls.builtins.formatting.black,
        },
      }
    end,
  },
  {
    'williamboman/mason.nvim', lazy = false,
    config = function()
      require("mason").setup()
    end
  },
  {
    'williamboman/mason-lspconfig.nvim', lazy = false,
    config = function()
      require("mason-lspconfig").setup()
    end
  },

  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    opts = function()
      local cmp = require("cmp")
      return {
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        }),
        experimental = {
          ghost_text = {
            hl_group = "LspCodeLens",
          },
        },
      }
    end,
  },

  -- fuzzy finder
  { 'nvim-telescope/telescope-fzf-native.nvim', dependencies = { 'nvim-telescope/telescope.nvim' }, build = 'make' },
  { 'nvim-telescope/telescope-live-grep-args.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } },
  {
    "nvim-telescope/telescope.nvim",
    version = false, -- telescope did only one release, so use HEAD for now
    lazy = false,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    lazy = false,
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", desc = "Quickfix List (Trouble)" },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            vim.cmd.cprev()
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            vim.cmd.cnext()
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
})

local telescope = require("telescope")
local lspconfig = require("lspconfig")
local rt = require('rust-tools')

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = require("trouble.providers.telescope").open_with_trouble,
        ["<a-t>"] = require("trouble.providers.telescope").open_selected_with_trouble,
        ["<C-Down>"] = require("telescope.actions").cycle_history_next,
        ["<C-Up>"] = require("telescope.actions").cycle_history_prev,
        ["<C-f>"] = require("telescope.actions").preview_scrolling_down,
        ["<C-b>"] = require("telescope.actions").preview_scrolling_up,
      },
      n = {
        ["q"] = require("telescope.actions").close,
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

-- diagnostic
vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4 },
  severity_sort = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

for _, lsp in pairs(LSP) do
  local opt = {
    on_attach = on_attach_lsp,
    capabilities = capabilities,
  }
  if lsp == 'clangd' then
    opt.init_options = {
      clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = false,
    }
  elseif lsp == 'lua_ls' then
    opt.settings = {
      single_file_support = true,
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        }
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

  lspconfig[lsp].setup(opt)
end

rt.setup({
  inlay_hints = {
    auto = true,
    only_current_line = true,
  },
  server = {
    on_attach = on_attach_lsp,
    settings = {
      ['rust-analyzer'] = {
        diagnostics = {
          disabled = { "inactive-code" },
        },
        rustfmt = {
          extraArgs = { "+nightly", },
        },
      },
    },
  },
})


vim.cmd.colorscheme("catppuccin")

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

" NerdTree
let g:NERDTreeAutoDeleteBuffer = 1
let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTREEWinSize=30
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '\.o$', '\.o.d$', '\..\.cmd$', '\.egg-info$', '\.ko$', '\.mod.c$', '\.order$', '\.symvers$', '\.ko.cmd$']
let NERDTreeHighlightCursorline=1

au BufNewFile,BufRead *.sls set filetype=jinja.yaml

" http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
" hacks from above (the url, not jesus) to delete fugitive buffers when we
" leave them - otherwise the buffer list gets poluted
" add a mapping on .. to view parent tree
au BufReadPost fugitive://* set bufhidden=delete
au BufReadPost fugitive://*
  \ if get(b:, 'fugitive_type', '') =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif
]]

-- Setup autoformat for file types that we surely want to do so
for _, ft in pairs({
  'go', 'rs', 'vim',
}) do
  setup_auto_format(ft)
end

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

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

nnoremap('<leader>e', vim.diagnostic.open_float)
nnoremap('[d', vim.diagnostic.goto_prev)
nnoremap(']d', vim.diagnostic.goto_next)
nnoremap('<leader>q', vim.diagnostic.setloclist)

nnoremap("<leader>nt", ":NERDTreeToggle<cr>")
nnoremap("<leader>nf", ":NERDTreeFind<cr>")
nnoremap("<leader>gs", ":Git<cr>")
nnoremap("<leader>gb", ":Git blame<cr>")
nnoremap("<leader>gd", ":Gdiffsplit<cr>")
nnoremap("<leader>dp", ":diffput<cr>")
nnoremap("<leader>dg", ":diffget<cr>")
nnoremap("<leader>q", ":close<cr>")

vim.keymap.set({ 'n', 'v' }, '<leader>/', "<plug>NERDCommenterToggle<cr>")
vim.keymap.set({ 'n', 'v' }, 'ga', "<plug>(EasyAlign)")

-- remove highlight when press enter
nnoremap("<cr>", ":noh<cr><cr>")

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- disable semantic tokens to highlight everything
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});
