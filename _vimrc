set nocompatible " use vim settings, instead of vi settings
behave mswin " set selection selectmode and other stuff for windows

" ==============================================================================
" PLUGIN HANDLING
" ==============================================================================

" matchit plugin makes % work a bit better
packadd matchit

set rtp+=/vim/vim74/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Plugin 'scrooloose/nerdtree'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'shougo/neocomplete.vim'
Plugin 'SirVer/ultisnips'
Plugin 'majutshushi/tagbar'
call vundle#end()

" ---- NERDTree settings ----
" let g:NERDTreeShowBookmarks=1
" if only NERDTree buffer is open, close window
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" nnoremap <S-SPACE> :NERDTree<CR>

" ---- easytags settings ----
let g:easytags_auto_highlight=0
let g:easytags_auto_update=0 
let g:easytags_include_members=1
let g:easytags_supress_report=1
let g:easytags_dynamic_files=1

" ---- neocomplete settings ----
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_auto_select = 1
let g:neocomplete#auto_completion_start_length = 0 
if !exists('g:neocomplete#sources')
  let g:neocomplete#sources = {}
endif
let g:neocomplete#sources._ = ['tag', 'buffer']
"let g:neocomplete#sources.cpp = ['buffer', 'dictionary']

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" complete suggestion with shift space 
" inoremap <expr><S-Space> pumvisible() ? "\<C-y><Space>" : "\<Space>"

" do thing so that enter doesn't go down to confirm an autocomplete 
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " for not inserting <CR> key.
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" ---- UltiSnips settings ----
let g:UltiSnipsUsePythonVersion = 2
let g:UltiSnipsEditSplit = "vertical"
let g:UltiSnipsSnippetsDir="/dwl/lab/Snippets" " where snippets are saved
let g:UltiSnipsSnippetDirectories=["/dwl/lab/Snippets"] " where snippets are searched for TODO: just add the library directory here, so you can use both quickly created ones as well as the common library
let g:UltiSnipsExpandTrigger="<C-SPACE>"
let g:UltiSnipsJumpForwardTrigger="<TAB>"
let g:UltiSnipsJumpBackwardTrigger="<S-TAB>"
let g:UltiSnipsListSnippets="<C-e>"
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<C-R>=UltiSnips#ExpandSnippet()"

" ---- Tagbar settings ----
"nmap <silent> <leader>t :TagbarToggle<CR>

" ==============================================================================
" GUI SPECIFIC STUFF
" ==============================================================================

if has('gui_running')
	set guifont=Consolas:h10
	" colorscheme solarized
	colorscheme jellybeans
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

" folding
set foldenable
set foldlevelstart=0 " start with all folds folded
"set foldmethod=syntax " commented out because of neocomplete (slows down?)
"set foldmethod=2 " adds a fold column
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo " specifies which commands will auto-unfold a section

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
set formatoptions+=c " auto-wrap comments using text width and auto insert comment leader
set formatoptions+=j " be all smart and when joing a comment line, take out the extra comment leader 
set formatoptions+=q " allow formatting of comments with 'gq'
set formatoptions+=r " automatically insert comment  leader after hitting enter in insert mode
set backspace=indent,eol,start whichwrap+=<,>,[,] " backspace and cursor keys wrap to previous/next line

" directories
set backupdir=C:\dwl\tmp\bak
set directory=C:\dwl\tmp\swp
set undodir=C:\dwl\tmp\undo
set tags=./.tags;,~/.tags
set makeprg=build.bat

" misc
set hidden " allows switching buffers while still having unsaved changes in prev buffer
"set omnifunc=syntaxcomplete#Complete " I still have no idea what this does...
set lazyredraw " reduce flickering
set cryptmethod=blowfish2

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
map <C-V> "+gP
cmap <C-V> <C-R>+

" normally CTRL-V is the column select, but change it to ctrl-q
noremap <C-Q> <C-V>

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
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" shortcuts to move back and forth in buffers 
nnoremap <F2> :bprevious<CR>
nnoremap <F3> :bnext<CR>

" compile shortcuts 
nnoremap <F5> :make<CR>
inoremap <F5> <ESC>:make<CR>

" fix broken CTRL-A increment number shortcut to CTRL-I
nnoremap <C-I> <C-A>

" leader shortcuts!
nnoremap <LEADER><SPACE> :nohlsearch<CR>

"automatically add braces!
"inoremap <C-[> <CR>{<CR>}<Esc>O<tab>
inoremap <C-[> <CR>{<CR>}<Esc>O

" ==============================================================================
" COMMAND REMAPPING
" ==============================================================================
cmap W w
cmap lw w
cmap Lw w
cmap lW w
cmap LW w

" ==============================================================================
" MISC
" ==============================================================================

" turn on fun colors!
syntax on

" autocomplete (thanks to http://vim.wikia.com/wiki/Autocomplete_with_TAB_when_typing_words for the function)
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
:inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
:inoremap <S-Tab> <C-P>

autocmd QuickFixCmdPost * nested botright copen " open error window when compile from in vim?
autocmd BufEnter * silent! lcd %:p:h " this will automatically make the current working directory always the local directory of whatever file you're currently editing.

" set 'default file location' to the vim folder in my docs
cd C:\files\docs\life\vim

" ps1 configuration
au BufNewFile,BufRead *.ps1 setf ps1

" load indent files for automatic language-dependent indenting
filetype plugin indent on 

" push gvim window to foreground (sometimes is in back?)
call foreground()
