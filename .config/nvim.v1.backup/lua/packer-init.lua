-----------------------------------------------------------
-- Plugin manager configuration file
-----------------------------------------------------------

-- Plugin manager: packer.nvim
-- url: https://github.com/wbthomason/packer.nvim

-- Automatically install and set up packer.nvim on any machine after cloning dotfiles
local fn = vim.fn
local cmd = vim.cmd
-- local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

-- if fn.empty(fn.glob(install_path)) > 0 then
--   packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
-- end

local packer = require("packer")

-- Packer options like display and autoclean
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
    auto_clean = true,
    compile_on_sync = true,
})

packer.set_handler("config", function(_, plugin, value)
    if type(value) == "string" and fn.filereadable(fn.expand(value)) == 1 then
        plugin.config = "vim.cmd('source " .. value .. "')"
    end
end)

-- Reload packer after saving plugins.lua (this file)
cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer-init.lua source <afile> | PackerCompile
  augroup end
]])

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------

-- Install plugins
return packer.startup(function(use)
    use({ "wbthomason/packer.nvim" }) -- packer can manage itself

    ----------------
    -- Base: Plugins that modify base vim functionality
    ----------------
    use({ "airblade/vim-rooter" }) -- set root directory to project base
    use({ "farmergreg/vim-lastplace" }) -- move to last place when opening file
    use({ "AndrewRadev/splitjoin.vim" }) -- gS and gJ to split single lines t

    -- tpope magic
    use({ "tpope/vim-commentary" }) -- add comments
    use({ "tpope/vim-repeat" }) -- better repeat
    use({ "tpope/vim-surround" }) -- add surrounding tags and stuff
    use({ "tpope/vim-eunuch" }) -- Adds :Rename, :SudoWrite
    use({ "tpope/vim-sleuth" }) -- Indent autodetection with editorconfig support

    use({ "tommcdo/vim-lion" })

    ----------------
    -- Theme & UI: Plugins that modify the look and feel of nvim
    ----------------
    -- Icons for use in plugins and such
    use({ "kyazdani42/nvim-web-devicons" })

    -- Colorscheme: Github
    use({
        "projekt0n/github-nvim-theme",
        config = function()
            require("github-theme").setup({
                theme_style = "dark_default", -- dark / dark_default / light / light_default / dimmed
                sidebars = { "packer", "nvim-tree" },
            })
        end,
    })

    -- Colorscheme: Gruvbox.nvim
    use { "ellisonleao/gruvbox.nvim" }

    -- supposed to add lsp support for themes that dont have it
    use({
        "folke/lsp-colors.nvim",
        after = "github-nvim-theme",
    })

    -- Diagnostics window picker
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section
            })
        end,
    })

    -- Inline diagnostics, dependency on trouble.nvim (i think)
    use({
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        config = function()
            require("lsp_lines").setup()
        end,
    })

    -- status bar plugin: lualine.nvim
    use({
        "hoob3rt/lualine.nvim",
        after = "github-nvim-theme",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "auto", -- or you can assign github_* themes individually.
                    -- ... your lualine config
                },
            })
        end,
    })

    -- dashboard: alpha-nvim
    use({
        "goolord/alpha-nvim",
        requires = { "kyazdani42/nvim-web-devicons" },
        config = function()
            require("alpha").setup(require("alpha.themes.dashboard").config)
        end,
    })

    -- nvim-tree
    use({
        "kyazdani42/nvim-tree.lua",
        after = "github-nvim-theme",
        requires = {
            "kyazdani42/nvim-web-devicons", -- optional, for file icon
        },
        config = function()
            require("plugins.nvim-tree")
        end,
    })

    -- Telescope
    use({
        "nvim-telescope/telescope.nvim",
        after = "github-nvim-theme",
        requires = {
            { "nvim-lua/plenary.nvim" },
            { "kyazdani42/nvim-web-devicons" },
            { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
            { "nvim-telescope/telescope-live-grep-raw.nvim" },
        },
        config = function()
            require("plugins.telescope")
        end,
    })

    -- add todo plugin

    -- floating terminal is the only terminal you need
    use({
        "voldikss/vim-floaterm",
        after = "github-nvim-theme",
        config = function()
            require("plugins.floaterm")
        end,
    })

    -- Git labels
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    })

    -- show buffers in tab GUI at top of editor

    -- bufferline.nvim
    -- use { 'akinsho/bufferline.nvim',
    --     after = "github-nvim-theme",
    --     tag = "v3.*",
    --     requires = 'kyazdani42/nvim-web-devicons',
    --     config = function()
    --         require("plugins.bufferline")
    --     end,

    -- }

    -- nvim-cokeline -> changed to coke line from bufferline.nvim.. It seems simpler and no graphical issues
    use({
        'noib3/nvim-cokeline',
        requires = 'kyazdani42/nvim-web-devicons', -- If you want devicons
        config = function()
            require('plugins.cokeline')
        end
    })


    ----------------
    -- Misc
    ----------------

    -- Github Copilot.. the lua version: https://github.com/zbirenbaum/copilot.lua
    use {
        "zbirenbaum/copilot.lua",
        event = "VimEnter",
        config = function()
            require("copilot").setup()
        end,
    }

    -- Add copilot suggestions to cmp menu as snippets
    use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function()
            require("copilot_cmp").setup()
        end
    }

    -- Treesitter for better highlighting
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        config = function()
            require("plugins.nvim-treesitter")
        end,
    })

    -- nvim-colorizer.lua
    use({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    })

    -- Autopair
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    })

    ----------------
    -- LSP Stuff
    ----------------

    -- LSP-Zero provides full lspconfig, cmp, and lspinstaller set up
    -- https://github.com/VonHeikemen/lsp-zero.nvim
    use({
        "VonHeikemen/lsp-zero.nvim",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" },
            { "williamboman/nvim-lsp-installer" },

            -- Autocompletion
            { "hrsh7th/nvim-cmp" },
            { "hrsh7th/cmp-buffer" },
            { "hrsh7th/cmp-path" },
            { "saadparwaiz1/cmp_luasnip" },
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-nvim-lua" },

            -- Snippets
            { "L3MON4D3/LuaSnip" },
            { "rafamadriz/friendly-snippets" },
        },
        config = function()
            require("plugins.lsp-zero")
        end,
    })

    --null-ls for stuff like prettierd
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function()
            require("plugins.null-ls")
        end,
    })

    --prettier
    use {
        'prettier/vim-prettier',
        run = 'yarn install',
        ft = { 'javascript', 'typescript', 'typescriptreact', 'javascriptreact', 'svelte', 'css', 'scss', 'less', 'json',
            'graphql', 'markdown', 'vue', 'yaml', 'html' },
        -- I dont think this is needed..?
        -- It wasnt working, i added this, it throws an error but it started working. Removed it and it still works
        -- config = function()
        --     require("vim-prettier").setup()
        -- end,
    }

    -----------------------------------------------------------
    -- Final config
    -----------------------------------------------------------
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)
