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

local function setup_auto_format(ft)
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*." .. ft,
    callback = function(args)
      require("conform").format({
        bufnr = args.buf,
        lsp_format = "fallback",
      })
    end,
  })
end

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local function on_attach_lsp(client, bufnr)
  if client.name == 'ruff' then
    -- Disable hover in favor of Pyright
    client.server_capabilities.hoverProvider = false
  end
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  keymap('n', '<leader>ss', "<cmd>Telescope lsp_workspace_symbols<cr>", bufopts)
  keymap("n", "gd", "<cmd>Lspsaga goto_definition<cr>", bufopts)
  keymap("n", "gD", "<cmd>Lspsaga finder<cr>", bufopts)
  keymap("n", "gK", vim.lsp.buf.signature_help, bufopts)
  keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<cr>", bufopts)
  keymap("n", "K", "<cmd>Lspsaga hover_doc<cr>", bufopts)

  keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
  keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", bufopts)
  keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", bufopts)

  keymap({ 'n', 'v' }, 'ff', function()
    require("conform").format({ async = true }, function(err)
      if not err then
        local mode = vim.api.nvim_get_mode().mode
        if vim.startswith(string.lower(mode), "v") then
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
        end
      end
    end)
  end, bufopts)
end

local LSP = {
  "lua_ls", "clangd", "gopls", "ts_ls", "pyright", "ruff"
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
  { "catppuccin/nvim",       lazy = false,             name = "catppuccin" },
  { 'junegunn/fzf',          build = './install --bin' },
  -- "preservim/nerdtree",
  "preservim/nerdcommenter",
  "jlanzarotta/bufexplorer",
  "tpope/vim-repeat",
  'tpope/vim-surround',
  'tpope/vim-fugitive',
  'shumphrey/fugitive-gitlab.vim',
  { 'ntpeters/vim-better-whitespace', lazy = false },
  'sheerun/vim-polyglot',
  {
    "echasnovski/mini.pairs",
    config = function()
      require('mini.pairs').setup()
    end
  },
  'tpope/vim-rhubarb',
  'editorconfig/editorconfig-vim',
  'vim-scripts/YankRing.vim',
  'junegunn/vim-easy-align',
  { 'lewis6991/gitsigns.nvim',        event = { "BufReadPre", "BufNewFile" } },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy
  },
  {'sindrets/diffview.nvim'},
  {
    "hat0uma/csvview.nvim",
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
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
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons',     -- optional
    }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
      },
    },
  },
  "neovim/nvim-lspconfig",
  {
    "mason-org/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
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
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',
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
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          end,
        },
      }
    end,
  },

  -- fuzzy finder
  { 'nvim-telescope/telescope-fzf-native.nvim',     dependencies = { 'nvim-telescope/telescope.nvim' }, build = 'make' },
  { 'nvim-telescope/telescope-live-grep-args.nvim', dependencies = { 'nvim-telescope/telescope.nvim' } },
  {
    "nvim-telescope/telescope.nvim",
    tag = 'v0.2.1',
    lazy = false,
  },

  -- better diagnostics list and others
  {
    "folke/trouble.nvim",
    lazy = false,
    opts = { use_diagnostic_signs = true },
    keys = {
      { "<leader>xx", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Workspace Diagnostics (Trouble)" },
      { "<leader>xL", "<cmd>TroubleToggle loclist<cr>",               desc = "Location List (Trouble)" },
      { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>",              desc = "Quickfix List (Trouble)" },
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

  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end
  },

  {
    'nvim-lualine/lualine.nvim',
    depdendencies = {
      'nvim-tree/nvim-web-devicons',
      'linrongbin16/lsp-progress.nvim',
    },
    config = function()
      require('lualine').setup({
        sections = {
          lualine_a = {'mode'},
          lualine_b = {'branch', 'diff', 'diagnostics'},
          lualine_c = {
            require('lsp-progress').progress
          },
          lualine_x = {'encoding', 'fileformat', 'filetype'},
          lualine_y = {'progress'},
          lualine_z = {'location', { 'filename', path=1 }}
        },
      })
    end
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },
  },
  {
  "nickjvandyke/opencode.nvim",
  version = "*", -- Latest stable release
  dependencies = {
    {
      -- `snacks.nvim` integration is recommended, but optional
      ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- Enhances `ask()`
        picker = { -- Enhances `select()`
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- Your configuration, if any; goto definition on the type or field for details
    }

    vim.o.autoread = true -- Required for `opts.events.reload`

    -- Recommended/example keymaps
    vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencodeø" })
    vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,                          { desc = "Execute opencode actionø" })
    vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

    vim.keymap.set({ "n", "x" }, "go",  function() return require("opencode").operator("@this ") end,        { desc = "Add range to opencode", expr = true })
    vim.keymap.set("n",          "goo", function() return require("opencode").operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "Scroll opencode up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "Scroll opencode down" })

    -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above ø otherwise consider `<leader>oø` (and remove terminal mode from the `toggle` keymap)
    vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
    vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })
  end,
}
})

local telescope = require("telescope")

telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<c-t>"] = require("trouble.sources.telescope").open,
        ["<a-t>"] = require("trouble.sources.telescope").open,
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
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
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
  elseif lsp == "pyright" then
    opt.settings = {
      pyright = {
        -- Using Ruff's import organizer
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          -- Ignore all files for analysis to exclusively use Ruff for linting
          ignore = { '*' },
        },
      },
    }
  end

  vim.lsp.config(lsp, opt)
  vim.lsp.enable(lsp)
end

vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      local function desc(description)
        return { noremap = true, silent = true, buffer = bufnr, desc = description }
      end

      vim.keymap.set('v', 'K', function()
        vim.cmd.RustLsp { 'hover', 'range' }
      end, desc('rust: hover range'))

      vim.keymap.set("n", "<leader>ca", function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
      end, desc('rust: code action'))

      vim.keymap.set('n', 'K', function()
        vim.cmd.RustLsp { 'hover', 'actions' }
      end, desc('rust: hover range'))

      vim.keymap.set('n', '<leader>em', function()
        vim.cmd.RustLsp('expandMacro')
      end, desc('rust: expand macro'))

      vim.keymap.set('n', '<space>re', function()
        vim.cmd.RustLsp('explainError')
      end, desc('[r]ust: [e]xplain error'))
      vim.keymap.set('n', '<space>rd', function()
        vim.cmd.RustLsp('renderDiagnostic')
      end, desc('rust: [r]ender [d]iagnostic'))
      vim.keymap.set('n', '<space>gd', function()
        vim.cmd.RustLsp('relatedDiagnostics')
      end, desc('rust: [g]o to related [d]iagnostics'))

      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      keymap("n", "gd", "<cmd>Lspsaga goto_definition<cr>", bufopts)
      keymap("n", "gD", "<cmd>Lspsaga finder<cr>", bufopts)
      keymap("n", "gK", vim.lsp.buf.signature_help, bufopts)
      keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<cr>", bufopts)
      keymap("n", "<leader>ca", "<cmd>Lspsaga code_action<cr>", bufopts)
      keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>", bufopts)
      keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>", bufopts)
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

vim.cmd.colorscheme("catppuccin")

vim.cmd [[
let g:fugitive_gitlab_domains = ['https://gitlab.cfdata.org']

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

au BufNewFile,BufRead *.sls setlocal filetype=jinja.yaml
au BufNewFile,BufRead *.bt setlocal filetype=bash
au BufRead *.sls if getline(1) =~ '#!py' | setlocal ft=python | endif
au BufNewFile,BufRead *.sh.jinja setlocal filetype=jinja.bash


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
  'go', 'rs', 'vim', 'py',
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

vim.cmd(string.format("autocmd FileType python EnableStripWhitespaceOnSave"))

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

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})
