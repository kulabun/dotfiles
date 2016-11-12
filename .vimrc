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
Plugin 'mileszs/ack.vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'ervandew/supertab'

call vundle#end()

"--------------------[ Plugins Configuration ]--------------------"
"
"----------[ CtrlP ]----------"
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
map <C-E> :CtrlPMRUFiles<CR>
map <C-R> :CtrlPBufTag<CR>

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](doc|tmp|node_modules|.git|.idea)',
  \ 'file': '\v\.(exe|so|wma|wmv|mkv|mp3|mp4|mpeg|rpm|bz2|gz|deb|ar|cpio|pdf|djvu|jpeg|jpg|png|gif|ico|avi|xz|zip|rar)$',
  \ }


if executable('ag')
  " Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
  set grepprg="ag --nogroup --nocolor --path-to-agignore ~/.agignore"
  " Use ag in CtrlP for listing files. Lightning fast, respects .gitignore
  " and .agignore. Ignores hidden files by default.
  let g:ctrlp_user_command = 'ag -l --nocolor --path-to-agignore ~/.agignore -f %s'
else
  "ctrl+p ignore files in .gitignore
  "let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
endif

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
set autowriteall

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
function! LoadCommands() 
	command W w
	command WQ wq
	command Wq wq
	command Q q
endfunction

if executable('ag')
	let g:ackprg = 'ag --vimgrep --path-to-agignore ~/.agignore'
endif

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

autocmd VimEnter * call LoadCommands()
