" Plugins will be downloaded under the specified directory.
call plug#begin('~/.config/nvim/plugs')

" Declare the list of plugins.
Plug 'airblade/vim-gitgutter'
Plug 'dyng/ctrlsf.vim'
Plug 'itchyny/lightline.vim'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/nerdtree'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Define leader key
let mapleader=","

" Open new buffer and close previous
nnoremap <Leader>n <C-w>n<C-w><C-p><C-w>q
" Open new tab via
nnoremap <Leader>t :tabnew<CR>
" Resync syntax highlighting
nnoremap <Leader>R :syntax sync fromstart<CR>
" Highlight non-ascii characters
nnoremap <Leader>E /[^\x00-\x7F]<CR>

" Setup MarkdownPreview plugin
nnoremap <Leader>m :MarkdownPreview<CR>

" Setup fzf plugin
nnoremap <Leader>p :Files<CR>

" Setup Nerdtree plugin
nnoremap <Leader>e :NERDTreeToggle<CR>
let NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
let NERDTreeIgnore=[
	\'\.DS_Store$',
	\'\.git$',
	\'\.ipynb_checkpoints$',
	\'\.mypy_cache$',
	\'__pycache__$',
	\'.*\.egg\-info$',
	\'node_modules$'
	\]

autocmd FileType nerdtree setlocal relativenumber

" Setup CtrlSF plugin
" Map search functions
nmap <Leader>f <Plug>CtrlSFPrompt
vmap <Leader>f <Plug>CtrlSFVwordPath
vmap <Leader>F <Plug>CtrlSFVwordExec
" Set recursive grep program for CtrlSF
let g:ctrlsf_ackprg='rg'

" Set colorscheme
set termguicolors
" colorscheme typewriter-dark
" colorscheme typewriter-light
colorscheme substrata

" Set lightline colorscheme
let g:lightline = {'colorscheme': 'wombat'}

" Setup additional configuration.
" Enable line numbering
set number
" Enable hybrid line numbering via number + relativenumber
set relativenumber
" Set foldmethod
set foldmethod=indent
" Share clipboard with system
set clipboard=unnamedplus
" Enable mouse scrolling. Selection and copy-paste works with 'yank' due to
" shared clipboard. Also Option-Select works for Cmd-C
set mouse=a
" Allow single-line folding
set fml=0

" Tab spacing
" Number of visual spaces per TAB
set tabstop=4
" Number of spaces in tab when editing
set softtabstop=4
" Number of spaces to use for autoindent
set shiftwidth=4
set smarttab
set expandtab

" Shell
" Use login shell by default
set shell=bash\ -l
" Map esc to exit from terminal mode
tnoremap <Esc> <C-\><C-n>

" Macros
" Repeat macro stored in 'q' register via space
noremap <Space> @q

" NOTE: We don't use netrw as the tree view is constantly buggy. In environments
" where we cannot use other plugins for exploring directory structure this serves
" as reference:
"
" Setup netrw configuration
" Default window size
" let g:netrw_winsize=30
" Show directory tree
" let g:netrw_liststyle=3
" Remove useless banner
" let g:netrw_banner=0
" Hide specific files
" let g:netrw_list_hide='^\.DS_Store,^\.git/,.*\.egg\-info,^__[a-z]*__/'

" Open in right split (better to use :Vex, P)
" let g:netrw_altv=1
" Set window command
" let g:netrw_chgwin = winnr()
