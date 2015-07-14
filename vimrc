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

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

colorscheme desert

if has('win32') || has('win64')
    set guifont=Consolas:h11:cANSI
    "set guifont=Monospace:h10:cANSI
endif

if has("vms")
    set nobackup      " do not keep a backup file, use versions instead
else
    set backup        " keep a backup file
endif

set history=500     " keep 500 lines of command line history
set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch       " do incremental searching
set cmdheight=2     " The commandbar height
set showmatch       " Show matching brackets when text indicator is over them
set number          " show line numbers
set ignorecase
set smartcase
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent
set wrap            " Wrap lines
set hidden


if has('win32') || has('win64')
    " source $VIMRUNTIME/mswin.vim
    behave mswin
else
    behave xterm
endif

"execute pathogen#infect()
runtime! autoload/pathogen.vim
silent! call pathogen#helptags()
silent! call pathogen#runtime_append_all_bundles()

runtime! autoload/MRU.vim

" Setting up the directories {
    set backup                          " backups are nice ...

    if has('win32') || has('win64')
        set backupdir=C:/Users/Jon.Hatfield/Documents/vimbackup//     " but not when they clog.
        set directory=C:/Users/Jon.Hatfield/Documents/vimswap//       " Same for swap files
        set viewdir=C:/Users/Jon.Hatfield/Documents/vimviews//        " same for view files
        set undodir=C:/Users/Jon.Hatfield/Documents/vimundos//        " Same for undo files
        set viminfo+=nC:/Users/Jon.Hatfield/Documents/_viminfo
    else
        set backupdir=~/.vim/vimbackup//                              " but not when they clog.
        set directory=~/.vim/vimswap//                                " Same for swap files
        set viewdir=~/.vim/vimviews//                                 " same for view files
        set undodir=~/.vim/vimundo//                                  " Same for undo files
        set viminfo+=n~/.vim/viminfo
    endif


    set undofile

    " Creating directories if they don't exist
    if has('win32') || has('win64')
        silent execute '!if not exist C:\Users\Jon.Hatfield\Documents\vimbackup\ ( md C:\Users\Jon.Hatfield\Documents\vimbackup\ )'
        silent execute '!if not exist C:\Users\Jon.Hatfield\Documents\vimswap\ ( md C:\Users\Jon.Hatfield\Documents\vimswap\ )'
        silent execute '!if not exist C:\Users\Jon.Hatfield\Documents\vimviews\ ( md C:\Users\Jon.Hatfield\Documents\vimviews\ )'
        silent execute '!if not exist C:\Users\Jon.Hatfield\Documents\vimundos\ ( md C:\Users\Jon.Hatfield\Documents\vimundos\ )'
    else
        silent execute '!mkdir -p ~/.vim/vimbackup'
        silent execute '!mkdir -p ~/.vim/vimswap'
        silent execute '!mkdir -p ~/.vim/vimviews'
        silent execute '!mkdir -p ~/.vim/vimundo'
    endif

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


" Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
nnoremap ; :
nnoremap : ;

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

nnoremap <leader>l :ls<CR>:b

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

nnoremap <leader>tp :tabnew +pu
vnoremap <leader>ps  daputs "<ESC>pa: #{ <ESC>pa }"<ESC>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Next Tab
nnoremap <silent> <C-Right> :tabnext<CR>

" Previous Tab
nnoremap <silent> <C-Left> :tabprevious<CR>

" New Tab
" nnoremap <silent> <C-t> :tabnew<CR>

" Move tabs back and forth
nnoremap <silent> <A-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <A-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>


" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>


set scrolloff=5               " keep at least 5 lines above/below
set sidescrolloff=5           " keep at least 5 lines left/right

map <F2> ;set rnu!<CR>
"map! <F2> <Esc>;w<CR>
map <f4>  <ESC>;%s/\(.\{80\}\)\n/\1/g<CR>
map <f5>  <ESC>;%s/\(.\{100\}\)\n/\1/g<CR>

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

map <C-j> ;bprev<CR>
map <C-k> ;bnext<CR>

" TAB navigation like firefox
:nmap <C-S-tab> ;tabprevious<cr>
:nmap <C-tab> ;tabnext<cr>
:imap <C-S-tab> <ESC>;tabprevious<cr>i
:imap <C-tab> <ESC>;tabnext<cr>i
":nmap <C-t> :tabnew<cr>
":imap <C-t> <ESC>:tabnew<cr>i
":map <C-w> :tabclose<cr>


" Always open help in a new tab
:cabbrev help tab help


" Mapping for executing current line as vim command
nmap <leader>x Y;<C-R>"<C-H><CR>

map  :!p4 edit "%":set noro


" map http://kb.perforce.com/article/11/checking-out-a-file-from-vi
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
    " set hlsearch
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

else
    set autoindent        " always set autoindenting on
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
    nmap <F7> ;SrcExplToggle<CR>

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
            \ "_NERD_tree_",
            \ "Source_Explorer"
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


if has('win32') || has('win64')
    au FileType xhtml,xml,html,xaml,erb so "C:/Program Files (x86)/Vim/vimfiles/bundle/html_autoCloseTag/plugin/html_autoclosetag.vim"
else
    au FileType xhtml,xml,html,xaml,erb so "~/.vim/bundle/html_autoCloseTag/plugin/html_autoclosetag.vim"
endif


" MRU {

    if has('win32') || has('win64')
        let MRU_File = 'c:/users/jon.hatfield/documents/_vim_mru_files'
    else
        "let MRU_File = '~/.vim/vim_mru_files'
        "let MRU_File = '~/vim_mru_files'
    endif

    let MRU_Max_Entries = 1000
    let MRU_Max_Menu_Entries = 100
    let MRU_Max_Submenu_Entries = 25

    if has('win32') || has('win64')
        let MRU_Exclude_Files = '.*\.tmp$\|.*\\Temp\\.*\|.*\\Temporary Internet Files\\.*'
    else
        let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
    endif
" }

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" inoremap <up> <nop>
" inoremap <down> <nop>
" inoremap <left> <nop>
" inoremap <right> <nop>
nnoremap j gj
nnoremap k gk
vnoremap y "+y

set sessionoptions=buffers,curdir,folds,globals,help,options,localoptions,resize,slash,tabpages,winpos,winsize
let g:outlook_use_tabs = 1
let g:outlook_servername = 'GVIM'



if has('win32') || has('win64')
    let g:yankring_history_dir = 'c:/users/Jon.Hatfield/Documents'
else
    let g:yankring_history_dir = '~/.vim/'
endif


nnoremap <F6> :GundoToggle<CR>

"" Open and close all the three plugins on the same time
"nmap <F8>   ;TrinityToggleAll<CR>

"" Open and close the srcexpl.vim separately
"nmap <F9>   ;TrinityToggleSourceExplorer<CR>

"" Open and close the taglist.vim separately
"nmap <F10>  ;TrinityToggleTagList<CR>

"" Open and close the NERD_tree.vim separately
""nmap <F11>  ;TrinityToggleNERDTree<CR>
nmap <F11>  ;NERDTreeToggle<CR>

let g:MRU_num = 12

