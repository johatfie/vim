" An example for a vimrc file.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"          for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"        for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
    finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible


" DRY helpers {{{
let s:running_windows=has("win16") || has("win32") || has("win64")
let s:colorful_term=(&term  =~ "xterm") || (&term  =~ "screen")
" }}}


colorscheme desert

if s:running_windows
    set guifont=Consolas:h11:cANSI
    "set guifont=Monospace:h10:cANSI
endif


set backspace=indent,eol,start " allow backspacing over everything in insert mode
set backup                     " keep a backup file
set history=500                " keep 500 lines of command line history
set ruler                      " show the cursor position all the time
set showcmd                    " display incomplete commands
set incsearch                  " do incremental searching
set cmdheight=2                " The commandbar height
set showmatch                  " Show matching brackets when text indicator is over them
set number                     " show line numbers
set ignorecase
set smartcase
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set wrap                        " Wrap lines
set hidden
set laststatus=2
set completeopt=longest,menuone,preview
set wildmode=longest,list
set virtualedit=block           " block mode, yey (onemore is evil)
set mousehide                   " Hide the mouse cursor while typing
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

"Use Ctrl-L to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>


" Auto center on matched string.
noremap n nzz
noremap N Nzz


if s:running_windows
    behave mswin
else
    behave xterm
endif

runtime bundle/pathogen/autoload/pathogen.vim 
"execute pathogen#infect()
"Helptag " Help for plugins
""silent! call pathogen#helptags()
""silent! call pathogen#runtime_append_all_bundles()

" Use pathogen to easily modify the runtime path to include all plugins under
" the ~/.vim/bundle directory
filetype off                    " force reloading *after* pathogen loaded
call pathogen#infect()
call pathogen#helptags()


" Setting up the directories {
    set backup                          " backups are nice ...

    if s:running_windows
        set backupdir=$HOME/.vim/vimbackup//     " but not when they clog.
        set directory=$HOME/.vim/vimswap//       " Same for swap files
        set viewdir=$HOME/.vim/vimviews//        " same for view files
        set undodir=$HOME/.vim/vimundos//        " Same for undo files
        set viminfo+=n$HOME/.vim/_viminfo
    else
        set backupdir=~/.vim/vimbackup//                              " but not when they clog.
        set directory=~/.vim/vimswap//                                " Same for swap files
        set viewdir=~/.vim/vimviews//                                 " same for view files
        set undodir=~/.vim/vimundo//                                  " Same for undo files
        set viminfo+=n~/.vim/viminfo
    endif

    set viminfo+=! " Store upper-case registers in viminfo

    set undofile
    set undolevels=1000         " persistent undo
    set undoreload=10000        " to undo forced reload with :e!

    function! EnsureDirExists (dir)
        if !isdirectory(a:dir)
            if exists("*mkdir")
                call mkdir(a:dir,'p')
                echo "Created directory: " . a:dir
            else
                echo "Please create directory: " . a:dir
            endif
        endif
    endfunction

    call EnsureDirExists($HOME . '/.vim/vimbackup')
    call EnsureDirExists($HOME . '/.vim/vimswap')
    call EnsureDirExists($HOME . '/.vim/vimviews')
    call EnsureDirExists($HOME . '/.vim/vimundos')

    "" Creating directories if they don't exist
    "if s:running_windows
        "silent execute '!if not exist $HOME\.vim\vimbackup\ ( md %HOME%\.vim\vimbackup\ )'
        "silent execute '!if not exist $HOME\.vim\vimswap\   ( md %HOME%\.vim\vimswap\ )'
        "silent execute '!if not exist $HOME\.vim\vimviews\  ( md %HOME%\.vim\vimviews\ )'
        "silent execute '!if not exist $HOME\.vim\vimundos\  ( md %HOME%\.vim\vimundos\ )'
    "else
        "silent execute '!mkdir -p ~/.vim/vimbackup'
        "silent execute '!mkdir -p ~/.vim/vimswap'
        "silent execute '!mkdir -p ~/.vim/vimviews'
        "silent execute '!mkdir -p ~/.vim/vimundo'
    "endif

    au BufWinLeave * silent! mkview                                 " make vim save view (state) (folds, cursor, etc)
    au BufWinEnter * silent! loadview                               " make vim load view (state) (folds, cursor, etc)
" }

" Vim UI {
    set tabpagemax=50               " only show 50 tabs
    set showmode                    " display the current mode

    set cursorline                  " highlight current line
    hi cursorline guibg=#333333     " highlight bg color of current line
    hi CursorColumn guibg=#333333   " highlight cursor

" }

" Conflict markers {{{
" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nnoremap <silent> <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
" }}}


" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :
nnoremap : ;

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$


nnoremap <leader>l :ls<CR>:b<Space>

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

nnoremap <leader>tp :tabnew +pu
vnoremap <leader>ps  daputs "<ESC>pa: #{ <ESC>pa }"<ESC>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
nnoremap <expr> gV '`['.getregtype(v:register)[0].'`]l'


" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>
inoremap <C-tab> <ESC>:tabnext<CR>i

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>
inoremap <C-S-tab> <ESC>:tabprevious<CR>i

" New Tab
" nnoremap <silent> <C-t> :tabnew<CR>
" inoremap <C-t> <ESC>:tabnew<cr>i

"map <C-w> :tabclose<cr>

" Move tabs back and forth
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

" buffer switching
noremap <C-j> :bprev<CR>
noremap <C-k> :bnext<CR>

""Smart way to move between windows:
"map <C-j> <C-W>j
"map <C-k> <C-W>k
"map <C-h> <C-W>h
"map <C-l> <C-W>l


" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>


set scrolloff=3               " keep at least 3 lines above/below
set sidescrolloff=3           " keep at least 3 lines left/right

noremap <F2> :set rnu!<CR>
noremap <f4>  <ESC>:%s/\(.\{80\}\)\n/\1/g<CR>
noremap <f5>  <ESC>:%s/\(.\{100\}\)\n/\1/g<CR>

" This is the way I like my quotation marks and various braces
inoremap '' ''<Left>
inoremap "" ""<Left>
inoremap <> <><Left>
inoremap // //<Left>
inoremap {} {  }<Left><Left>
inoremap [] [  ]<Left><Left>
inoremap () (  )<Left><Left>
"inoremap {} {}<Left>
"inoremap [] []<Left>
"inoremap () ()<Left>
inoremap %% %  %<Left><Left><Left>
inoremap `` `  `<Left><Left>


" Always open help in a new tab
if has("gui_running")
    cabbrev help tab help
endif


" Mapping for executing current line as vim command
nnoremap <leader>x Y:<C-R>"<C-H><CR>

" map http://kb.perforce.com/article/11/checking-out-a-file-from-vi
noremap  :!p4 edit "%":set noro


" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    syntax sync minlines=100 " helps to avoid syntax highlighting bugs
    set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on
    runtime macros/matchit.vim


    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 100 characters.
    autocmd FileType text setlocal textwidth=100

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
                \ if line("'\"") > 1 && line("'\"") <= line("$") |
                \   exe "normal! g`\"" |
                \ endif

    augroup END

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
    command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                \ | wincmd p | diffthis
endif


" Source Explorer {
    " // The switch of the Source Explorer
    nnoremap <F7> :SrcExplToggle<CR>

    " // Set the height of Source Explorer window
    let g:SrcExpl_winHeight = 8

    " // Set 100 ms for refreshing the Source Explorer
    let g:SrcExpl_refreshTime = 4000

    " // Set "Enter" key to jump into the exact definition context
    " let g:SrcExpl_jumpKey = "<ENTER>"

    " // Set "Space" key for back from the definition context
    let g:SrcExpl_gobackKey = "<SPACE>"

    " // In order to Avoid conflicts, the Source Explorer should know what plugins
    " // are using buffers. And you need add their bufname into the list below
    " // according to the command ":buffers!"
    let g:SrcExpl_pluginList = [
            \ "__Tag_List__",
            \ "__Tagbar__",
            \ "_NERD_tree_",
            \ "Source_Explorer",
            \ "__Gundo__",
            \ "__Gundo_Preview__"
        \ ]

    " // Enable/Disable the local definition searching, and note that this is not
    " // guaranteed to work, the Source Explorer doesn't check the syntax for now.
    " // It only searches for a match with the keyword according to command 'gd'
    let g:SrcExpl_searchLocalDef = 1

    " // Do not let the Source Explorer update the tags file when opening
    let g:SrcExpl_isUpdateTags = 0

    " // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
    " //  create/update a tags file
    let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

    " // Set "<F12>" key for updating the tags file artificially
    let g:SrcExpl_updateTagsKey = "<F12>"
" }


if s:running_windows
    au FileType xhtml,xml,html,xaml,erb so "C:/Program Files (x86)/Vim/vimfiles/bundle/html_autoCloseTag/plugin/html_autoclosetag.vim"
else
    au FileType xhtml,xml,html,xaml,erb so "~/.vim/bundle/html_autoCloseTag/plugin/html_autoclosetag.vim"
endif


" MRU {

    if s:running_windows
        "let MRU_File = '$HOME/.vim/_vim_mru_files'
    else
        "let MRU_File = '~/.vim/vim_mru_files'
        "let MRU_File = '~/vim_mru_files'
    endif

    let MRU_Max_Entries = 1000
    let MRU_Max_Menu_Entries = 100
    let MRU_Max_Submenu_Entries = 25

    if s:running_windows
        let MRU_Exclude_Files = '.*\.tmp$\|.*\\Temp\\.*\|.*\\Temporary Internet Files\\.*'
    else
        let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
    endif
" }


" Arrow keys are NOT for moving around
nnoremap <down> <C-f>
nnoremap <up> <C-b>
nnoremap <left> :NERDTreeToggle<cr>
nnoremap <right> :TagbarToggle<cr>
nnoremap <C-down> :cnext<cr>zvzz
nnoremap <C-up> :cprev<cr>zvzz
nnoremap <S-down> :lnext<cr>zvzz
nnoremap <S-up> :lprev<cr>zvzz
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
"vnoremap y "+y

set sessionoptions=buffers,curdir,folds,globals,help,options,localoptions,resize,slash,tabpages,winpos,winsize
let g:outlook_use_tabs = 1
let g:outlook_servername = 'GVIM'



if s:running_windows
    let g:yankring_history_dir = '$HOME/.vim'
else
    let g:yankring_history_dir = '~/.vim/'
endif


nnoremap <F6> :GundoToggle<CR>
nnoremap <F8> :TagbarToggle<CR>
nnoremap <F11>  :NERDTreeToggle<CR>


let g:indent_guides_enable_on_vim_startup = 1
let g:MRU_num = 12

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }

" Use local gvimrc if available and gui is running {
    if has('gui_running')
        if filereadable(expand("~/.gvimrc.local"))
            source ~/.gvimrc.local
        endif
    endif
" }

" Fugitive {{{
    "if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        " Mnemonic _i_nteractive
        nnoremap <silent> <leader>gi :Git add -p %<CR>
        nnoremap <silent> <leader>gg :SignifyToggle<CR>
    "endif
" }}}


