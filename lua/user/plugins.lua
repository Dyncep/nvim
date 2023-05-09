local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use({ "nvim-lua/plenary.nvim" }) -- Useful lua functions used by lots of plugins
	use({ "kyazdani42/nvim-web-devicons" })
	use({ "nvim-lualine/lualine.nvim" })
	use({ "lewis6991/impatient.nvim" })
  use({ "windwp/nvim-autopairs" })
  use({ "nvim-treesitter/nvim-treesitter" })
  use({'williamboman/mason.nvim'})
  use({'williamboman/mason-lspconfig.nvim'})


	-- Colorschemes
	use({ "folke/tokyonight.nvim" })

	-- cmp plugins
  -- Completion framework:
  use 'hrsh7th/nvim-cmp' 
  -- LSP completion source:
  use 'hrsh7th/cmp-nvim-lsp'
  -- Useful completion sources:
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-nvim-lsp-signature-help'
  use 'hrsh7th/cmp-vsnip'                             
  use 'hrsh7th/cmp-path'                              
  use 'hrsh7th/cmp-buffer'                            
  use 'hrsh7th/vim-vsnip'

	-- LSP
	use({ "neovim/nvim-lspconfig" }) -- enable LSP
	use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({ "RRethy/vim-illuminate" })

	-- FZF
	use({ "ibhagwan/fzf-lua", requires = { "kyazdani42/nvim-web-devicons" } })

	-- Trouble / diagnostics
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	-- Doc generator
	use({
		"kkoomen/vim-doge",
		run = ":call doge#install()",
	})

	-- Prettier formatter
	use("MunifTanjim/prettier.nvim")

	-- Git
	use({ "lewis6991/gitsigns.nvim" })
	use({ "junegunn/gv.vim" })
	use({ "tpope/vim-fugitive" })

	use({ "L3MON4D3/LuaSnip" }) --snippet engine
	use({ "rafamadriz/friendly-snippets" }) -- a bunch of snippets to use

	use({ "phaazon/hop.nvim" })
  use({"folke/lua-dev.nvim" })

  use({"simrat39/rust-tools.nvim"})

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
