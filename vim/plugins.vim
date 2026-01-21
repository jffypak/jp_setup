" ========================================
" Vim plugin configuration
" ========================================

call plug#begin('~/.vim/plugged')

" ========== Core Improvements ==========
Plug 'tpope/vim-surround'           " Manipulate quotes, brackets, tags
Plug 'tpope/vim-repeat'             " Repeat plugin commands with .
Plug 'tpope/vim-unimpaired'         " Handy bracket mappings
Plug 'tpope/vim-abolish'            " Smart search/replace/coercion
Plug 'tomtom/tcomment_vim'          " Easy commenting
Plug 'Raimondi/delimitMate'         " Auto-close brackets/quotes
Plug 'editorconfig/editorconfig-vim' " Respect project settings
Plug 'christoomey/vim-tmux-navigator' " Tmux integration (remove if you don't use tmux)

" ========== Navigation & Search ========
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'             " Fuzzy finder
Plug 'preservim/nerdtree'           " File explorer
Plug 'justinmk/vim-sneak'           " Quick motion with s
Plug 'rking/ag.vim'                 " Fast text search (requires ag/silversearcher)

" ========== Git Integration ============
Plug 'tpope/vim-fugitive'           " Git commands
Plug 'airblade/vim-gitgutter'       " Git diff in gutter
Plug 'tpope/vim-git'                " Git syntax
Plug 'ruanyl/vim-gh-line'           " Open GitHub lines

" ========== Language Support ===========
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'} " LSP/Autocomplete
Plug 'sheerun/vim-polyglot'         " Syntax for many languages
Plug 'dense-analysis/ale'           " Linting/fixing

" TypeScript/JavaScript specific
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'peitalin/vim-jsx-typescript'

" ========== AI Assistant ===============
Plug 'github/copilot.vim'           " GitHub Copilot

" ========== Appearance =================
Plug 'itchyny/lightline.vim'        " Status line
Plug 'morhetz/gruvbox'              " Color scheme
Plug 'dracula/vim', {'name':'dracula'} " Alternative color scheme
Plug 'kyazdani42/nvim-web-devicons' " File icons

" ========== Utilities ==================
Plug 'nvim-lua/plenary.nvim'        " Lua utility library

call plug#end()