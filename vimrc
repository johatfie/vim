
" Author: Jon Hatfield
" Last Modified: Thu Jul 06, 2017  11:36AM

" evim {{{

    " When started as "evim", evim.vim will already have done these settings.
    if v:progname =~? "evim"
        finish
    endif

" }}}

" VI Compatible {{{

    " Use Vim settings, rather than Vi settings (much better!).
    " This must be first, because it changes other options as a side effect.
    set nocompatible

" }}}

" DRY Helpers {{{

    let s:running_windows = has("win16") || has("win32") || has("win64")
    let s:running_unix    = has("unix")
    let s:running_mac     = system("uname") == "Darwin\n" "&& !s:running_unix
    let s:colorful_term   = (&term =~ "xterm") || (&term =~ "screen")

" }}}

" Colors {{{
"
    colorscheme desert

" }}}

" Font {{{

    if s:running_windows
        set guifont=Consolas:h11:cANSI
        "set guifont=Monospace:h10:cANSI
    elseif s:running_mac
        set guifont=Inconsolata\ for\ Powerline:h13
    elseif s:running_unix
        set guifont=DejaVu\ Sans\ Mono\ for\ Powerline
    endif

" }}}

" Settings {{{

    set backspace=indent,eol,start " allow backspacing over everything in insert mode
    set backup                     " keep a backup file
    set history=500                " keep 500 lines of command line history
    set ruler                      " show the cursor position all the time
    set showcmd                    " display incomplete commands
    set incsearch                  " do incremental searching
    set cmdheight=2                " The commandbar height
    set showmatch                  " Show matching brackets when text indicator is over them  [{()}]
    set number                     " show line numbers
    set ignorecase
    set smartcase
    set shiftwidth=4
    set tabstop=4                   " number of visual spaces per TAB
    set softtabstop=4               " number of spaces in tab when editing
    set expandtab                   " tabs are spaces
    set autoindent
    set smartindent
    set wrap                        " Wrap lines
    set hidden
    set laststatus=2
    set completeopt=longest,menuone,preview
    set virtualedit=block           " block mode, yey (onemore is evil)
    set mousehide                   " Hide the mouse cursor while typing
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set scrolloff=3                 " keep at least 3 lines above/below
    set sidescrolloff=3             " keep at least 3 lines left/right
    set autoread                    " Automatically reload changed file
    set autochdir                   " Automatically cd to directory of open file

    set sessionoptions=buffers,curdir,folds,globals,help,options,localoptions,resize,slash,tabpages,winpos,winsize

    " In many terminal emulators the mouse works just fine, thus enable it.
    if has('mouse')
        set mouse=a
    endif

    if v:version > 703 || v:version == 703 && has("patch541")
        set formatoptions+=j
    endif

" }}}

" Tags {{{
    " search first in current directory then file directory for tag file
    set tags=tags,./tags;
" }}}

" Wildmenu {{{

    if has("wildmenu")
        set wildignore+=*.a,*.o
        set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
        set wildignore+=.DS_Store,.git,.hg,.svn
        set wildignore+=*~,*.swp,*.tmp
        set wildignore+=cscope.out,tags
        set wildmenu
        "set wildmode=longest,list:longest
        set wildmode=longest:list,full
    endif

" }}}

" Behavior {{{

    if s:running_windows
        behave mswin
    else
        behave xterm
    endif

" }}}

" Pathogen {{{

    " To disable a plugin, add it's bundle name to the following list
    if !exists('pathogen_disabled')
        let g:pathogen_disabled = []
    endif

    call add(g:pathogen_disabled, 'vim-easytags')
    "call add(g:pathogen_disabled, 'vim-bufkill')
    "call add(g:pathogen_disabled, '')
    "call add(g:pathogen_disabled, '')
    "call add(g:pathogen_disabled, 'a.vim')
    "call add(g:pathogen_disabled, 'abolish.vim')
    "call add(g:pathogen_disabled, 'ack.vim')
    "call add(g:pathogen_disabled, 'bash-suppport.vim')
    "call add(g:pathogen_disabled, 'bufexplorer')
    "call add(g:pathogen_disabled, 'CamelCaseMotion')
    "call add(g:pathogen_disabled, 'checksyntax_vim')
    "call add(g:pathogen_disabled, 'colour-sampler-pack')
    "call add(g:pathogen_disabled, 'cscope-menu')
    "call add(g:pathogen_disabled, 'darkerdesert')
    "call add(g:pathogen_disabled, 'endwise.vim')
    "call add(g:pathogen_disabled, 'eunuch.vim')
    ""call add(g:pathogen_disabled, 'fugitive.vim')
    "call add(g:pathogen_disabled, 'gem-shut-the-fudge-up')
    "call add(g:pathogen_disabled, 'gitgutter.vim')
    "call add(g:pathogen_disabled, 'gundo')
    "call add(g:pathogen_disabled, 'HTML-AutoCloseTag')
    "call add(g:pathogen_disabled, 'matchit')
    "call add(g:pathogen_disabled, 'mru')
    "call add(g:pathogen_disabled, 'MRU.vim')
    "call add(g:pathogen_disabled, 'nerdcommenter')
    "call add(g:pathogen_disabled, 'nerdtree')
    "call add(g:pathogen_disabled, 'obsession.vim')
    ""call add(g:pathogen_disabled, 'pathogen')
    "call add(g:pathogen_disabled, 'rails.vim')
    "call add(g:pathogen_disabled, 'rake.vim')
    "call add(g:pathogen_disabled, 'recover.vim')
    "call add(g:pathogen_disabled, 'refactor-rails')
    "call add(g:pathogen_disabled, 'repeat.vim')
    "call add(g:pathogen_disabled, 'scratch.vim')
    "call add(g:pathogen_disabled, 'scrollcolors')
    "call add(g:pathogen_disabled, 'splitjoin.vim')
    "call add(g:pathogen_disabled, 'SrcExpl')
    "call add(g:pathogen_disabled, 'surround.vim')
    "call add(g:pathogen_disabled, 'switch.vim')
    "call add(g:pathogen_disabled, 'syntastic')
    "call add(g:pathogen_disabled, 'tab-menu')
    "call add(g:pathogen_disabled, 'tab-name')
    "call add(g:pathogen_disabled, 'tabular')
    "call add(g:pathogen_disabled, 'tagbar')
    "call add(g:pathogen_disabled, 'vim-airline')
    "call add(g:pathogen_disabled, 'vim-better-whitespace')
    "call add(g:pathogen_disabled, 'vim-bufkill')
    "call add(g:pathogen_disabled, 'vim-dispatch')
    "call add(g:pathogen_disabled, 'vim-easytags')
    "call add(g:pathogen_disabled, 'vim-gutentags')
    "call add(g:pathogen_disabled, 'vim-indent-guides')
    "call add(g:pathogen_disabled, 'vim-ir_black')
    call add(g:pathogen_disabled, 'vim-misc')
    "call add(g:pathogen_disabled, 'vim-ps1')
    call add(g:pathogen_disabled, 'vim-ruby')
    "call add(g:pathogen_disabled, 'vim-showmarks')
    "call add(g:pathogen_disabled, 'vim-speeddating')
    "call add(g:pathogen_disabled, 'vim-textobj-user')
    "call add(g:pathogen_disabled, 'VimBookmarking')
    "call add(g:pathogen_disabled, 'vimp4python')
    "call add(g:pathogen_disabled, 'yankring.vim')

    "" for some reason the csscolor plugin is very slow when run on the terminal
    "" but not in GVim, so disable it if no GUI is running
    "if !has('gui_running')
        "call add(g:pathogen_disabled, 'csscolor')
    "endif

    " Gundo requires at least vim 7.3
    if v:version < '703' || !has('python3')
        call add(g:pathogen_disabled, 'gundo')
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

" }}}

" Setting up the Directories {{{

    "set viminfo='1000,f1,<500,!        " Store upper-case registers in viminfo
    set viminfo='1000,f1,<500
    set backup                          " backups are nice ...


    if s:running_windows
        set backupdir=$USERPROFILE/.vim/vimbackup//     " but not when they clog.
        set directory=$USERPROFILE/.vim/vimswap//       " Same for swap files
        set viewdir=$USERPROFILE/.vim/vimviews//        " same for view files
        set undodir=$USERPROFILE/.vim/vimundos//        " Same for undo files
        set viminfo+=n$USERPROFILE/.vim/_viminfo
    else
        set backupdir=~/.vim/vimbackup//         " but not when they clog.
        set directory=~/.vim/vimswap//           " same for swap files
        set viewdir=~/.vim/vimviews//            " same for view files
        set undodir=~/.vim/vimundo//             " same for undo files
        set viminfo+=n~/.vim/viminfo
    endif

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

    "call EnsureDirExists($USERPROFILE . '/.vim/vimbackup')
    "call EnsureDirExists($USERPROFILE . '/.vim/vimswap')
    "call EnsureDirExists($USERPROFILE . '/.vim/vimviews')
    "call EnsureDirExists($USERPROFILE . '/.vim/vimundos')

    call EnsureDirExists( &backupdir )   "      $USERPROFILE . '/.vim/vimbackup')
    call EnsureDirExists( &directory )   "      $USERPROFILE . '/.vim/vimswap')
    call EnsureDirExists( &viewdir   )   "      $USERPROFILE . '/.vim/vimviews')
    call EnsureDirExists( &undodir   )   "      $USERPROFILE . '/.vim/vimundos')

" }}}

" Vim UI {{{

    set tabpagemax=50               " only show 50 tabs
    set showmode                    " display the current mode

    set cursorline                  " highlight current line
    hi cursorline guibg=#333333     " highlight bg color of current line
    hi CursorColumn guibg=#333333   " highlight cursor


    " http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
    " The below mapping will change the behavior of the <Enter> key when the popup menu is visible.
    " In that case the Enter key will simply select the highlighted menu item, just as <C-Y> does.
    inoremap <expr> <C-CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

    " These two mappings further improve the completion popup menu:
    " In the below mappings, the first will make <C-N> work the way it normally does;
    " however, when the menu appears, the <Down> key will be simulated. What this accomplishes is
    " it keeps a menu item always highlighted. This way you can keep typing characters to narrow the
    " matches, and the nearest match will be selected so that you can hit Enter at any time to insert it.
    " In the below mappings, the second one is a little more exotic: it simulates <C-X><C-O> to bring up
    " the omni completion menu, then it simulates <C-N><C-P> to remove the longest common text, and
    " finally it simulates <Down> again to keep a match highlighted.

    inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
      \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

    inoremap <expr> <M-,> pumvisible() ? '<C-n>' :
      \ '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'


    "Here is a hacky example of a set of mappings that first close any popups that are open which
    "means you can seamlessly switch between omni and user completions. Then they try the omni or user
    "complete function. If the menu is visible they use the above trick to keep the text you typed
    "and select the first.

    " open omni completion menu closing previous if open and opening new menu without changing the text
    inoremap <expr> <C-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
                \ '<C-x><C-o><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'
    " open user completion menu closing previous if open and opening new menu without changing the text
    inoremap <expr> <S-Space> (pumvisible() ? (col('.') > 1 ? '<Esc>i<Right>' : '<Esc>i') : '') .
                \ '<C-x><C-u><C-r>=pumvisible() ? "\<lt>C-n>\<lt>C-p>\<lt>Down>" : ""<CR>'

" }}}

" Conflict Markers {{{

    " highlight conflict markers
    match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

    " shortcut to jump to next conflict marker
    nnoremap <silent> <leader>C /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>
    "nnoremap <silent> <leader>c /^\(<\|=\|>\)\{7\}\([^=].\+\)\?$<CR>
    "nnoremap  <leader>c /^\(<\|=\|>\)\{7\}\([^=].\+\)\?$<CR>
    "match ErrorMsg      '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'
    "nnoremap  <leader>c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$
    "<CR>

" }}}

" Searching {{{

    "Use Ctrl-L to clear the highlighting of :set hlsearch.
    nnoremap <silent> <C-L> :nohlsearch<CR>

    " Auto center on matched string.
    noremap n nzz
    noremap N Nzz

" }}}

" Vim Tabs {{{

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

" }}}

" Vim Buffers {{{

    " buffer switching
    noremap <C-j> :bprev<CR>
    noremap <C-k> :bnext<CR>

    nnoremap <leader>l :ls<CR>:b<Space>

" }}}

" Vim Windows {{{
    ""Smart way to move between windows:
    "map <C-j> <C-W>j
    "map <C-k> <C-W>k
    "map <C-h> <C-W>h
    "map <C-l> <C-W>l
" }}}

" Braces and Quotes {{{

    " This is the way I like my quotation marks and various braces
    inoremap '' ''<Left>
    inoremap "" ""<Left>
    inoremap <> <><Left>
    inoremap // //<Left>
    inoremap {} {  }<Left><Left>
    inoremap [] []<Left>
    inoremap () ()<Left>
    "inoremap {} {}<Left>
    "inoremap [] []<Left>
    "inoremap () ()<Left>
    inoremap %% %%<Left>
    inoremap `` ``<Left>

    cnoremap '' ''<Left>
    cnoremap "" ""<Left>
    cnoremap <> <><Left>
    cnoremap // //<Left>
    cnoremap {} {}<Left>
    cnoremap [] []<Left>
    cnoremap () ()<Left>

" }}}

" Syntax Highlighting {{{

    " Switch syntax highlighting on, when the terminal has colors
    " Also switch on highlighting the last used search pattern.
    if &t_Co > 2 || has("gui_running")
        syntax on
        syntax sync minlines=100 " helps to avoid syntax highlighting bugs
        set hlsearch
    endif

" }}}

" Autocommands {{{

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

        autocmd FileType c,h,cpp setlocal foldmethod=syntax

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

        " If buffer modified, update any 'Last modified: ' in the first 20 lines.
        " 'Last modified: ' can have up to 10 characters before (they are retained).
        " Restores cursor and window position using save_cursor variable.
        function! LastModified()
            if &modified
                let save_cursor = getpos(".")
                let n = min([20, line("$")])
                keepjumps exe '1,' . n . 's#^\(.\{,10}Last Modified: \).*#\1' .
                            \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
                call histdel('search', -1)
                call setpos('.', save_cursor)
            endif
        endfun

        autocmd BufWritePre * call LastModified()

        if s:running_windows
            au FileType xhtml,xml,html,xaml,erb exec "source " . expand("%:p:h") . "/vimfiles/bundle/html_autoCloseTag/plugin/html_autoclosetag.vim"
        else
            au FileType xhtml,xml,html,xaml,erb source "~/.vim/bundle/html_autoCloseTag/plugin/html_autoclosetag.vim"
        endif

        au BufWinLeave * silent! mkview             " make vim save view (state) (folds, cursor, etc)
        au BufWinEnter * silent! loadview           " make vim load view (state) (folds, cursor, etc)

        autocmd BufEnter * silent! lcd %:p:h        " change local current directory to the directory of the current file

        autocmd Filetype ruby setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

        "execute the current line, then re-open the command window at the same line
        "autocmd CmdwinEnter * nnoremap <buffer> <F5> <CR>q:
        autocmd CmdwinEnter * nnoremap <buffer> <F5> :let g:CmdWindowLineMark=line(".")<CR>

    endif " has("autocmd")

" }}}

" Cscope {{{

    if has('cscope')
        "set cscopetag cscopeverbose

        if has('quickfix')
            set cscopequickfix=s-,c-,d-,i-,t-,e-
        endif

        "cnoreabbrev csa cs add
        "cnoreabbrev csf cs find
        "cnoreabbrev csk cs kill
        "cnoreabbrev csr cs reset
        "cnoreabbrev css cs show
        "cnoreabbrev csh cs help

        cnoreabbrev <expr> csa
                    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs add'  : 'csa')
        cnoreabbrev <expr> csf
                    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs find' : 'csf')
        cnoreabbrev <expr> csk
                    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs kill' : 'csk')
        cnoreabbrev <expr> csr
                    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs reset' : 'csr')
        cnoreabbrev <expr> css
                    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs show' : 'css')
        cnoreabbrev <expr> csh
                    \ ((getcmdtype() == ':' && getcmdpos() <= 4)? 'cs help' : 'csh')
    endif

"}}}

" Fugitive {{{

    if isdirectory(expand("%:p:h") . '/vimfiles/bundle/fugitive.vim/')
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
    endif

" }}}

" MRU {{{

    if s:running_windows
        let MRU_File = expand($USERPROFILE . "/.vim/_vim_mru_files")
        let MRU_Exclude_Files = '.*\.tmp$\|.*\\Temp\\.*\|.*\\Temporary Internet Files\\.*'
    else
        "let MRU_File = '~/.vim/vim_mru_files'
        "let MRU_File = '~/vim_mru_files'
        let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
    endif

    let MRU_Max_Entries = 1000
    let MRU_Max_Menu_Entries = 200
    let MRU_Max_Submenu_Entries = 25

" }}}

" Source Explorer {{{

    " // The switch of the Source Explorer
    nnoremap <F7> :SrcExplToggle<CR>

    " // Set the height of Source Explorer window
    let g:SrcExpl_winHeight = 8

    " // Set 100 ms for refreshing the Source Explorer
    let g:SrcExpl_refreshTime = 4000

    " // Set "Enter" key to jump into the exact definition context
    let g:SrcExpl_jumpKey = "<ENTER>"

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

" }}}

" Arrow Keys {{{

    " Arrow keys are NOT for moving around
    nnoremap <down> <C-f>
    nnoremap <up> <C-b>
    nnoremap <S-left> :NERDTreeFind<cr>
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

" }}}

" Yankring {{{

    if s:running_windows
        let g:yankring_history_dir = expand($USERPROFILE . '/.vim')
    else
        let g:yankring_history_dir = '~/.vim/'
    endif

" }}}

" Function Key Mappings {{{

    noremap <F2> :set rnu!<CR>
    noremap <f3>  <ESC>:%s/\(.\{80\}\)\n/\1/g<CR>
    noremap <f4>  <ESC>:%s/\(.\{100\}\)\n/\1/g<CR>
    nnoremap <F6>  :GundoToggle<CR>
    nnoremap <F8>  :TagbarToggle<CR>
    nnoremap <F11> :NERDTreeToggle<CR>

" }}}

" Variables {{{

    let g:outlook_use_tabs = 1
    let g:outlook_servername = 'GVIM'

    let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''$'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])
    let g:gutentags_define_advanced_commands = 0
    let g:gutentags_trace = 0
    let g:indent_guides_enable_on_vim_startup = 1
    "let g:gutentags_modules = ['ctags', 'cscope']
    let g:MRU_num = 12
    "let g:MRU = expand("~/.vim/_vimrecent")

    if s:running_mac || s:running_unix
        " powerline symbols
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
        let g:airline_symbols.readonly = ''
        let g:airline_symbols.linenr = ''
    end

" }}}

" Local vimrc {{{

    if s:running_windows
        let g:local_vimrc  = expand($USERPROFILE . "/.vim/vimrc.local")
        let g:local_gvimrc = expand($USERPROFILE . "/.vim/gvimrc.local")
        let g:hostfile     = expand($USERPROFILE . "/.vim/vimrc-" . hostname())
    else
        let g:local_vimrc  = expand("~/.vimrc.local")
        let g:local_gvimrc = expand("~/.gvimrc.local")
        let g:hostfile     = expand("~/.vimrc-" . hostname())
    endif

"echo local_vimrc
"echo g:local_vimrc

    " Use local vimrc if available {{{
        if filereadable(g:local_vimrc)
            "source g:local_vimrc
        endif
    " }}}

    " Use local gvimrc if available and gui is running {{{
        if has('gui_running')
            if filereadable(local_gvimrc)
                source local_gvimrc
            endif
        endif
    " }}}

    if filereadable(hostfile)
        exe 'source ' . hostfile
    endif

" }}}

" Maps {{{

    " Making it so ; works like : for commands. Saves typing and eliminates :W style typos due to lazy holding shift.
    nnoremap ; :
    nnoremap : ;

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$


    " This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
    inoremap jj <Esc>

    nnoremap <leader>tp :tabnew +pu
    vnoremap <leader>ps  daputs "<ESC>pa: #{ <ESC>pa }"<ESC>
    cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
    nnoremap <expr> gV '`['.getregtype(v:register)[0].'`]l'

    " Create Blank Newlines and stay in Normal mode
    nnoremap <silent> zj o<Esc>
    nnoremap <silent> zk O<Esc>

    nnoremap <silent> zJ zj
    nnoremap <silent> zK zk


    " Always open help in a new tab
    if has("gui_running")
        cabbrev help tab help
    endif


    " Mapping for executing current line as vim command
    nnoremap <leader>x Y:<C-R>"<C-H><CR>

    " map http://kb.perforce.com/article/11/checking-out-a-file-from-vi
    "noremap  :!p4 edit "%":set noro


    " For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
    " let &guioptions = substitute(&guioptions, "t", "", "g")

    " Don't use Ex mode, use Q for formatting
    map Q gq

    " CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
    " so that you can undo CTRL-U after inserting a line break.
    inoremap <C-U> <C-G>u<C-U>

    " Convenient command to see the difference between the current buffer and the
    " file it was loaded from, thus the changes you made.
    " Only define it when not defined already.
    if !exists(":DiffOrig")
        command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                    \ | wincmd p | diffthis
    endif

    nnoremap j gj
    nnoremap k gk
    nnoremap gj j
    nnoremap gk k
    "vnoremap y "+y

" }}}

function! s:HandleRecover()
    echo system('diff - ' . shellescape(expand('%:p')), join(getline(1, '$'), "\n") . "\n")
    if v:shell_error
        call s:DiffOrig()
    else
        echohl WarningMsg
        echomsg "No differences; deleting the old swap file."
        echohl NONE
        call delete(b:swapname)
    endif
endfunction

function! s:DiffOrig()
    vert new
    set bt=nofile
    r #
    0d_
    diffthis
    wincmd p
    diffthis
endfunction

autocmd SwapExists  * let b:swapchoice = '?' | let b:swapname = v:swapname
autocmd BufReadPost * let b:swapchoice_likely = (&l:ro ? 'o' : 'r')
autocmd BufEnter    * let b:swapchoice_likely = (&l:ro ? 'o' : 'e')
autocmd BufWinEnter * if exists('b:swapchoice') && exists('b:swapchoice_likely') | let b:swapchoice = b:swapchoice_likely | unlet b:swapchoice_likely | endif
autocmd BufWinEnter * if exists('b:swapchoice') && b:swapchoice == 'r' | call s:HandleRecover() | endif


