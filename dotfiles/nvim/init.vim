
" In init.vim (Vimscript)
let mapleader = " "  " Space as Leader key

call plug#begin()


" List your plugins here
Plug 'neovim/nvim-lspconfig'
Plug 'tribela/vim-transparent'
Plug 'ThePrimeagen/vim-be-good'
Plug 'tpope/vim-sensible'
Plug 'ajmwagar/vim-deus'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
Plug 'EdenEast/nightfox.nvim'
call plug#end()

set number          " Show absolute line numbers

" Optional: Additional settings can be added below
" Example: Enable line wrapping
set nowrap  " Disable line wrapping

" Optional: Set default tab width and indentation
set tabstop=4      " Set tab width to 4 spaces
set expandtab      " Use spaces instead of tabs

" Set transparency for Neovim background
if has('gui_running')  " This checks if GUI is running (like Neovim's GUI client)
  hi Normal guibg=NONE ctermbg=NONE
  hi SignColumn guibg=NONE ctermbg=NONE
  hi VertSplit guibg=NONE ctermbg=NONE
else
  hi Normal ctermbg=NONE
  hi SignColumn ctermbg=NONE
  hi VertSplit ctermbg=NONE
endif

" Set up LSP for Rust Analyzer
lua << EOF
  local nvim_lsp = require('lspconfig')

  -- Rust Analyzer
  nvim_lsp.rust_analyzer.setup({
    settings = {
      ["rust-analyzer"] = {
        assist = { importGranularity = "module", importPrefix = "by_self" },
        cargo = { loadOutDirsFromCheck = true },
        procMacro = { enable = true }
      }
    }
  })
EOF

" Set up LSP for Clangd
lua << EOF
  local nvim_lsp = require('lspconfig')

  -- Clangd
  nvim_lsp.clangd.setup({
    cmd = { "clangd", "--background-index", "--clang-tidy", "--completion-style=detailed" }
  })
EOF

" Map <Leader>ff to search files with Telescope
nnoremap <Leader>ff :Telescope find_files<CR>

" Map <Leader>fg to search for text in the current directory with Telescope
nnoremap <Leader>fg :Telescope live_grep<CR>

" Map <Leader>fb to search buffers with Telescope
nnoremap <Leader>fb :Telescope buffers<CR>

" Map <Leader>fh to search help tags with Telescope
nnoremap <Leader>fh :Telescope help_tags<CR>

" Map <Leader>fk to search keymaps with Telescope
nnoremap <Leader>fk :Telescope keymaps<CR>

colorscheme nightfox


