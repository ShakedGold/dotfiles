return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("sbdchd/neoformat")

     -- All the things
    use("neovim/nvim-lspconfig")
    use("BurntSushi/ripgrep")
    use("kyazdani42/nvim-web-devicons")
    use("hrsh7th/vim-vsnip")
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
        'kyazdani42/nvim-web-devicons', -- optional, for file icons
    },
    }
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'}
    }
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
 	use {'tzachar/cmp-tabnine', run='./install.sh', requires = 'hrsh7th/nvim-cmp'}
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("sharkdp/fd")
    use {
      'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
    "williamboman/nvim-lsp-installer",
}
    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")
end)
