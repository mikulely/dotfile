" ------------------------------------------------------------------------------
" Environment {
set nocompatible           " Use Vim defaults
set shortmess=atI          " no ads when startup
set iskeyword+=_,$,@,%,#,- " 带有如下符号的单词不要被换行分割
set mouse=                 " disable the mouse,不然goldendict不能在终端取词
set mousehide              " Hide the mouse cursor while typing
set cm=blowfish            " Use strong encryption
"Forked form http://www.vi-improved.org/vimrc.html
set cpoptions=aABceFsmq
"             |||||||||
"             ||||||||+-- When joining lines, leave the cursor between joined lines
"             |||||||+-- When a new match is created (showmatch) pause for .5
"             ||||||+-- Set buffer options when entering the buffer
"             |||||+-- :write command updates current file name automatically add <CR> to the last line when using :@r
"             |||+-- Searching continues at the end of the match at the cursor position
"             ||+-- A backslash has no special meaning in mappings
"             |+-- :write updates alternative file name
"             +-- :read updates alternative file name
let g:skip_loading_mswin=1 " Just in case :)
set formatoptions+=n " Recognize numbered lists
set formatlistpat=^\\s*\\(\\d\\\|[-*]\\)\\+[\\]:.)}\\t\ ]\\s* "and bullets, too
" ------------------------------------------------------------------------------
" Format {
set fileformats=unix,dos,mac " Auto detect the file formats
set viewoptions+=slash,unix  " Better Unix/Windows compatibility
set nrformats=               " make <C-a> and <C-x> play well with
                             " zero-padded numbers (i.e. don't consider
                             " them octal or hex)
"forked from http://adam8157.info/blog/2011/02/vim-and-bom/
"Unicode 的 BOM(Byte order mark), 用来标记 UTF-16 和 UTF-32 编码文件的字节序,
"UTF-8 并不需要.在Win下编辑过的文本可能会自动加上BOM，Vim在识别到文件有BOM时，
"就会自动打开bomb选项
if has("multi_byte")
    set nobomb
endif
" Encoding
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    "fileencodings是Vim在启动时将根据fileencodings提供的值探测要打开文件的值
    "并将其设置为fileencoding
    set fileencodings=ucs-bom,utf-8,latin1,gb2312,gbk,gb18030i,big5
"fileencoding是Vim当前编辑文件的编码方式
endif
set encoding=utf-8 "encoding是Vim内部使用的文件编码，菜单啊，消息的编码
scriptencoding utf-8
" }
"------------------------------------------------------------------------------
" Vundle {
filetype off " Required!
let g:vundle_default_git_proto='git'
set runtimepath+=~/.vim/bundle/vundle
call vundle#rc()
" Let Vundle manage Vundle
Bundle 'gmarik/vundle'
"------------------------------------------------------------------------------
" Plugins List
" UI Additions
Bundle 'Lokaltog/vim-powerline'
Bundle 'mutewinter/vim-indent-guides'
Bundle 'roman/golden-ratio'
Bundle 'vim-scripts/ZoomWin'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'vim-scripts/Taglist'
" Colorscheme
Bundle 'Lokaltog/vim-distinguished'
Bundle 'tomasr/molokai'
Bundle 'altercation/vim-colors-solarized'
Bundle 'flazz/vim-colorschemes'
" Navigation
Bundle 'Lokaltog/vim-easymotion'
Bundle 'AndrewRadev/simple_bookmarks.vim'
Bundle 'sjl/gundo.vim'
if executable('ctags')
   Bundle 'majutsushi/tagbar'
endif
Bundle 'scrooloose/nerdtree'
if executable('git')
    Bundle 'tpope/vim-fugitive'
    Bundle 'luxflux/vim-git-inline-diff'
endif
if executable('ag')
        Bundle 'rking/ag.vim'
endif
" Commands
Bundle 'mattn/calendar-vim'
Bundle 'tpope/vim-endwise'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-abolish'
Bundle 'godlygeek/tabular'
Bundle 'tpope/vim-eunuch'
Bundle 'xuhdev/SingleCompile'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/DeleteTrailingWhitespace'
Bundle 'Peeja/vim-cdo'
Bundle 'vim-scripts/VisIncr'
" Automatic Helper
Bundle 'Valloric/YouCompleteMe'
Bundle 'Raimondi/delimitMate'
Bundle 'tpope/vim-speeddating'
Bundle 'DataWraith/auto_mkdir'
Bundle 'mbbill/fencview'
Bundle 'oblitum/bufkill'
Bundle 'scrooloose/syntastic'
" Language related
Bundle 'vim-scripts/TxtBrowser'
Bundle 'nvie/vim-flake8'
Bundle 'vim-scripts/pep8'
Bundle 'python.vim--Vasiliev'
" Bundle 'vim-scripts/Pydiction'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'tpope/vim-rails'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rake'
Bundle "pangloss/vim-javascript"
" matchit is required by rubyblock
Bundle 'Spaceghost/vim-matchit'
Bundle 'kana/vim-textobj-user'
Bundle 'nelstrom/vim-textobj-rubyblock'
" Syntax highlight
Bundle 'oblitum/cSyntaxAfter'
Bundle 'vim-scripts/moin.vim'
Bundle 'groenewege/vim-less'
Bundle 'asciidoc.vim'
Bundle 'confluencewiki.vim'
Bundle 'html5.vim'
Bundle 'mutewinter/nginx.vim'
Bundle 'Markdown'
Bundle 'vim-scripts/JSON.vim'
"Never use this  Bundle 'mutewinter/vim-markdown'
" Others
" if executable('ctags')
    " Bundle 'xolox/vim-easytags'
" endif
Bundle 'tpope/vim-repeat'
Bundle 'vim-scripts/UltiSnips'
"Finder
Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/FuzzyFinder'
Bundle 'panozzaj/vim-autocorrect'
filetype plugin indent on " Required!
" }
"------------------------------------------------------------------------------
" Brief help for Vundle
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"------------------------------------------------------------------------------
" Miscellanous {
set modelines=0            " to prevent security exploits
set ttyfast                " Better terminal display
set lazyredraw             " to avoid scrolling problems"
" Auto change dir
if exists('+autochdir')
	set autochdir          " automatically change to the edited file directory
endif
set sessionoptions-=curdir " Use absolute paths in sessions
set title                  " change the terminal's title
set novisualbell           " don't beep, no sound on errors
set noerrorbells           " don't beep
" }
"------------------------------------------------------------------------------
" Vim UI {
syntax on     " Switch syntax highlighting on,
syntax enable " when the terminal has colors

" Colorscheme
set t_Co=256
if has("gui_running")
    if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
      set background=dark
      colorscheme solarized
      set visualbell t_vb= "disable visual bell"
    endif
      let g:solarized_termtrans=1
      let g:solarized_contrast="high"
      let g:solarized_visibility="high"
      set tabpagemax=15                  " Only show 15 tabs
"     set guioptions=                    " No GUI Menu
      set guioptions+=c                  " When in gui mode, don't open an
                                         " entire messagebox to ask a question  
      set mousemodel=popup               " 当右键单击窗口的时候， 弹出快捷菜单
      set guifont=Monaco\ 13 linespace=0 " font
else
      colorscheme molokai
      if has("terminfo")
          let &t_Sf="\ESC[3%p1%dm"
          let &t_Sb="\ESC[4%p1%dm"
      else     
          let &t_Sf="\ESC[3%dm"
          let &t_Sb="\ESC[4%dm"
      endif
endif
set report=0                " tell us when anything is changed via :...
set shortmess=aOstT         " shortens messages to avoid 'press a key' prompt
set cursorline              " highlight the line the cursor is on
                            " underline the current line, for quick orientation
set cursorcolumn
highlight clear SignColumn  " SignColumn should match background for
                            " things like vim-gitgutter
if exists('+colorcolumn')   " VIM 7.3+ has support for highlighting a specified
                            " column.
	set colorcolumn=80
    " hi ColorColumn ctermbg=Gray ctermfg=Black guibg=#404040
    command Skinny set cc=73
    command Wide set cc=80
endif

if has('cmdline_info')
    set ruler " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd " Show partial commands in status line and
                " Selected characters/lines in visual mode
endif
"------------------------------------------------------------------------------
" Cursor colour and blinking
highlight Cursor guifg=white guibg=Red
highlight iCursor guifg=white guibg=Green
set guicursor=n-v-c:block-Cursor
set guicursor+=i:ver20-iCursor-blinkon600-blinkoff600
set guicursor+=n-v-c:blinkon0
set guicursor+=i:blinkwait10
"Gvim only
" set the color green in insert mode and red in every other mode.
au InsertLeave * hi Cursor guibg=red
au InsertEnter * hi Cursor guibg=green
"------------------------------------------------------------------------------
" Status line
" ------------------------------------------------------------------------------
" tell VIM to always put a status line in, even
" if there is only one window
if has('statusline')
    set laststatus=2
    set cmdheight=1                          " use a status bar that is 1 rows
                                             " high by default
    set statusline=%<%f\                     " Filename
    set statusline+=%w%h%m%r                 " Options
    set statusline+=%{fugitive#statusline()} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]            " Filetype
    set statusline+=\ [%{getcwd()}]          " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif
set backspace=indent,eol,start               " 在 insert 模式下能用删除键进行删除
set linespace=0                              " No extra spaces between rows
let g:Powerline_symbols = 'fancy'
" }
"------------------------------------------------------------------------------
" Set wild menu & mode
set winminheight=0              " Windows can be 0 line high
set wildmenu                    " Show list instead of just completing
set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,*.jpg,*.gif,*.png " ignore these list file extensions
set wildmode=list:longest,full  " Command <Tab> completion, list matches,
                                " then longest common part, then all.
" Set complete options
set completeopt=longest,menu
                                " omnicomplete，optimize auto complete
"-----------------------------------------------------------------------------
" Backups and swaps
set nobackup                                   " do not keep backup files,
                                               "it's 70's style cluttering
set noswapfile                                 " do not write annoying
                                               "intermediate swap files,
set directory=$HOME/.vim/tmp/swap//            " Same for swap files
silent execute '!mkdir -p $HOME/.vim/tmp/swap'

"-----------------------------------------------------------------------------
" Store info after file is closed
set hidden " hide buffers instead of closing them this
           " means that the current buffer can be put
           " to background without being written; and
           " that marks and undo history are preserved

set switchbuf=useopen " reveal already opened files from the
                      " quickfix window instead of opening new buffers
set history=1000      " remember more commands and search history
set undolevels=1000   " use many muchos levels of undo
if v:version >= 730
    set undofile      " keep a persistent backup file
    set undodir=~/.vim/.undo,~/tmp,/tmp
endif
if exists('+undofile')
	set undofile      " allow undoing even after the file is closed
	set undodir=$HOME/.vim/tmp/undo//
	silent execute '!mkdir -p $HOME/.vim/tmp/undo'
endif
" Remember cursor position using views
" Store views in special folder
set viewdir=$HOME/.vimviews// " same for view files
silent execute '!mkdir -p $HOME/.vimviews'
if has("autocmd")
" When editing a file, always jump to the last cursor position
   autocmd BufReadPost *
   \ if line("'\"") > 0 && line ("'\"") <= line("$") |
   \ exe "normal g'\"" |
   \ endif
endif
" Remember everything (position, folds, etc)
au BufWinLeave * mkview
au BufWinEnter * silent loadview

"------------------------------------------------------------------------------
" Indentation and tabs {
set autoindent " indent at the same level of the previous line
set smartindent
" Switch autoindent
nmap <leader>ai :set autoindent!<CR>
set expandtab                " expand tabs by default (overloadable per file 
                             " type later)
set tabstop=4                " tabs display as four spaces
set softtabstop=4            " when hitting <BS>, pretend like a tab is remov-
                             " ed, even if spaces
set shiftwidth=4             " one tab length to shift blocks with >> or <<
set shiftround               " use multiple of shiftwidth when indenting with 
                             " '<' and '>'
set smarttab                 " insert tabs on the start of a line according to
set formatoptions+=mM        " 正确处理中文字符的折行和拼接
set formatoptions=tcrqn      " 自动格式化
set pastetoggle=<F2>         " when in insert mode, press <F2> to go to
                             " paste mode, where you can paste mass data
                             " that won't be autoindented
au InsertLeave * set nopaste " clear paste mode when going back to normal mode
" }
"------------------------------------------------------------------------------
" Search/Replace
"------------------------------------------------------------------------------
set smartcase    " smart case search
set ignorecase   " ignore case if search pattern is all lowercase,
                 " case-sensitive otherwise
set magic        " Enable magic matching
set incsearch    " show search matches as you type
set showmatch    " Show matching brackets/parenthesis
set hlsearch     " highlight search terms
"------------------------------------------------------------------------------
"Keep search matches in the middle of the window and pulse the line when
"moving to them.
nnoremap n n:call PulseCursorLine()<CR>
nnoremap N N:call PulseCursorLine()<CR>
function! PulseCursorLine()
    let current_window = winnr()
    windo set nocursorline
    execute current_window . 'wincmd w'
    setlocal cursorline
    redir => old_hi
    silent execute 'hi CursorLine'
    redir END
    let old_hi = split(old_hi, '\n')[0]
    let old_hi = substitute(old_hi, 'xxx', '', '')
    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 20m

    hi CursorLine guibg=#4a4a4a
    redraw
    sleep 30m

    hi CursorLine guibg=#3a3a3a
    redraw
    sleep 30m

    hi CursorLine guibg=#2a2a2a
    redraw
    sleep 20m
    execute 'hi ' . old_hi
    windo set cursorline
    execute current_window . 'wincmd w'
endfunction

" < and > are considering as a matching pair
set matchpairs+=<:>
"------------------------------------------------------------------------------
"退出插入模式时，关闭 fcitx；进入插入模式时，启用 fcitx
let g:input_toggle = 1
function! Fcitx2en()
    let s:input_status = system("fcitx-remote")
    if s:input_status == 2
        let g:input_toggle = 1
        let l:a = system("fcitx-remote -c")
    endif
endfunction

function! Fcitx2zh()
    let s:input_status = system("fcitx-remote")
    if s:input_status != 2 && g:input_toggle == 1
        let l:a = system("fcitx-remote -o")
        let g:input_toggle = 0
    endif
endfunction

set ttimeoutlen=150
autocmd InsertLeave * call Fcitx2en() " 退出插入模式
" autocmd InsertEnter * call Fcitx2zh() " 进入插入模式
"------------------------------------------------------------------------------
" Lines folding
set foldenable        " enable folding
set foldlevelstart=99 " start out with everything folded
set foldnestmax=1
set foldmethod=syntax
nnoremap <Space> za
vnoremap <Space> za

" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>
"------------------------------------------------------------------------------
" Soft wrapping {
" display line breaks
set showbreak=↳\ \ \
set textwidth=0  " no hard wrapping at all
set wrapmargin=0 " no automatic wrapping depending on window width
" }
" ------------------------------------------------------------------------------
" Show/hide invisible characters
set nolist " don't show invisible characters by default,
           " but it is enabled for some file types (see later)
map <leader>i :set list!<CR>
map <D-I> :set list!<CR>
"Make invisible characters look nice in Vim
set listchars=tab:▸\ ,eol:¬,trail:~,nbsp:·,extends:>,precedes:<
" make them non conspicuous
highlight NonText guifg=#4a4a59 ctermfg=3*
highlight SpecialKey guifg=#4a4a59 ctermfg=3*
"------------------------------------------------------------------------------
" Toggle line numbers
nmap <leader>n :set number!<CR>
nmap <D-N> :set number!<CR>
if exists('+relativenumber')
	nmap <leader>nr :set relativenumber!<CR>
	nmap <D-R> :set relativenumber!<CR>
endif
"------------------------------------------------------------------------------
" Spelling
source ~/.vim/bundle/vim-autocorrect/autocorrect.vim  " Common abbreviations
                                                      " misspellings
set nospell                                           " By default spelling is 
                                                      " off.
" setglobal spell spelllang=en_uk
" au BufRead,BufNewFile,BufWrite *.txt,*.tex,*.latex,*.md set spell  "enable it
                                                                "for the English
                                                                " text files
" Toggle spelling mode with `s
nmap <silent> <leader>s :set spell!<CR>
"------------------------------------------------------------------------------
" Conflict Markers
" https://github.com/nvie/vimrc/
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
" shortcut to jump to next conflict marker
nnoremap <silent> <D-+> /\v^(\<\|\=\|\>){7}<CR>
"------------------------------------------------------------------------------
" Key (re)Mappings {
let mapleader = "`"
" allow to use `;` instead of `:`
nnoremap ; :
vnoremap ; :
" Easier moving of code blocks
vnoremap <  <gv 
vnoremap >  >gv 
" Clears the search register
nnoremap <silent> <leader>/ :nohlsearch<CR>
" Get rid of the highlighted searches
nnoremap <leader><space> :nohlsearch<CR>
"------------------------------------------------------------------------------
" Easy window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
"------------------------------------------------------------------------------
" easy mirror window
nnoremap <leader>w <C-w>v<C-w>l
"------------------------------------------------------------------------------
" Reselect text that was just pasted with ,v
nnoremap <leader>v V`]
" :cd. change working directory to that of the current file
cmap cd. lcd %:p:h
" Search for <cword> and replace with input() in all open buffers
function! Replace()
    let s:word = input("Replace " . expand('<cword>') . " with:")
    :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
    :unlet! s:word
endfunction
"replace the current word in all opened buffers
map <leader>rw :call Replace()<CR>
" Highlight word at cursor without changing position
nnoremap <leader>h *<C-O>
"------------------------------------------------------------------------------
"Indent the whole buffer
noremap <Leader>= m`gg=G`
" open the error console
map <leader>qf :botright cope<CR>
" move to next error
map <leader>] :cn<CR>
" move to the prev error
map <leader>[ :cp<CR>
" For when you forget to sudo.. Really Write the file.
cnoremap w! w !sudo tee % >/dev/null
"------------------------------------------------------------------------------
" Quickly get out of insert mode without your fingers having to leave the
" home row (either use 'jj' or 'jk')
inoremap jk <Esc>
inoremap JK <Esc>
inoremap Jk <Esc>
inoremap jK <Esc>
inoremap jj <Esc>
inoremap jJ <Esc>
inoremap Jj <Esc>
inoremap JJ <Esc>
"------------------------------------------------------------------------------
" Jump to matching pairs easily, with Tab
nmap <tab> %
vmap <tab> %
"------------------------------------------------------------------------------
" C-U in insert/normal mode, to uppercase the word under cursor
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe
"------------------------------------------------------------------------------
" Use shift-H and shift-L for move to beginning/end
nnoremap H 0
nnoremap L $
"------------------------------------------------------------------------------
" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv
"------------------------------------------------------------------------------
" Copy and Paste
"Copy stuff to Xlip
nmap <silent> <unique> Y Y:call system("xclip -i -selection clipboard",getreg("\""))<CR>
" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>
"------------------------------------------------------------------------------
" Scrolling
set scrolloff=4  " keep 4 lines off the edges of the screen when scrolling
set scrolljump=5 " Lines to scroll when cursor leaves screen
nnoremap S J
vnoremap S J
nmap J <C-D>
nmap K <C-U>
" }
"------------------------------------------------------------------------------
"function

"------------------------------------------------------------------------------
" Filetype specific {
augroup ft_quickfix
        autocmd!
            autocmd Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap textwidth=0
augroup end
"------------------------------------------------------------------------------
if has("autocmd")
    augroup invisible_chars
        " Show invisible characters in all of these files
        " autocmd Filetype python,rst setlocal list
        " Remove trailing whitespaces and ^M chars
        function! <SID>StripTrailingWhitespaces()
            let l = line(".")
            let c = col(".")
            %s/\s\+$//e
            call cursor(l, c)
        endfunction
        autocmd FileType c,cpp,java,php,ruby autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
    augroup end
"------------------------------------------------------------------------------
    augroup filetypedetect
        autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
        au! BufRead,BufNewFile *.zcml set filetype=xml
        au! BufRead,BufNewFile *.rst set filetype=rst
        au! BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,Capfile,*.rake,config.ru} set filetype=ruby
        au! BufRead,BufNewFile {*.md,*.mkd,*.markdown} set filetype=markdown
        au! BufRead,BufNewFile {COMMIT_EDITMSG} set filetype=gitcommit
        au BufEnter *.txt setlocal ft=txt
        au BufNewFile,BufRead *.json set ft=javascript   " add json syntax highlighting 
    augroup end
"------------------------------------------------------------------------------
    augroup indentation
        au!
        autocmd Filetype ruby,eruby,yaml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
        autocmd Filetype python setlocal expandtab textwidth=79 tabstop=8
        autocmd FileType html set tabstop=2|set shiftwidth=2
        autocmd FileType xhtml set tabstop=2|set shiftwidth=2
        autocmd FileType xml set tabstop=2|set shiftwidth=2
        autocmd FileType make setlocal ts=4 sts=4 sw=4 noexpandtab
        autocmd FileType c,cpp,cs set cindent tabstop=4 shiftwidth=4 noexpandtab
    augroup end
"------------------------------------------------------------------------------
    augroup  autowrap
        autocmd filetype rst setlocal textwidth=74
        autocmd filetype rst setlocal formatoptions+=nqt
        autocmd filetype rst match ErrorMsg '\%>74v.\+'
        autocmd BufRead /tmp/mutt-* set tw=72           " 在mutt中将文本的宽度限制在 72 个字符
        autocmd BufRead,BufNewFile *.txt set wm=2 tw=80 " txt 文档限定在80个字符
    augroup end
"------------------------------------------------------------------------------
    augroup textile_files
        au!
        autocmd filetype textile set tw=78 wrap
        " Render YAML front matter inside Textile documents as comments
        autocmd filetype textile syntax region frontmatter start=/\%^---$/ end=/^---$/
        autocmd filetype textile highlight link frontmatter Comment
    augroup end
endif
" }
"------------------------------------------------------------------------------
"Plugins {
"------------------------------------------------------------------------------
" => NERDTree Settings
let NERDTreeShowFiles=1
let NERDTreeShowHidden=1          " Show hidden files, too
let NERDTreeShowBookmarks=1       " Show the bookmarks table on startup
let NERDTreeHighlightCursorline=1 " Highlight the selected entry in the tree
 "Store the bookmarks file
let NERDTreeBookmarksFile=expand("$HOME/.vim/NERDTreeBookmarks")
" Hide Python, LaTeX and other auxiliary files
let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr', 'pdf', 'pdfsync']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeKeepTreeInNewTab=1
let g:NERDTreeWinPos="right"
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
nmap <leader>nt :NERDTreeFind<CR>
"------------------------------------------------------------------------------
" => Ctags and Cscope
if has("ctags")
    set tags=./tags;/,~/.vim/tags
    " 为/usr/include目录生成tags文件，缺点可能会导致自动完成的速度减慢，必要时去除
    "更好的办法是需要时才加，例如/usr/include/gtk2.0/tags
    "set tags+=/usr/include/tags
    " Auto finding
    set tags=tags;
endif
" Use both cscope and ctag
if has("cscope")
    set csprg=/usr/bin/cscope
    set cscopetag
    " Show msg when cscope db added
    set cscopeverbose
    " Use tags for definition search first
    set cscopetagorder=1
    " Use quickfix window to show cscope results
    set cscopequickfix=s-,g-,d-,c-,t-,e-,f-,i-
    " 查找 C 语言符号，即查找函数名、宏、枚举值等出现的地方
    nmap css :cs find s <C-R>=expand("<cword>")<CR><CR>
    " 查找函数、宏、枚举等定义的位置，类似 ctags 所提供的功能
    nmap csg :cs find g <C-R>=expand("<cword>")<CR><CR>
    " 查找本函数调用的函数
    nmap csd :cs find d <C-R>=expand("<cword>")<CR><CR>
    " 查找调用本函数的函数
    nmap csc :cs find c <C-R>=expand("<cword>")<CR><CR>
    " 查找指定的字符串
    nmap cst :cs find t <C-R>=expand("<cword>")<CR><CR>
    " 查找 egrep 模式，相当于 egrep 功能，但查找速度快多了
    nmap cse :cs find e <C-R>=expand("<cword>")<CR><CR>
    " 查找并打开文件，类似 vim 的 find 功能
    nmap csf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    " 查找包含本文件的文件
    nmap csi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    " 生成新的数据库
    nmap csn :lcd %:p:h<CR>:!my_cscope<CR>
    " 自己来输入命令
    nmap cs<Space> :cs find
endif
"------------------------------------------------------------------------------
" => Golden Ratio
" Disable Golden Ratio plugin when in diff mode
if &diff
    let g:loaded_golden_ratio=1
endif
"------------------------------------------------------------------------------
" => simple_bookmarks
" The plugin provides several commands to manage named bookmarks.
" :Bookmark here
" :GotoBookmark here
" :DelBookmark here
"------------------------------------------------------------------------------
" => vim-textobj-rubyblock'
" The plugin provides two text object : ar,ir.
runtime macros/matchit.vim
"------------------------------------------------------------------------------
" => Tagbar
let g:tagbar_autofocus=1
let g:tagbar_expand=1
let g:tagbar_foldlevel=2
let g:tagbar_ironchars=['▾', '▸']
let g:tagbar_autoshowtag=1
nnoremap <Leader>tb :TagbarToggle<CR>
"------------------------------------------------------------------------------
" => Fugitive
if executable('git')
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
endif
"------------------------------------------------------------------------------
" => Gundo
nnoremap <Leader>u :GundoToggle<CR>
let gundo_preview_bottom = 1
"------------------------------------------------------------------------------
" => EasyTags
" function! InitializeTagDirectory()
    " let parent=$HOME
    " let prefix='.vim'
    " let dirname='tags'
    " let directory=parent.'/'.prefix.'/'.dirname.'/'
    " if !isdirectory(directory)
        " if exists('*mkdir')
            " call mkdir(directory)
            " let g:easytags_by_filetype=directory
        " else
            " echo "Warning: Unable to create directory: ".directory
            " echo "Try: mkdir -p ".directory
        " endif
    " else
        " let g:easytags_by_filetype=directory
    " endif
" endfunction
" call InitializeTagDirectory()
" " Faster syntax highlighting using Python
" let g:easytags_python_enabled=1
" let g:easytags_python_script=1
" let g:easytags_include_members=1
" highlight cMember gui=italic
"------------------------------------------------------------------------------
" => scrooloose/syntastic
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=1
"let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby', 'js'], 'passive_filetypes': ['html', 'css', 'slim'] }
"------------------------------------------------------------------------------
" => FuzzyFinder
map <leader>ff  :FufCoverageFile!<CR>
let g:fuf_enumeratingLimit = 5000
let g:fuf_coveragefile_prompt = '=>'
"C-w删掉输入字串，C-k左右分，C-g上下分
"------------------------------------------------------------------------------
" => Tabularize
nmap <Leader>a= :Tabularize /=<CR>
vmap <Leader>a= :Tabularize /=<CR>
nmap <Leader>a: :Tabularize /:\zs<CR>
vmap <Leader>a: :Tabularize /:\zs<CR>
"------------------------------------------------------------------------------
" => a.vim
" A few of quick commands to swtich between source files and header files quickly.
":A switches to the header file corresponding to the current file being edited
"(or vise versa)
":AS splits and switches
":AV vertical splits and switches
":AT new tab and switches
":AN cycles through matches
":IH switches to file under cursor
":IHS splits and switches
":IHV vertical splits and switches
":IHT new tab and switches
":IHN cycles through matches
"<Leader>ih switches to file under cursor
"<Leader>is switches to the alternate file of file under cursor (e.g. on
"<foo.h> switches to foo.cpp)
"<Leader>ihn cycles through matches
"------------------------------------------------------------------------------
" YouCompleteMe
" let g:ycm_key_list_previous_completion=['<Up>']
" let g:ycm_key_list_select_completion =['<Down>']
"------------------------------------------------------------------------------
" => vim-git-inline-diff
" Symbol for lines which have been added, default: +
let g:git_diff_added_symbol='⇒'
" " Symbol for lines which have been removed, default: -
let g:git_diff_removed_symbol='⇐'
" " Symbol for lines which have been changed, default: <>
let g:git_diff_changed_symbol='⇔'
"------------------------------------------------------------------------------
" => PEP8  Check your python source files with PEP8
"The default mapping is F5, you can change it putting
let g:pep8_map='<leader>8'
"------------------------------------------------------------------------------
" => vim-flake8
" To add builtins, in your .vimrc:
let g:flake8_builtins="_,apply" 
" To ignore errors, in your .vimrc:
let g:flake8_ignore="E501,W293"
" If you want to change the max line length for PEP8:
let g:flake8_max_line_length=99
" To set the maximum McCabe complexity before a warning is issued:
let g:flake8_max_complexity=10
" run the Flake8 check every time you write a Python file
autocmd BufWritePost *.py call Flake8()
autocmd FileType python map <buffer> <Leader>3 :call Flake8()<CR>
"------------------------------------------------------------------------------
" https://github.com/nvie/vim-pyunit
" => pyUnit
"------------------------------------------------------------------------------
" => SimpleComplie
nnoremap <Leader>r :SingleCompileRun<CR>
let g:SingleCompile_showquickfixiferror=1
"------------------------------------------------------------------------------
" => vim-indent-guides'
"<leader>ig as default
let g:indent_guides_guide_size=1            "设置对齐线宽度为 1
let g:indent_guides_enable_on_vim_startup=0
"------------------------------------------------------------------------------
" => ZoomWin
"用于分割窗口的最大化与还原
"<c-w>o as default
"------------------------------------------------------------------------------
" => cSyntaxAfter
au! BufRead,BufNewFile,BufEnter *.{c,cpp,javascript} call CSyntaxAfter()
"------------------------------------------------------------------------------
" => Dmenu
" Forked from http://leafo.net/posts/using_dmenu_to_open_quickly.html
" Strip the newline from the end of a string
function! Chomp(str)
  return substitute(a:str, '\n$', '', '')
endfunction

" Find a file and pass it to cmd
function! DmenuOpen(cmd)
  let fname = Chomp(system("git ls-files | dmenu -i -nb '#808080' -nf '#FFFFFF' -sb '#FFFFFF' -sf '#000000' -fn 'Monoca:10' -l 20 -p " . a:cmd))
  if empty(fname)
    return
  endif
  execute a:cmd . " " . fname
endfunction

map <c-t> :call DmenuOpen("tabe")<CR>
map <c-f> :call DmenuOpen("edit")<CR>
map <leader>te :tabedit
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove
"------------------------------------------------------------------------------
" => Ag
if executable('ag')
   nnoremap <Leader>a :Ag<Space>
   let g:ackprg='ag -H --nocolor --nogroup --column'
endif
"------------------------------------------------------------------------------
" => DelimitMate
let delimitMate_expand_cr=1
let delimitMate_expand_space=1
let delimitMate_balance_matchpairs=1
"------------------------------------------------------------------------------
" => NERD_commenter
let NERDCommentWholeLinesInVMode=2
let NERDSpaceDelims=1
let NERDRemoveExtraSpaces=1
"------------------------------------------------------------------------------
" => vim-javascript
let g:html_indent_inctags="html,body,head,tbody"
let g:html_indent_script1="inc"
let g:html_indent_style1="inc"
"------------------------------------------------------------------------------
" => UltiSnip
let g:UltiSnipsExpandTrigger="<c-tab>"
let g:UltiSnipsListSnippets="<c-s-tab>""
"------------------------------------------------------------------------------
" => rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
" always on
au VimEnter * RainbowParenthesesToggle
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBrace
"------------------------------------------------------------------------------
" => vim-cdo
" Runs the same command over every entry in the quickfix list (:Cdo) or
" location list (:Ldo).
" Example: Find every instance of foo in the working directory and replace it
" with bar.
" :grep foo
" :Cdo s/foo/bar/c | update
"------------------------------------------------------------------------------
" => VisIncr
" https://github.com/vim-scripts/VisIncr
"------------------------------------------------------------------------------
" => Pydiction
" let g:pydiction_menu_height = 20
" let g:pydiction_location = '~/.vim/bundle/Pydiction'
"------------------------------------------------------------------------------
let g:calendar_diary="~/.diary"
