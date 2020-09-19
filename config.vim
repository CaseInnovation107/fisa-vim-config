"First, I'm going to run my existing custom config file (39 lines):

"Noel Case, 9-15-20
"Updated 9-19-20

"Starting up all the vim plugins (such as autofill):
if using_neovim
    call plug#begin("~/.config/nvim/plugins")
else
    call plug#begin("~/.vim/plugins")
endif

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
"call plug#end()

"Applying the main user settings for the window appearance:
set updatetime=100
filetype plugin indent on
set number
set shortmess+=O
"set cmdheight=2
set hidden
source ~/.vim/mainColors.vim
set noswapfile
call setpos('.', save_cursor)

"Let statements
let $RTP=split(&runtimepath, ',')[0]
let $RC="~/.vim/vimrc"   
let save_cursor = getcurpos()

if (expand('%:e') == 'py')
    set shiftwidth=4 
    set tabstop=4
    set softabstop=4
    set expandtab autoindent smartindent
    setlocal colorcolumn=80
elseif (expand('%:e') == 'cpp' || expand('%:e') == 'c')
    set shiftwidth=3
    set tabstop=3
    set expandtab autoindent smartindent
    setlocal colorcolumn=79
else    
    set shiftwidth=3
    set tabstop=3
    set expandtab autoindent smartindent
    setlocal colorcolumn=80
endif

"end of my config file

" Fisa-vim-config, a config for both Vim and NeoVim
" http://vim.fisadev.com
" version: 12.0.1
set encoding=utf-8
let using_neovim = has('nvim')
let using_vim = !using_neovim

" Vim-plug initialization
" Avoid modifying this section, unless you are very sure of what you are doing
if !isdirectory('~/.vim/plugins') && !isdirectory('~/.vim/.plugins')
    if using_neovim
        let g:vim_plug_path = expand('~/.vim/.nvim/plugins/vim_plug_config/plug.vim')
    else
        let g:vim_plug_path = expand('~/.vim/plugins/vim_plug_config/plug.vim')
    endif
else
    let g:vim_plug_just_installed = 0
endif

if !filereadable(vim_plug_path)
    let g:vim_plug_just_installed = 1
    echo "Installing Vim-plug..."
    echo ""
    if using_neovim
        silent !mkdir -p ~/.config/nvim/autoload
        silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    else
        silent !mkdir -p ~/.vim/autoload
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    endif
endif

" manually load vim-plug the first time
if vim_plug_just_installed
    :execute 'source '.fnameescape(vim_plug_path)
endif

" IMPORTANT: some things in the config are vim or neovim specific. It's easy 
" to spot, they are inside `if using_vim` or `if using_neovim` blocks.
" ============================================================================

" Now the actual plugins:

" ============================================================================
" From the repo 'Aryan-dev007/My-Vimrc'

"Code Folding
"set foldenable
"set foldmethod=manual
"set foldlevelstart=10
"set foldnestmax=100

"Setting the same clipboard for Vim and System.
set clipboard=unnamed

"Trailing whitespaces
"Remove all trailing whitespaces by pressing fn-W
:nnoremap <silent> <FN> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl<Bar> :unlet _s <CR>
" ============================================================================

" Class/module browser
" Plug 'majutsushi/tagbar'

" Search results counter
Plug 'vim-scripts/IndexedSearch'

" A couple of nice colorschemes
" Plug 'fisadev/fisa-vim-colorscheme'
" Plug 'patstockwell/vim-monokai-tasty'

" Airline
Plug 'vim-airline/vim-airline'

" Plug 'vim-airline/vim-airline-themes'

" Async autocompletion
if using_neovim && vim_plug_just_installed
    Plug 'Shougo/deoplete.nvim', {'do': ':autocmd VimEnter * UpdateRemotePlugins'}
else
    Plug 'Shougo/deoplete.nvim'
endif

" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'

" Python autocompletion
Plug 'deoplete-plugins/deoplete-jedi'

" Just to add the python go-to-definition and similar features, autocompletion
" from this plugin is disabled
" Plug 'davidhalter/jedi-vim'
" Automatically close parenthesis, etc
Plug 'Townk/vim-autoclose'

" Better language packs
Plug 'sheerun/vim-polyglot'


" Paint css colors with the real color
Plug 'lilydjwg/colorizer'
" Window chooser
Plug 't9md/vim-choosewin'
" Automatically sort python imports
" Plug 'fisadev/vim-isort'
" Highlight matching html tags
Plug 'valloric/MatchTagAlways'
" Generate html in a simple way
Plug 'mattn/emmet-vim'

" Since I already have a plugin that does Git integration, but want another
" option in case it fails, I will leave this plugin commented out.
" Git integration
" Plug 'tpope/vim-fugitive'

" Yank history navigation
Plug 'vim-scripts/YankRing.vim'

if using_vim
    " Consoles as buffers (neovim has its own consoles as buffers)
    Plug 'rosenfeld/conque-term'
    " XML/HTML tags navigation (neovim has its own)
    Plug 'vim-scripts/matchit.zip'
endif

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()


" ============================================================================
" Install plugins the first time vim runs
if vim_plug_just_installed
    echo "Installing Bundles, please ignore key map error messages"
    :PlugInstall
endif

" ============================================================================
" Vim settings and mappings
" You can edit them as you wish
 
if using_vim
    " A bunch of things that are set by default in neovim, but not in vim
    
    " always show status bar
    set ls=2
    
    " better backup, swap and undos storage for vim (nvim has nice ones by
    " default)
    set directory=~/.vim/.tmp     " directory to place swap files in
    set backup                        " make backup files
    set backupdir=~/.vim/.backups " where to put backup files
    set undofile                      " persistent undos - undo after you re-open the file
    set undodir=~/.vim/.undos
    set viminfo+=n~/.vim/.viminfo
    " create needed directories if they don't exist
    if !isdirectory(&backupdir)
        call mkdir(&backupdir, "p")
    endif
    if !isdirectory(&directory)
        call mkdir(&directory, "p")
    endif
    if !isdirectory(&undodir)
        call mkdir(&undodir, "p")
    endif
end


" remove ugly vertical lines on window division
set fillchars+=vert:\ 

" use 256 colors when possible
if has('gui_running') || using_neovim || (&term =~? 'mlterm\|xterm\|xterm-256\|screen-256')
    if !has('gui_running')
        let &t_Co = 256
    endif
else
    colorscheme mainColors.vim
endif

" tab navigation mappings
map tn :tabnew 
map <M-Right> :tabn<CR>
imap <M-Right> <ESC>:tabn<CR>
map <M-Left> :tabp<CR>
imap <M-Left> <ESC>:tabp<CR>

" when scrolling, keep cursor 3 lines away from screen border
set scrolloff=2

" clear search results
" nnoremap <silent> // :noh<CR>

" clear empty spaces at the end of lines on save of python files
autocmd BufWritePre *.py :%s/\s\+$//e

" fix problems with uncommon shells (fish, xonsh) and plugins running commands
" (neomake, ...)
set shell=/bin/bash 

" Ability to add python breakpoints
" (I use ipdb, but you can change it to whatever tool you use for debugging)
au FileType python map <silent> <leader>b Oimport ipdb; ipdb.set_trace()<esc>

" ============================================================================
" Plugins settings and mappings
" Edit them as you wish.

" Tagbar -----------------------------

" toggle tagbar display
map <F4> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

" NERDTree -----------------------------

" toggle nerdtree display
map <N><T> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" don;t show these file types
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']

" Enable folder icons
let g:WebDevIconsUnicodeForateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

" Fix directory colors
highlight! link NERDTreeFlags NERDTreeDir

" Remove expandable arrow
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
let NERDTreeDirArrowExpandable = "\u00a0"
let NERDTreeDirArrowCollapsible = "\u00a0"
let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

" Deoplete -----------------------------

" Use deoplete.
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({
\   'ignore_case': v:true,
\   'smart_case': v:true,
\})
" complete with words from any opened file
let g:context_filetype#same_filetypes = {}
let g:context_filetype#same_filetypes._ = '_'

" Jedi-vim ------------------------------

" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0

" All these mappings work only for python code:
" Go to definition
let g:jedi#goto_command = ',d'
" Find ocurrences
let g:jedi#usages_command = ',o'
" Find assignments
let g:jedi#goto_assignments_command = ',a'
" Go to definition in new tab
nmap ,D :tab split<CR>:call jedi#goto()<CR>

" Ack.vim ------------------------------

" mappings
nmap ,r :Ack 
nmap ,wr :execute ":Ack " . expand('<cword>')<CR>

" Window Chooser ------------------------------

" mapping
nmap  -  <Plug>(choosewin)
" show big letters
let g:choosewin_overlay_enable = 1

" Signify ------------------------------

" this first setting decides in which order try to guess your current vcs
" UPDATE it to reflect your preferences, it will speed up opening files
let g:signify_vcs_list = ['git', 'hg']
" mappings to jump to changed blocks
nmap <leader>sn <plug>(signify-next-hunk)
nmap <leader>sp <plug>(signify-prev-hunk)
" nicer colors
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

" Autoclose ------------------------------

" Fix to let ESC work as espected with Autoclose plugin
" (without this, when showing an autocompletion window, ESC won't leave insert
"  mode)
let g:AutoClosePumvisible = {"ENTER": "\<C-Y>", "ESC": "\<ESC>"}

" Yankring -------------------------------

if using_neovim
    let g:yankring_history_dir = '~/.config/nvim/'
    " Fix for yankring and neovim problem when system has non-text things
    " copied in clipboard
    let g:yankring_clipboard_monitor = 0
else
    let g:yankring_history_dir = '~/.vim/dirs/'
endif

" Airline ------------------------------

let g:airline_powerline_fonts = 0
let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#enabled = 0

" Fancy Symbols!!
" if fancy_symbols_enabled
"    let g:webdevicons_enable = 1
"
"    " custom airline symbols
"    if !exists('g:airline_symbols')
"       let g:airline_symbols = {}
"    endif
"    let g:airline_left_sep = ''
"    let g:airline_left_alt_sep = ''
"    let g:airline_right_sep = ''
"    let g:airline_right_alt_sep = ''
"    let g:airline_symbols.branch = '⭠'
"    let g:airline_symbols.readonly = '⭤'
"    let g:airline_symbols.linenr = '⭡'
"else
"    let g:webdevicons_enable = 0
"endif

" Custom configurations ----------------

" Include user's custom nvim configurations
if using_neovim
    let custom_configs_path = "~/.vim/.nvim/custom.vim"
else
    let custom_configs_path = "~/.vim/custom.vim"
endif
if filereadable(expand(custom_configs_path))
  execute "source " . custom_configs_path
endif
