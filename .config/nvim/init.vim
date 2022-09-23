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

" bookmarks and annotations
Plug 'MattesGroeger/vim-bookmarks'

" theme matching with terminal
Plug 'dylanaraps/wal.vim'

" git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" Plug 'git-time-metric/gtm-vim-plugin'

" go integration
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

"
Plug 'tpope/vim-surround'

" statusline 
Plug 'vim-airline/vim-airline'

call plug#end()

" coc extensions
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-css', 'coc-tabnine', 'coc-tsserver', 'coc-yaml', 'coc-go', 'coc-sh', 'coc-rust-analyzer', 'coc-markdownlint', 'coc-cmake', 'coc-cssmodules', 'coc-clangd', 'coc-fzf-preview', 'coc-pyright']

" airline
let g:airline#extensions#coc#enabled = 1

" set shell
set shell=/bin/bash
let $SHELL = "/bin/bash"

" search options
set incsearch
set hlsearch

" tab options
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2

" general UI stuff
colorscheme wal
set number
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" git time metrics
" let g:gtm_plugin_status_enabled = 1
" function! AirlineInit()
"   if exists('*GTMStatusline')
"     call airline#parts#define_function('gtmstatus', 'GTMStatusline')
"     let g:airline_section_b = airline#section#create([g:airline_section_b, ' ', '[', 'gtmstatus', ']'])
"   endif
" endfunction
" autocmd User AirlineAfterInit call AirlineInit()

" personal shortcuts

" map leader to comma
let mapleader = "," 
" clear search highlight
map <Leader>h :noh<CR>

" coc

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

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

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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


xnoremap p pgvy

