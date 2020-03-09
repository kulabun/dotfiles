" ###########################################################
" # VimPlug Installation ( if not installed )
" ###########################################################
if empty(glob("~/.vim/autoload/plug.vim"))
  silent! execute '!curl --create-dirs -fsSLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * silent! PlugInstall
endif



" ###########################################################
" # Plugins ( Make sure you use single quotes )
" ###########################################################
silent! if plug#begin()

  function! BuildComposer(info)
    if a:info.status != 'unchanged' || a:info.force
      if has('nvim')
        !cargo build --release
      else
        !cargo build --release --no-default-features --features json-rpc
      endif
    endif
  endfunction

  "Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  "Plug 'terryma/vim-multiple-cursors'
  Plug 'craigemery/vim-autotag'
  Plug 'easymotion/vim-easymotion'
  Plug 'editorconfig/editorconfig-vim'
  " Plug 'ekalinin/Dockerfile.vim'
  Plug 'elzr/vim-json'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf.vim'
  Plug 'junegunn/vim-easy-align'
  Plug 'mattn/emmet-vim' "Emmet support (HTML, CSS)
  Plug 'mbbill/undotree'
  Plug 'neomake/neomake'
  Plug 'sheerun/vim-polyglot' "Syntax highlight
  Plug 'skywind3000/asyncrun.vim' "Allows to run vim command asynchrounously
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-eunuch'
  Plug 'tpope/vim-fugitive' "Git support
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-vinegar'
  Plug 'tyrannicaltoucan/vim-quantum'
  " Plug 'vim-ruby/vim-ruby'
  " Plug 'w0rp/ale'
  " Plug 'jceb/vim-orgmode'
"  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
"  Plug 'SirVer/ultisnips'
"  Plug 'honza/vim-snippets'

  call plug#end()
endif




" ###########################################################
" # Base Configuration
" ###########################################################
set undofile                " Persistent Undo
set undolevels=1000         " Maximum number of changes that can be undone
set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
set undodir=~/.vim/undo
if empty(glob('~/.vim/undo'))
  call mkdir($HOME . "/.vim/undo", "p", 0700)
endif

set backup
set backupdir=~/.vim/backups
if empty(glob('~/.vim/backups'))
  call mkdir($HOME . "/.vim/backups", "p", 0700)
endif

set directory=~/.vim/swaps
if empty(glob('~/.vim/swaps'))
  call mkdir($HOME . "/.vim/swaps", "p", 0700)
endif

" Set override as default behavior
augroup ParallelEditsOverride
    autocmd!
    autocmd  SwapExists  *  :let v:swapchoice = 'o'
augroup END

"set list listchars=tab:»»,trail:·,nbsp:_,eol:¬
set autochdir                               " Change working dir to one containing current file
set autoindent                              " Copy indent from last line when starting new line
set autoread                                " Set to auto read when a file is changed from the outside
set autowrite                               " Writes on make/shell commands
set backspace=indent,eol,start
set cf                                      " Enable error files & error jumping.
set cmdheight=2 " Better display for messages
set cursorline                              " Highlight current line
set encoding=utf-8
set expandtab                               " Expand tabs to spaces
set fileencodings=utf-8,iso-8859-15,ucs-bom " heuristic
set foldcolumn=0                            " Column to show folds
set foldlevel=1                             " Close all folds by default
set foldmethod=syntax                       " Syntax are used to specify folds
set foldminlines=0                          " Allow folding single lines
set foldnestmax=0                           " Set max fold nesting level
set formatoptions+=1                        " Break before 1-letter words
set formatoptions+=2                        " Use indent from 2nd line of a paragraph
set formatoptions+=c                        " Format comments
set formatoptions+=l                        " Don't break lines that are already long
set formatoptions+=n                        " Recognize numbered lists
set formatoptions+=o                        " Make comment when using o or O from comment line
set formatoptions+=q                        " Format comments with gq
set formatoptions+=r                        " Continue comments by default
set gdefault                                " By default add g flag to search/replace. Add g to toggle
set hidden                                  " When a buffer is brought to foreground, remember undo history and marks
set history=1000                            " Increase history
set hlsearch                                " Highlight searches
set ignorecase
set incsearch                               " Highlight dynamically as pattern is typed
set laststatus=2                            " Always show status line
set lazyredraw                              " Don't redraw when we don't have to
set list listchars=tab:»»,trail:·,nbsp:_
set magic                                   " Enable extended regexes
set mouse=a                                 " Enable mouse in all in all modes
set nocompatible                            " Disable vi back-compatibility
set nodigraph                               " Disable digraphs for uumlauts
set noerrorbells                            " Disable error bells
set nojoinspaces                            " Only insert single space after a '.', '?' and '!' with a join command
set noshowmode                              " Don't show the current mode (airline.vim takes care of us)
set nostartofline                           " Don't reset cursor to start of line when moving around
set nowrap                                  " Do not wrap lines
set number                                  " Show absolute line numbers
set ofu=syntaxcomplete#Complete             " Set omni-completion method
set regexpengine=1                          " Use the old regular expression engine (it's faster for certain language syntaxes)
set relativenumber                          " Show relative line numbers
set report=0                                " Show all changes
set ruler                                   " Show the cursor position
set scrolloff=3                             " Start scrolling three lines before horizontal border of window
set shell=/bin/sh                           " Use /bin/sh for executing shell commands
set shiftround
set shiftwidth=2
set shortmess=atIc                           " Don't show the intro message when starting vim
set showcmd                                 " show the command in the status line
set showtabline=2                           " Always show tab bar
set sidescrolloff=3                         " Start scrolling three columns before vertical border of window
set signcolumn=yes " Always show signcolumns
set smartcase                               " Ignore 'ignorecase' if search patter contains uppercase characters
set smarttab                                " At start of line, <Tab> inserts shiftwidth spaces, <Bs> deletes shiftwidth spaces
set softtabstop=2
set splitbelow                              " New window goes below
set splitright                              " New windows goes right
set suffixes=.bak,~,.swp,.swo,.o,.d,.info,.aux,.log,.dvi,.pdf,.bin,.bbl,.blg,.brf,.cb,.dmg,.exe,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyd,.dll
set switchbuf=""
set tabstop=2
set ttyfast                                 " Send more characters at a given time
set updatetime=300 " Smaller updatetime for CursorHold & CursorHoldI
set virtualedit=block
set visualbell                              " Use visual bell instead of audible bell (annnnnoying)
set wildchar=<TAB>                          " Character for CLI expansion (TAB-completion)
set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.o,*.obj,*.min.js,*.class
set wildignore+=*/bower_components/*,*/node_modules/*
set wildignore+=*/smarty/*,*/vendor/*,*/.git/*,*/.hg/*,*/.svn/*,*/.sass-cache/*,*/log/*,*/tmp/*,*/build/*,*/ckeditor/*,*/doc/*,*/source_maps/*,*/dist/*
set wildignore+=.DS_Store
set wildmenu                                " Hitting TAB in command mode will show possible completions above command line
set wildmode=list:longest                   " Complete only until point of ambiguity
set winminheight=0                          " Allow splits to be reduced to a single line
set wrapscan                                " Searches wrap around end of file

filetype indent plugin on                   " Use filetype based identation settings
syntax on                                   " Enable syntax highlight



" ###########################################################
" # Appearance Configuration
" ###########################################################
let g:quantum_italics=1
let g:quantum_black=1
set guifont=Hack
set background=dark
colorscheme quantum



" ###########################################################
" # Plugin Config: Coc
" ###########################################################"
" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" " Use <c-space> for trigger completion.
" inoremap <silent><expr> <c-space> coc#refresh()

" " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" " Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" " Use `[c` and `]c` for navigate diagnostics
" nmap <silent> [c <Plug>(coc-diagnostic-prev)
" nmap <silent> ]c <Plug>(coc-diagnostic-next)

" " Remap keys for gotos
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" " Use K for show documentation in preview window
" nnoremap <silent> K :call <SID>show_documentation()<CR>

" function! s:show_documentation()
"   if &filetype == 'vim'
"     execute 'h '.expand('<cword>')
"   else
"     call CocAction('doHover')
"   endif
" endfunction

" " Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

" " Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" " Remap for format selected region
" vmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" vmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" " Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" " Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-curr



" ###########################################################
" # Plugin Config: IndentLine
" ###########################################################
let g:indentLine_char = '┆'
let g:indentLine_color_term = 239
let g:indentLine_enabled = 1



" ###########################################################
" # Plugin Config: Ale
" ###########################################################
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\}



" ###########################################################
" # Plugin Config: LightLine
" ###########################################################
let g:lightline = {
      \ 'colorscheme': 'quantum',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified', 'charvaluehex' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'fileformat': 'LightLineFileformat',
      \   'filetype': 'LightLineFiletype',
      \   'fileencoding': 'LightLineFileencoding',
      \   'mode': 'LightLineMode',
      \ },
      \ 'component': {
      \   'charvaluehex': '0x%B'
      \ },
      \ }

function! LightLineFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ' '._ : ''
  endif
  return ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction



" ###########################################################
" # Plugin Config: Easy Motion
" ###########################################################
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case insensitive feature
let g:EasyMotion_use_smartsign_us = 1 " Uppercase match onlyuppercase



" ###########################################################
" # Plugin Config: AutoTag
" ###########################################################
let g:autotagTagsFile="tags" "AutoTag configuration



" ###########################################################
" # Plugin Config: Vim-Go
" ###########################################################
try
  let g:go_fmt_command = "goimports"

  let g:go_addtags_transform = "snakecase"

  let g:go_echo_command_info = 1

  let g:go_highlight_functions = 1
  let g:go_highlight_methods = 1
  let g:go_highlight_structs = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_build_constraints = 1
catch
endtry



" ###########################################################
" # Plugin Config: NeoBuild
" ###########################################################
if (has("nvim"))
  try
    let g:neomake_error_sign   = {'text': '✖', 'texthl': 'NeomakeErrorSign'}
    let g:neomake_warning_sign = {'text': '∆', 'texthl': 'NeomakeWarningSign'}
    let g:neomake_message_sign = {'text': '➤', 'texthl': 'NeomakeMessageSign'}
    let g:neomake_info_sign    = {'text': 'ℹ', 'texthl': 'NeomakeInfoSign'}

    " neomake configuration for Go.
    let g:neomake_go_enabled_makers = [ 'go', 'gometalinter', 'endsentence' ]
    let g:neomake_go_endsentence_maker = { }
    let g:neomake_go_gometalinter_maker = {
      \ 'args': [
      \   '--tests',
      \   '--enable-gc',
      \   '--concurrency=3',
      \   '--fast',
      \   '-D', 'aligncheck',
      \   '-D', 'dupl',
      \   '-D', 'gocyclo',
      \   '-D', 'gotype',
      \   '-E', 'errcheck',
      \   '-E', 'misspell',
      \   '-E', 'staticcheck',
      \   '-E', 'safesql',
      \   '-E', 'unused',
      \   '-E', 'unconvert',
      \   '-E', 'interfacer',
      \   '%:p:h',
      \ ],
      \ 'append_file': 0,
      \ 'errorformat':
      \   '%E%f:%l:%c:%trror: %m,' .
      \   '%W%f:%l:%c:%tarning: %m,' .
      \   '%E%f:%l::%trror: %m,' .
      \   '%W%f:%l::%tarning: %m'
      \ }

    let g:neomake_java_maker = 'javac'

    au FileType sh autocmd BufWritePost * Neomake
    au FileType go autocmd BufWritePost * Neomake
    au FileType java autocmd BufWritePost * Neomake
    au FileType rb autocmd BufWritePost * Neomake
    au FileType py autocmd BufWritePost * Neomake

  catch
  endtry
endif



" ###########################################################
" # QuickFix + Location Buffer Toggle Functions
" ###########################################################
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction



" ###########################################################
" # Key Mappings
" ###########################################################
" let mapleader = " "
" let maplocalleader = ";"
" noremap l l
noremap f i
noremap i k
noremap k j
noremap j h
noremap h 0
noremap ; $
noremap L w
noremap J b
" nnoremap <C-Left> <C-W><C-H>
" nnoremap <C-Down> <C-W><C-J>
" nnoremap <C-Up> <C-W><C-K>
" nnoremap <C-Right> <C-W><C-L>
nnoremap <silent> bp :bj<CR>
nnoremap <silent> bn :bl<CR>
nnoremap <silent> bb :Buffers<CR>
" nnoremap <silent> gl :BLines<CR>
" nnoremap <silent> gL :Lines<CR>
" nnoremap <silent> gss :Rg<CR>
" nnoremap <silent> gst :Tags<CR><CR>
nnoremap <silent> <Leader>hc :Commands<CR>
" nnoremap <silent> <Leader>hm :Mappings<CR>
" nnoremap <silent> <Leader>gca :Commits<CR>
" nnoremap <silent> <Leader>gcb :BCommits<CR>
" nnoremap <silent> <Leader>t :tabnew<CR>
"nnoremap <Leader>qq :q<CR>
"nnoremap <Leader>qw :wq<CR>
" nnoremap <silent> <Leader><Esc> :noh<CR>
nnoremap <silent> <F1> :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> <F2> :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <F3> :silent UndotreeToggle<CR>
vnoremap <silent> <Leader>= :EasyAlign<CR>
vnoremap <silent> / :Commentary<CR>

" Ex-Mode Mappings
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev wQ wq
cnoreabbrev qw wq
cnoreabbrev qW wq
cnoreabbrev qW wq
cnoreabbrev QW wq
cnoreabbrev Qw wq

" Easy Motion
" map <Leader> <Plug>(easymotion-prefix)
" nmap f <Plug>(easymotion-overwin-f)

" map <Leader>k <Plug>(easymotion-j)
" map <Leader>l <Plug>(easymotion-k)

" map <Leader><space> :CreateLocalTags<CR>



" ###########################################################
" # FIX FOR TRUE COLOR FOR DIFFIRENT TERMS
" ###########################################################
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
    set t_ut=
endif

if !has('gui_running')
  set t_Co=256
endif



" ###########################################################
" # CTAGS Configuration
" ###########################################################
function! CreateGlobalGoTags()
  :AsyncRun! fd ".*\.go" "$SOURCES_ROOT"/go | xargs ctags -a -f "$CTAGS_ROOT"/go.tags 2> /dev/null && notify-send "Go global ctags updated"
endfunction

function! CreateGlobalJavaTags()
  :AsyncRun! fd ".*\.java" "$SOURCES_ROOT"/java | egrep "^$SOURCES_ROOT/java/(([^j]|j[^d]|jd[^k])|jdk/src/(java|jdk))" | grep -v "internal" | xargs ctags -a -f "$CTAGS_ROOT"/java.tags 2> /dev/null && notify-send "Java global ctags updated"
endfunction

function! CreateGlobalRubyTags()
  :AsyncRun! fd ".*\.rb" "$SOURCES_ROOT"/ruby | xargs ctags -a -f "$CTAGS_ROOT"/ruby.tags 2> /dev/null && notify-send "Ruby global ctags updated"
endfunction

function! CreateGlobalPythonTags()
  :AsyncRun! fd ".*\.py" "$SOURCES_ROOT"/python | xargs ctags -a -f "$CTAGS_ROOT"/python.tags 2> /dev/null && notify-send "Python global ctags updated"
endfunction

function! CreateLocalGoTags()
  :AsyncRun! fd ".*\.go" $(git rev-parse --show-toplevel || echo ".") | xargs ctags -a -f $(git rev-parse --show-toplevel || echo ".")/tags 2> /dev/null
endfunction

function! CreateLocalJavaTags()
  :AsyncRun! fd ".*\.java" $(git rev-parse --show-toplevel || echo ".") | xargs ctags -a -f $(git rev-parse --show-toplevel || echo ".")/tags 2> /dev/null
endfunction

function! CreateLocalRubyTags()
  :AsyncRun! fd ".*\.rb" $(git rev-parse --show-toplevel || echo ".") | xargs ctags -a -f $(git rev-parse --show-toplevel || echo ".")/tags 2> /dev/null
endfunction

function! CreateLocalPythonTags()
  :AsyncRun! fd ".*\.py" $(git rev-parse --show-toplevel || echo ".") | xargs ctags -a -f $(git rev-parse --show-toplevel || echo ".")/tags 2> /dev/null
endfunction

autocmd FileType go setlocal tags=./tags;/,tags;/,/$CTAGS_ROOT/go.tags
autocmd FileType java setlocal tags=./tags;/,tags;/,/$CTAGS_ROOT/java.tags
autocmd FileType ruby setlocal tags=./tags;/,tags;/,/$CTAGS_ROOT/ruby.tags
autocmd FileType python setlocal tags=./tags;/,tags;/,/$CTAGS_ROOT/python.tags

autocmd FileType go command! CreateGlobalTags call CreateGlobalGoTags()
autocmd FileType java command! CreateGlobalTags call CreateGlobalJavaTags()
autocmd FileType ruby command! CreateGlobalTags call CreateGlobalRubyTags()
autocmd FileType python command! CreateGlobalTags call CreateGlobalPythonTags()

autocmd FileType go command! CreateLocalTags call CreateLocalGoTags()
autocmd FileType java command! CreateLocalTags call CreateLocalJavaTags()
autocmd FileType ruby command! CreateLocalTags call CreateLocalRubyTags()
autocmd FileType python command! CreateLocalTags call CreateLocalPythonTags()



" ###########################################################
" # Custom FileType Configuration
" ###########################################################
"au FileType vimrc set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab

au BufWritePost *.go Neomake go

au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif " Jump to the last position when reopening a file
au BufEnter * silent! lcd %:p:h "Change PWD on new buffer open/switch

" Custom fileformat comment toggle
"au FileType apache setlocal commentstring=#\ %s

"set number relativenumber
"au BufEnter,FocusGained,InsertLeave * set relativenumber
"au BufLeave,FocusLost,InsertEnter   * set norelativenumber



" ###########################################################
" # Load .vimrc.local if provided
" ###########################################################
if filereadable($HOME . "/.vimrc.local")
  source ~/.vimrc.local
endif
