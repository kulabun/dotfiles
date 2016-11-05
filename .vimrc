set shell=/bin/bash

"--------------------[ Plugins ]--------------------"
set nocompatible 
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'blueshirts/darcula'
Plugin 'tpope/vim-surround'
Plugin 'easymotion/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'gosukiwi/vim-atom-dark'
Plugin 'sheerun/vim-polyglot'

call vundle#end()

"--------------------[ Plugins Configuration ]--------------------"
"
"----------[ CtrlP ]----------"
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard'] "Ignore settings based on .gitignore
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
map <C-R> :CtrlPMRUFiles<CR>

"----------[ EasyMotion ]----------"
let g:EasyMotion_smartcase = 1
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion
map  f <Plug>(easymotion-bd-f)
nmap f <Plug>(easymotion-overwin-f)

"--------------------[ Editor Configuration ]--------------------"
"set rnu 
set nocompatible
set hidden " don't close unsaved buffers
set cursorline " highlights cursor line
set formatoptions=1 "enable softwrap
set linebreak
syntax on
filetype on
filetype plugin on
filetype indent on
filetype plugin indent on
set autoindent
set copyindent
set smartindent
set foldcolumn=3
set showcmd " show command in status line
set showmatch " show matching brackets
set ignorecase " enable case insensitive search
set smartcase
set incsearch " start search while writing
set hlsearch " highlights search
set noswapfile
set nobackup
set nowb
set backspace=indent,eol,start
set shiftwidth=4
set softtabstop=4
set tabstop=4
set encoding=utf-8
set laststatus=2


"--------------------[ View Configuration ]--------------------"
colorscheme atom-dark-256
set t_Co=256
hi foldcolumn ctermbg=bg
hi LineNr ctermbg=bg
hi vertsplit ctermbg=bg ctermfg=bg
hi split ctermbg=bg ctermfg=bg

"--------------------[ Keymaps ]--------------------"
inoremap jj <Esc>
let mapleader="\<Space>"
noremap = mggg=G`gzz
vnoremap < <gv
vnoremap > >gv
noremap <Leader>a ggVG

vnoremap <C-S-y> "*y
nnoremap <C-S-y> V"*y
noremap <C-S-p> "*p
inoremap <C-S-p> <Esc>"*pa

"--------------------[ Commands ]--------------------"
command W w
command WQ wq
command Wq wq
command Q q

