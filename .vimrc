set nocompatible " use vim settings, instead of vi settings
" behave mswin " set selection selectmode and other stuff for windows

" ==============================================================================
" PLUGIN HANDLING
" ==============================================================================

if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
Plug 'SirVer/ultisnips'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale' " TODO: look into this more

if has('nvim')
	Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
	Plug 'lifepillar/vim-mucomplete'
endif

Plug 'zchee/deoplete-jedi'
Plug 'shawncplus/phpcomplete.vim'

Plug 'rakr/vim-one' " colorscheme
Plug 'sjl/badwolf' " colorscheme

call plug#end()

" ---- mucomplete settings ----
if !has('nvim')
	let g:mucomplete#enable_auto_at_startup = 1
endif

" ---- deoplete settings ----
if has('nvim')
	let g:deoplete#enable_at_startup = 1
	autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
	inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

	"let g:deoplete#sources = {}
	"let g:deoplete#sources['python'] = []

	"call deoplete#custom#source('ultisnips', 'matchers', ['matcher_fuzzy'])
endif



" matchit plugin makes % work a bit better
" packadd matchit

" set rtp+=/vim/vim74/bundle/Vundle.vim
" call vundle#begin()
" Plugin 'VundleVim/Vundle.vim'
" Plugin 'scrooloose/nerdtree'
" Plugin 'xolox/vim-easytags'
" Plugin 'xolox/vim-misc'
" Plugin 'shougo/neocomplete.vim'
" Plugin 'SirVer/ultisnips'
" Plugin 'majutshushi/tagbar'
" call vundle#end()

" ---- NERDTree settings ----
" let g:NERDTreeShowBookmarks=1
" if only NERDTree buffer is open, close window
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nnoremap <S-SPACE> :NERDTree<CR>

" ---- easytags settings ----
" let g:easytags_auto_highlight=0
" let g:easytags_auto_update=0
" let g:easytags_include_members=1
" let g:easytags_supress_report=1
" let g:easytags_dynamic_files=1

" ---- neocomplete settings ----
" let g:neocomplete#enable_at_startup = 1
" let g:neocomplete#enable_auto_select = 1
" let g:neocomplete#auto_completion_start_length = 0
" if !exists('g:neocomplete#sources')
  " let g:neocomplete#sources = {}
" endif
" let g:neocomplete#sources._ = ['tag', 'buffer']
"let g:neocomplete#sources.cpp = ['buffer', 'dictionary']

" Define keyword.
" if !exists('g:neocomplete#keyword_patterns')
	" let g:neocomplete#keyword_patterns = {}
" endif
" let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" complete suggestion with shift space
" inoremap <expr><S-Space> pumvisible() ? "\<C-y><Space>" : "\<Space>"

" do thing so that enter doesn't go down to confirm an autocomplete
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " for not inserting <CR> key.
  " return pumvisible() ? "\<C-y>" : "\<CR>"
" endfunction

" ---- UltiSnips settings ----
" let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsEditSplit = "context"
let g:UltiSnipsSnippetsDir=$HOME."/.vim/UltiSnips" " where snippets are saved
let g:UltiSnipsSnippetDirectories=[$HOME."/.vim/UltiSnips"] " where snippets are searched for TODO: just add the library directory here, so you can use both quickly created ones as well as the common library
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<c-space>"
let g:UltiSnipsJumpBackwardTrigger="<m-space>"
"let g:UltiSnipsListSnippets="<C-e>"
"inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<C-R>=UltiSnips#ExpandSnippet()"

" ---- Tagbar settings ----
"nmap <silent> <leader>t :TagbarToggle<CR>

" ---- lightline settings ----
"  powerline characters:
"  separator left: \ue0b0
"  separator right: \ue0b2
"  subseparator left: \ue0b1
"  subseparator right: \ue0b4
let g:lightline = {
      \ 'colorscheme': 'powerline',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified'] ],
	  \	  'right': [ [ 'lineinfo' ],
      \              [ 'percent', 'linecount' ],
      \              [ 'fileformat', 'fileencoding', 'filetype'] ]
      \ },
      \ 'component': {
      \   'linecount': '%L'
      \ },
	  \ 'separator': { 'left': '', 'right': '' },
	  \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" ---- gitgutter settings ----
"set updatetime=100
"https://github.com/airblade/vim-gitgutter TODO: add toggle hotkeys

" ---- ale settings ----
let g:ale_python_pylint_options = "--init-hook='import sys; sys.path.append(\".\")'"
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 0
let g:ale_fixers = {
			\ '*': ['remove_trailing_lines', 'trim_whitespace'],
			\ 'python': ['black', 'isort'],
			\ 'ruby': ['rufo', 'rubocop'],
			\ 'c': ['clang-format'],
			\ 'c++': ['clang-format'],
			\ }
noremap <C-f> :ALEFix<CR>


" ==============================================================================
" GUI SPECIFIC STUFF
" ==============================================================================

" if &term == "rxvt-unicode-256color"
	" colorscheme jellybeans

	" " fix some theming stuff
	" let g:jellybeans_overrides = { 'background': {'ctermbg': 'none', '256ctermbg': 'none'}, }
	"
	" let g:jellybeans_overrides = {
			" \    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
			" \	'CursorLine': { 'ctermbg': 'DarkGrey', '256ctermbg': '236' },
			" \}
	"
" endif

" Don't let vim theme ruin the terminal transparency
autocmd ColorScheme * highlight Normal ctermbg = None
autocmd ColorScheme * highlight NonText ctermbg = None
autocmd ColorScheme * highlight Folded ctermbg = None
autocmd ColorScheme * highlight FoldColumn ctermbg = None
autocmd ColorScheme * highlight SignColumn ctermbg = None
autocmd ColorScheme * highlight LineNr ctermbg = None

colorscheme badwolf
set background=dark


if has('gui_running')
	set guifont=Consolas:h10
	" colorscheme solarized
	" colorscheme jellybeans
	set background=dark
	set guioptions-=T " remove toolbar
	set guioptions-=r " remove scrollbar on right
	set guioptions-=R " same as above
	set guioptions-=l " remove scrollbar on left
	set guioptions-=L " same as above
	set guioptions-=b " remove bottom scrollbar
	set guioptions-=m " remove menu bar
	set lines=25 columns=120 " make the starting window larger ("for h10 consolas, set this to 28x125
endif

" allow mouse usage if available
if has('mouse')
	set mouse=a
	set mousehide " hide mouse when typing text
endif

" ==============================================================================
" SETTINGS
" ==============================================================================

" look
set number " line numbers!
set scrolloff=4 " keep 4 visible lines around cursorline when near top or bottom
set cursorline " bghighlight of current line
set title " window title
set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:p:h\")})%)%(\ %a%)\ -\ %{v:servername}
set laststatus=2 " always show status line
set statusline=%t\ %m%*\ %y%h%r%w\ %<%F\ %*\ %=\ Lines:\ %L\ \ \ Col:\ %c\ \ \ [%n]
set noshowmode " mode unnecessary since shown in lightline

" search
set hlsearch " highlight search matches
set incsearch " move highlight as you add charachters to search string
set ignorecase " ignore case in search
set smartcase " ...unless being smart about it!

" tabs
set tabstop=4 " number of columns used for a tab
set shiftwidth=4 " how columns indent operations (<<, >>) use
set softtabstop=4 " how many spaces used when hit tab in insert mode
set noexpandtab " don't convert tabs to spaces!!! I'm not an anarchist!
autocmd FileType python setlocal expandtab " okay, fine, spaces in python...
"set expandtab
"set shiftround " if fixing indenting, actually fix it

" folding
set foldenable
set foldlevelstart=0 " start with all folds folded
set foldmethod=syntax " commented out because of neocomplete (slows down?)
"set foldmethod=2 " adds a fold column
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo " specifies which commands will auto-unfold a section
set foldcolumn=1

" commandline tab help/completion
set wildmenu
set wildmode=longest,list

" text editing behavior
"set wrap
set encoding=utf-8
set autoindent " smart indenting and stuff, based on file type
set textwidth=80 " how many columns before wrapping text (0 for no limit) NOTE: formatoptions specifies what kind of text this is used for
set wrapmargin=0 " distance from edge of window that wrapping starts
set formatoptions=l " long lines won't be broken up if entering insert mode and already past textwidth
"set formatoptions+=c " auto-wrap comments using text width and auto insert comment leader
set formatoptions+=j " be all smart and when joing a comment line, take out the extra comment leader
set formatoptions+=q " allow formatting of comments with 'gq'
"set formatoptions+=r " automatically insert comment  leader after hitting enter in insert mode
set backspace=indent,eol,start whichwrap+=<,>,[,] " backspace and cursor keys wrap to previous/next line

" directories/file handling
set autoread
set backup
set undofile
set swapfile
set backupdir=~/tmp/bak
set undodir=~/tmp/undo
set directory=~/tmp/swap

" if directories don't already exist, make them
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), "p")
endif

" set tags=./.tags;,~/.tags
" set makeprg=build.bat

" sound
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" misc
set hidden " allows switching buffers while still having unsaved changes in prev buffer
"set omnifunc=syntaxcomplete#Complete " I still have no idea what this does...
set lazyredraw " reduce flickering
set showmatch
set magic " for regular expressions
" set cryptmethod=blowfish2

set completeopt+=menuone
set completeopt+=noselect
set completeopt-=preview " so that annoying preview window stops popping up...
set shortmess+=c

" ==============================================================================
" KEY BINDINGS
" ==============================================================================

" ESC to leave insert mode is terrible! 'jk' is much nicer
inoremap jk <SPACE><BS><ESC>
inoremap JK <SPACE><BS><ESC>
inoremap Jk <SPACE><BS><ESC>

" make ',' find next character, like ';' normally does
nnoremap , ;

" press ';' in normal mode instead of ':', it's too common to use shift all the time!
nnoremap ; :
vnoremap ; :

" CTRL-BS deletes word like in windows
inoremap <C-BS> <C-W>
nnoremap <C-BS> a<C-W><ESC>

" backspace in Visual mode deletes selection
vnoremap <BS> d

" CTRL-X for cut
vnoremap <C-X> "+x

" CTRL-C for copy
vnoremap <C-C> "+y

" CTRL-V for paste
nnoremap <C-V> "+gP
cnoremap <C-V> <C-R>+

" normally CTRL-V is the column select, but change it to ctrl-q
nnoremap <c-b> <c-v>

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>

" CTRL-Z is Undo; not in cmdline though
noremap <C-Z> u
inoremap <C-Z> <C-O>u

" CTRL-Y is Redo (although not repeat); not in cmdline though
noremap <C-Y> <C-R>
inoremap <C-Y> <C-O><C-R>

" CTRL-A is Select all
noremap <C-A> gggH<C-O>G
inoremap <C-A> <C-O>gg<C-O>gH<C-O>G
cnoremap <C-A> <C-C>gggH<C-O>G
onoremap <C-A> <C-C>gggH<C-O>G
snoremap <C-A> <C-C>gggH<C-O>G
xnoremap <C-A> <C-C>ggVG

" CTRL-Tab is Next window
noremap <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
onoremap <C-Tab> <C-C><C-W>w

" ctrl enter and shift enter add empty lines above and below cursorline respectively
nnoremap <S-CR> m`o<ESC>``
nnoremap <C-CR> m`O<ESC>``

" better window navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" ALT-j/k moves lines up and down
"nnoremap <A-j> :m .+1<CR>==
"nnoremap <A-k> :m .-2<CR>==
"inoremap <A-j> <Esc>:m .+1<CR>==gi
"inoremap <A-k> <Esc>:m .-2<CR>==gi
"vnoremap <A-j> :m '>+1<CR>gv=gv
"vnoremap <A-k> :m '<-2<CR>gv=gv

" shortcuts to move back and forth in buffers
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>

" compile shortcuts
nnoremap <F5> :make<CR>
inoremap <F5> <ESC>:make<CR>

" fix broken CTRL-A increment number shortcut to CTRL-I
nnoremap <C-I> <C-A>

" tab control
nnoremap <tab>h :tabprev<cr>
nnoremap <tab>l :tabnext<cr>
nnoremap <tab><enter> :tabnew<cr>
nnoremap <tab>x :tabclose<cr>

" make yank work the same as the other keys
nnoremap Y y$

" more sane usages of H and L
nnoremap H ^
nnoremap L $

" convert word before cursor (or on cursor) to upper case (uses z mark)
inoremap <C-u> <esc>mzgUiw`za
nnoremap <C-u> mzgUiw`z

" surround word with things (uses z mark)
nnoremap <leader>( mzbi(<esc>ea)<esc>`zl
nnoremap <leader>" mzbi"<esc>ea"<esc>`zl
nnoremap <leader>< mzbi<<esc>ea><esc>`zl

" Split line (on next space)
nnoremap S f<space>s<cr><esc>==

" leader shortcuts!
nnoremap <LEADER><SPACE> :nohlsearch<CR>

"inoremap <leader>/ "=strftime("%m/%d/%Y")

" date/time stuff
inoremap <C-d> <C-r>=strftime('%m/%d/%Y')<cr><esc>a
nnoremap <C-d> gg/Date edited<cr>2E2lC<C-r>=strftime("%m/%d/%Y")<cr><esc>:nohlsearch<cr><C-o>:echo "Date edited timestamp updated!"<cr>

"automatically add braces!
"inoremap <C-[> <CR>{<CR>}<Esc>O<tab>
"inoremap <C-[> <CR>{<CR>}<Esc>O

" automagically add things
inoremap {{ <esc>xo{<cr>}<esc>O
"inoremap (( (<esc>a)<esc>i
"inoremap [[ [<esc>a]<esc>i
"inoremap << <<esc>a><esc>i
"inoremap "" "<esc>a"<esc>i
"inoremap '' '<esc>a'<esc>i

" useful things to have in insert mode
inoremap <C-o> <esc>o
inoremap <C-l> <esc>la

nnoremap <enter> o<esc>k

" better searching keys
map <space> /
map <S-space> ?

" move lines of text up and down
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

" quickly open a buffer for scribble
map <leader>qv :vsplit ~/buffer<cr>
map <leader>qs :split ~/buffer<cr>

" quickly open a markdown buffer for scribble
map <leader>xv :vsplit ~/buffer.md<cr>
map <leader>xs :split ~/buffer.md<cr>

" ==============================================================================
" COMMAND REMAPPING
" ==============================================================================

"cmap W w
cmap lw w
"cmap Lw w
"cmap lW w
"cmap LW w


" ==============================================================================
" ABBREVIATIONS
" ==============================================================================

abbreviate note NOTE:
abbreviate todo TODO:

" ==============================================================================
" MISC
" ==============================================================================

" turn on fun colors!
syntax on

" autocomplete (thanks to http://vim.wikia.com/wiki/Autocomplete_with_TAB_when_typing_words for the function)
" function! Tab_Or_Complete()
"   if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
"     return "\<C-N>"
"   else
"     return "\<Tab>"
"   endif
" endfunction
" inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
" inoremap <S-Tab> <C-P>
"
" autocmd QuickFixCmdPost * nested botright copen " open error window when compile from in vim?
" autocmd BufEnter * silent! lcd %:p:h " this will automatically make the current working directory always the local directory of whatever file you're currently editing.

" set 'default file location' to the vim folder in my docs
" cd C:\files\docs\life\vim

" ps1 configuration
au BufNewFile,BufRead *.ps1 setf ps1

" load indent files for automatic language-dependent indenting
filetype plugin indent on

" push gvim window to foreground (sometimes is in back?)
call foreground()

" ==============================================================================
" TESTING GROUNDS
" ==============================================================================


if !exists(":DiffOrig")
	command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
				\ | wincmd p | diffthis
endif
"
" function! Type_completion()
" 	echo "Type completion on"
" 	inoremap <silent> a a<C-n><C-p>
" 	inoremap <silent> b b<C-n><C-p>
" 	inoremap <silent> c c<C-n><C-p>
" 	inoremap <silent> d d<C-n><C-p>
" 	inoremap <silent> e e<C-n><C-p>
" 	inoremap <silent> f f<C-n><C-p>
" 	inoremap <silent> g g<C-n><C-p>
" 	inoremap <silent> h h<C-n><C-p>
" 	inoremap <silent> i i<C-n><C-p>
" 	inoremap <silent> j j<C-n><C-p>
" 	inoremap <silent> k k<C-n><C-p>
" 	inoremap <silent> l l<C-n><C-p>
" 	inoremap <silent> m m<C-n><C-p>
" 	inoremap <silent> n n<C-n><C-p>
" 	inoremap <silent> o o<C-n><C-p>
" 	inoremap <silent> p p<C-n><C-p>
" 	inoremap <silent> q q<C-n><C-p>
" 	inoremap <silent> r r<C-n><C-p>
" 	inoremap <silent> s s<C-n><C-p>
" 	inoremap <silent> t t<C-n><C-p>
" 	inoremap <silent> u u<C-n><C-p>
" 	inoremap <silent> v v<C-n><C-p>
" 	inoremap <silent> w w<C-n><C-p>
" 	inoremap <silent> x x<C-n><C-p>
" 	inoremap <silent> y y<C-n><C-p>
" 	inoremap <silent> z z<C-n><C-p>
"
" endfunction
" function! Type_completion_off()
" 	echo "Type completion off"
" 	inoremap a a
" 	inoremap b b
" 	inoremap c c
" 	inoremap d d
" 	inoremap e e
" 	inoremap f f
" 	inoremap g g
" 	inoremap h h
" 	inoremap i i
" 	inoremap j j
" 	inoremap k k
" 	inoremap l l
" 	inoremap m m
" 	inoremap n n
" 	inoremap o o
" 	inoremap p p
" 	inoremap q q
" 	inoremap r r
" 	inoremap s s
" 	inoremap t t
" 	inoremap u u
" 	inoremap v v
" 	inoremap w w
" 	inoremap x x
" 	inoremap y y
" 	inoremap z z
" endfunction
" nnoremap <leader><tab> :call Type_completion()<cr>
" nnoremap <leader><S-tab> :call Type_completion_off()<cr>
" :silent call Type_completion()

"function! Type_completion_menu_decision(letter)
	""if strpart(getline("."), col('.')
	""call complete(col('.'), getcompletion('', 'user'))
	""let words = split(substitute(join(getline(1, '$'), " "), "[:\(\)\?\\\/\,\.\-]", "","g"), "[\s]")
	"
	"let line = getline('.')
	"let start = col('.')
	"let length = 0
	"while start > 0 && line[start - 1] =~ '\w'
		"let start -= 1
		"let length += 1
	"endwhile
"
	"
	"let words = split(join(getline(1, '$'), " "), '\(\s\|\.\|\:\|\,\)')
	"let cleanedwords = []
	"let part = strpart(getline('.'), start, length)
	"echo part
	"echo length
	"for word in words
		"let cleaned = substitute(word, '[?\(\)]', "", "g")
		"if cleaned =~ "^".part
			"call add(cleanedwords, cleaned)
		"endif
	"endfor
	""echo cleanedwords
	"
	"let things = ['athing1', 'athing2']
	"
	"
	""call complete(col('.'), cleanedwords)
	""call complete(start, cleanedwords)
	""call complete(col('.')-length, cleanedwords)
	"call complete(col('.')-length, cleanedwords)
	"return ''
"endfunction
