"
" vim-plugged
"

" if vim-plugged isn't already set up, set it up
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" plugins
call plug#begin('~/.config/nvim/plugged/')

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" coc doesn't have a graphql plugin
Plug 'jparise/vim-graphql'
" or an hcl plugin
Plug 'hashivim/vim-terraform'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" bookmarks and annotations
Plug 'MattesGroeger/vim-bookmarks'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'git-time-metric/gtm-vim-plugin'

" go integration
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" rust integration
Plug 'simrat39/rust-tools.nvim', { 'for': [ 'rust' ] }

"
Plug 'tpope/vim-surround'

" statusline 
Plug 'nvim-lualine/lualine.nvim'
Plug 'SmiteshP/nvim-navic'

Plug 'kyazdani42/nvim-web-devicons' 
Plug 'norcalli/nvim-colorizer.lua'

" tabline
Plug 'romgrk/barbar.nvim'

" file tree
Plug 'nvim-tree/nvim-tree.lua'

" toggleterm
Plug 'akinsho/toggleterm.nvim', {'tag' : '*'}

" indent
Plug 'lukas-reineke/indent-blankline.nvim'

" theme matching with terminal
" Plug 'dylanaraps/wal.vim'
Plug 'overcache/NeoSolarized'
" Plug 'shaunsingh/moonlight.nvim'
" Plug 'shaunsingh/nord.nvim'

call plug#end()

" coc extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-tabnine', 'coc-tsserver', 'coc-yaml', 'coc-go', 'coc-sh', 'coc-rust-analyzer', 'coc-markdownlint', 'coc-cmake', 'coc-cssmodules', 'coc-clangd', 'coc-fzf-preview', 'coc-pyright']

" set encodings
set encoding=utf-8
set fileencoding=utf-8

"
set mouse=a
set wrap linebreak
set splitbelow splitright
set completeopt=menuone,noselect
set foldmethod=syntax
set title
set noshowmode
set virtualedit=block
set signcolumn=yes

"
set laststatus=3
set winbar=%=%m\ %f

"
autocmd BufEnter * setlocal fo-=c fo-=r fo-=o

" set shell
set shell=/bin/zsh
let $SHELL = "/bin/zsh"

" search options
set incsearch
set hlsearch

" tab options
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2

"
" general UI stuff
"

set cursorline
setglobal termguicolors
" colorscheme moonlight
colorscheme NeoSolarized
" colorscheme nord
set background=dark
set number
set relativenumber

"
" personal shortcuts
"

" clipboard
set clipboard=unnamedplus
xnoremap p pgvy

" jump to start of line
function! JumpToStartOfLine()

   let l:CurCol = col(".")

   if l:CurCol == 1
      normal _
   else
      normal 0
      " call cursor(".", 1)
   endif

endfunction

" jump to end line
function! JumpToEndOfLine()

   let l:CurCol = col(".")
   let l:EndCol = col("$")-1

   if l:CurCol == l:EndCol
      normal g_
   else
      normal $
      " exec 'call cursor(".", '.l:EndCol.')'
   endif

endfunction

nnoremap H :call JumpToStartOfLine()<CR>
nnoremap L :call JumpToEndOfLine()<CR>

" map leader to comma
let mapleader = "," 
" clear search highlight with ",h"
map <Leader>h :noh<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" fzf
nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]p     :<C-u>CocCommand fzf-preview.FromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs    :<C-u>CocCommand fzf-preview.GitStatus<CR>
nnoremap <silent> [fzf-p]ga    :<C-u>CocCommand fzf-preview.GitActions<CR>
nnoremap <silent> [fzf-p]b     :<C-u>CocCommand fzf-preview.Buffers<CR>
nnoremap <silent> [fzf-p]B     :<C-u>CocCommand fzf-preview.AllBuffers<CR>
nnoremap <silent> [fzf-p]o     :<C-u>CocCommand fzf-preview.FromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>CocCommand fzf-preview.Jumps<CR>
nnoremap <silent> [fzf-p]g;    :<C-u>CocCommand fzf-preview.Changes<CR>
nnoremap <silent> [fzf-p]/     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>CocCommand fzf-preview.Lines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr    :<C-u>CocCommand fzf-preview.ProjectGrep<Space>
xnoremap          [fzf-p]gr    "sy:CocCommand   fzf-preview.ProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t     :<C-u>CocCommand fzf-preview.BufferTags<CR>
nnoremap <silent> [fzf-p]q     :<C-u>CocCommand fzf-preview.QuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>CocCommand fzf-preview.LocationList<CR>


"
" Lua config
"
lua require('config')

