" ~/.vimrc

" Awesome .vimrc to check https://github.com/zenbro/dotfiles/blob/master/.nvimrc#L151-L187
" 450
syntax on
filetype plugin indent on

let mapleader = "ù"
" Section: Plug {{{1
call plug#begin('~/.vim/plugged')

" Mandatory
Plug 'morhetz/gruvbox'
Plug 'tommcdo/vim-exchange'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Filer
Plug 'scrooloose/nerdtree'

" Ide
Plug 'majutsushi/tagbar'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-capslock'
Plug 'LucHermitte/vim-refactor'

" Search
Plug 'terryma/vim-multiple-cursors'

" Formatage
Plug 'Yggdroot/indentLine'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'

" Completion
Plug 'SirVer/ultisnips'
Plug 'Valloric/YouCompleteMe'

" Rust
Plug 'rust-lang/rust.vim'
Plug 'racer-rust/vim-racer'

" Syntastic
Plug 'vim-syntastic/syntastic'

" Python
Plug 'nvie/vim-flake8'
Plug 'Vimjas/vim-python-pep8-indent'

" Markdown
Plug 'suan/vim-instant-markdown'
Plug 'plasticboy/vim-markdown'

" Integration
Plug 'mikelue/vim-maven-plugin'
Plug 'tsaleh/vim-tmux'

" Other
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tommcdo/vim-ninja-feet'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-rooter'
Plug 'tpope/vim-sensible'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-tbone'
Plug 'neomake/neomake'
Plug 'sbdchd/neoformat'

call plug#end()
" }}}1
"    Section: Setup {{{1
" ---------------------
" Basic {{{2
set nocompatible
set autoindent
set autoread
set autowrite       " Automatically save before commands like :next and :make
set backupdir=${HOME}/.vim/tmp/
set cmdheight=2
set directory=${HOME}/.vim/swap/
set foldmethod=marker
set foldopen+=jump
if executable("rg")
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif
set history=200
set incsearch       " Incremental search
set laststatus=1    " Always show status line
set lazyredraw
set linebreak
set mouse=nvi
set mousemodel=popup
set number
set pastetoggle=<F2>
set printoptions=paper:letter
set scrolloff=1
set shiftround
set showcmd         " Show (partial) command in status line.
set showmatch       " Show matching brackets.
set sidescrolloff=5
set smartcase       " Case insensitive searches become sensitive with capitals
set smarttab        " sw at the start of the line, sts everywhere else
if exists("+spelllang")
    set spelllang=en_us
endif
set spellfile=~/.vim/spell/en.utf-8.add
set statusline=[%n]\ %<%.99f\ %h%w%m%r%{SL('CapsLockStatusline')}%y%{SL('fugitive#statusline')}%#ErrorMsg#%{SL('SyntasticStatuslineFlag')}%*%=%-14.(%l,%c%V%)\ %P
setglobal tags=./tags;
set tabstop=4
set timeoutlen=1200 " A little bit more time for macros
set ttimeoutlen=50  " Make Esc work faster
set tw=80
if exists('+undofile')
    set undodir=~/.vim/.undo//
    set undofile
endif
if v:version >= 700
    set viminfo=!,'20,<50,s10,h
endif
set visualbell
set virtualedit=block
set wildmenu
set wildmode=longest:full,full
set wildignore+=tags,.*.un~,*.pyc
set winaltkeys=no
set wrap 

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Plugins {{{2
" NERDTree {{{3
let g:NERDShutUp=1
let g:nerdtree_tabs_open_on_gui_startup=0
let b:match_ignorecase = 1

map <C-e> :NERDTreeToggle<CR>
map <leader>f :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeChDirMode=2 "0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let NERDTreeShowLineNumbers=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$',
            \ '\.swp$', '^\.git$', '^\.idea$', '^\.hg$', 
            \ '^\.svn$', '\.bzr$']

autocmd bufenter * if (winnr("$") == 1 && 
            \ exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" }}}3
" Gruvbox {{{3
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='medium'
set background=dark
color gruvbox
" }}}3
" Fzf {{{3
set rtp+=~/.fzf

let g:fzf_nvim_statusline = 0 " disable statusline overwriting
" Fuzzy-find with fzf
nnoremap <C-p> :Files<cr>
nnoremap <C-p> :Files<cr>

" View commits in fzf
nnoremap <Leader>c :Commits<cr>

" Complete from open tmux panes (from @junegunn)
inoremap <expr> <C-x><C-t> fzf#complete( 'tmuxwords.rb -all-but-current --scroll 499 --min 5')

inoremap <expr> <C-x><C-k> fzf#complete('cat /usr/share/dict/words')

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
imap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" }}}3
" Ultisnips {{{3
nnoremap <leader>se :UltiSnipsEdit<CR>

let g:UltiSnipsSnippetsDir         = '~/.vim/bundle/vim-snippets/UltiSnips'
let g:UltiSnipsEditSplit           = 'horizontal'
let g:UltiSnipsListSnippets        = '<nop>'
let g:UltiSnipsExpandTrigger       = '<c-l>'
let g:UltiSnipsJumpForwardTrigger  = '<c-l>'
let g:UltiSnipsJumpBackwardTrigger = '<c-b>'
let g:ulti_expand_or_jump_res      = 0
" }}}3
" YouCompleteMe {{{3
let g:ycm_autoclose_preview_window_after_completion=1
noremap <leader>b  :YcmCompleter GoToDefinitionElseDeclaration<CR>
" }}}3
" Syntastic {{{3
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" }}}3
" GitGutter {{{3
" Basic settings
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterUndoHunk
nmap <Leader>hv <Plug>GitGutterPreviewHunk

" Global command
function! GlobalChangedLines(ex_cmd)
    for hunk in GitGutterGetHunks()
        for lnum in range(hunk[2], hunk[2]+hunk[3]-1)
            let cursor = getcurpos()
            silent! execute lnum.a:ex_cmd
            call setpos('.', cursor)
        endfor
    endfor
endfunction

command -nargs=1 Glines call GlobalChangedLines(<q-args>)

" }}}3
" Fugitive {{{3
" Fix broken syntax highlight in gitcommit files
" (https://github.com/tpope/vim-git/issues/12)
let g:fugitive_git_executable = 'LANG=en_US.UTF-8 git'

nmap <silent> <leader>gs :Gstatus<CR>
nmap <silent> <leader>gd :Gdiff<CR>
nmap <silent> <leader>gc :Gcommit<CR>
nmap <silent> <leader>gb :Gblame<CR>
nmap <silent> <leader>ge :Gedit<CR>
nmap <silent> <leader>gE :Gedit<space>
nmap <silent> <leader>gr :Gread<CR>
nmap <silent> <leader>gR :Gread<space>
nmap <silent> <leader>gw :Gwrite<CR>
nmap <silent> <leader>gW :Gwrite!<CR>
nmap <silent> <leader>gq :Gwq<CR>
nmap <silent> <leader>gQ :Gwq!<CR>

function! ReviewLastCommit()
    if exists('b:git_dir')
        Gtabedit HEAD^{}
        nnoremap <buffer> <silent> q :<C-U>bdelete<CR>
    else
        echo 'No git a git repository:' expand('%:p')
    endif
endfunction
nnoremap <silent> <leader>g` :call ReviewLastCommit()<CR>
" }}}3
" Tagbar {{{ 3
nnoremap <F8> :TagbarToggle<CR>
" }}}3
" }}}2
" }}}1
" Section: Commands {{{1
" -----------------------
" SL {{{2
if has("eval")
    function! SL(function)
        if exists('*'.a:function)
            return call(a:function,[])
        else
            return ''
        endif
    endfunction
endif
" }}}2
" OpenURL {{{2
function! OpenURL(url)
    if has("win32")
        exe "!start cmd /cstart /b ".a:url.""
    elseif $DISPLAY !~ '^\w'
        exe "silent !xdg-open \"".a:url."\""
    elseif exists(':Start')
        exe "Start xdg-open -T \"".a:url."\""
    else
        exe "! xdg-open -T \"".a:url."\""
    endif
    redraw!
endfunction
command! -nargs=1 OpenURL :call OpenURL(<q-args>)
" open URL under cursor in browser
nnoremap gb :OpenURL <cfile><CR>
nnoremap gA :OpenURL http://www.answers.com/<cword><CR>
nnoremap gG :OpenURL http://www.google.com/search?q=<cword><CR>
nnoremap gS :OpenURL https://stackoverflow.com/search?q=<cword><CR>
nnoremap gW :OpenURL http://en.wikipedia.org/wiki/Special:Search?search=<cword><CR>
"}}}2
" Find with fzf {{{2
" --column: Show column number
"  " --line-number: Show line number
"  " --no-heading: Do not show file headings in results
"  " --fixed-strings: Search term as a literal string
"  " --ignore-case: Case insensitive search
"  " --no-ignore: Do not respect .gitignore, etc...
"  " --hidden: Search hidden files and folders
"  " --follow: Follow symlinks
"  " --glob: Additional conditions for search (in this case ignore everything in
"  the .git/ folder)
"  " --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('ag --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
"}}}2
"}}}1
" Section: Autocommands {{{1
" --------------------------

if has("autocmd")
    filetype plugin indent on

    augroup Misc " {{{2
        autocmd!

        autocmd FileType netrw call s:scratch_maps()
        autocmd FileType gitcommit if getline(1)[0] ==# '#' | call s:scratch_maps() | endif
        autocmd FocusGained * if !has('win32') | silent! call fugitive#reload_status() | endif
        autocmd FocusLost   * silent! wall
        autocmd SourcePre */macros/less.vim set laststatus=0 cmdheight=1
        if v:version >= 700 && isdirectory(expand("~/.trash"))
            autocmd BufWritePre,BufWritePost * if exists("s:backupdir") | set backupext=~ | let &backupdir = s:backupdir | unlet s:backupdir | endif
            autocmd BufWritePre ~/*
                        \ let s:path = expand("~/.trash").strpart(expand("<afile>:p:~:h"),1) |
                        \ if !isdirectory(s:path) | call mkdir(s:path,"p") | endif |
                    \ let s:backupdir = &backupdir |
                    \ let &backupdir = escape(s:path,'\,').','.&backupdir |
                    \ let &backupext = strftime(".%Y%m%d%H%M%S~",getftime(expand("<afile>:p")))
        endif

        autocmd User Fugitive
                    \ if filereadable(fugitive#buffer().repo().dir('fugitive.vim')) |
                    \   source `=fugitive#buffer().repo().dir('fugitive.vim')` |
                    \ endif

        autocmd BufReadPost * if getline(1) =~# '^#!' | let b:dispatch = getline(1)[2:-1] . ' %' | let b:start = b:dispatch | endif
        autocmd BufReadPost ~/.Xdefaults,~/.Xresources let b:dispatch = 'xrdb -load %'
        autocmd BufNewFile */init.d/*
                    \ if filereadable("/etc/init.d/skeleton") |
                    \   keepalt read /etc/init.d/skeleton |
                    \   1delete_ |
                    \ endif |
                    \ set ft=sh

        autocmd BufWritePre,FileWritePre /etc/* if &ft == "dns" |
                    \ exe "normal msHmt" |
                    \ exe "gl/^\\s*\\d\\+\\s*;\\s*Serial$/normal ^\<C-A>" |
                    \ exe "normal g`tztg`s" |
                    \ endif
        autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
                    \ if !$VIMSWAP && isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
    augroup END " }}}2
    augroup FTCheck " {{{2
        autocmd!
        autocmd BufNewFile,BufRead *named.conf*       set ft=named
        autocmd BufNewFile,BufRead *.txt,README,INSTALL,NEWS,TODO if &ft == ""|set ft=text|endif
    augroup END " }}}2
    augroup FTOptions " {{{2
        autocmd!
        autocmd FileType c,cpp,cs,java          setlocal commentstring=//\ %s
        autocmd Syntax   javascript             setlocal isk+=$
        autocmd FileType xml,xsd,xslt,javascript setlocal ts=2
        autocmd FileType text,txt,mail          setlocal ai com=fb:*,fb:-,n:>
        autocmd FileType sh,zsh,csh,tcsh        inoremap <silent> <buffer> <C-X>! #!/bin/<C-R>=&ft<CR>
        autocmd FileType sh,zsh,csh,tcsh        let &l:path = substitute($PATH, ':', ',', 'g')
        autocmd FileType perl,python,ruby       inoremap <silent> <buffer> <C-X>! #!/usr/bin/env<Space><C-R>=&ft<CR>
        autocmd FileType c,cpp,cs,java,perl,javscript,php,aspperl,tex,css let b:surround_101 = "\r\n}"
        autocmd FileType apache       setlocal commentstring=#\ %s
        autocmd FileType cucumber let b:dispatch = 'cucumber %' | inoremap <buffer><expr> <Tab> pumvisible() ? "\<C-N>" : (CucumberComplete(1,'') >= 0 ? "\<C-X>\<C-O>" : (getline('.') =~ '\S' ? ' ' : "\<C-I>"))
        autocmd FileType git,gitcommit setlocal foldmethod=syntax foldlevel=1
        autocmd FileType gitcommit setlocal spell
        autocmd FileType gitrebase nnoremap <buffer> S :Cycle<CR>
        autocmd FileType help setlocal ai fo+=2n | silent! setlocal nospell
        autocmd FileType help nnoremap <silent><buffer> q :q<CR>
        autocmd FileType html setlocal iskeyword+=~ | let b:dispatch = ':OpenURL %'
        autocmd FileType java let b:dispatch = 'javac %'
        autocmd FileType lua  setlocal includeexpr=substitute(v:fname,'\\.','/','g').'.lua'
        autocmd FileType perl let b:dispatch = 'perl -Wc %'
        autocmd FileType ruby setlocal tw=79 comments=:#\  isfname+=:
        autocmd FileType ruby
                    \ let b:start = executable('pry') ? 'pry -r "%:p"' : 'irb -r "%:p"' |
                    \ if expand('%') =~# '_test\.rb$' |
                    \   let b:dispatch = 'testrb %' |
                    \ elseif expand('%') =~# '_spec\.rb$' |
                    \   let b:dispatch = 'rspec %' |
                    \ elseif !exists('b:dispatch') |
                    \   let b:dispatch = 'ruby -wc %' |
                    \ endif
        autocmd FileType liquid,markdown,text,txt setlocal tw=78 linebreak nolist
        autocmd FileType tex let b:dispatch = 'latex -interaction=nonstopmode %' | setlocal formatoptions+=l
                    \ | let b:surround_{char2nr('x')} = "\\texttt{\r}"
                    \ | let b:surround_{char2nr('l')} = "\\\1identifier\1{\r}"
                    \ | let b:surround_{char2nr('e')} = "\\begin{\1environment\1}\n\r\n\\end{\1\1}"
                    \ | let b:surround_{char2nr('v')} = "\\verb|\r|"
                    \ | let b:surround_{char2nr('V')} = "\\begin{verbatim}\n\r\n\\end{verbatim}"
        autocmd FileType vim  setlocal keywordprg=:help |
                    \ if exists(':Runtime') |
                    \   let b:dispatch = ':Runtime' |
                    \   let b:start = ':Runtime|PP' |
                    \ else |
                    \   let b:dispatch = ":unlet! g:loaded_{expand('%:t:r')}|source %" |
                    \ endif
        autocmd FileType timl let b:dispatch = ':w|source %' | let b:start = b:dispatch . '|TLrepl' | command! -bar -bang Console Wepl
        autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
        autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif
    augroup END "}}}2
endif " has("autocmd")

" }}}1
" Section: Mappings {{{1
" --------------------------

" Save
nnoremap <Leader>w :w<CR>

" Sudo save
cnoremap w!! w !sudo tee % > /dev/null

" Jump to end of paste
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Copy from clipboard
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P


" Visual line
"nmap <Leader><Leader> V

" Expanding region
"vmap v <Plug>(expand_region_expand)
"vmap <C-v> <Plug>(expand_region_shrink)

" Window change
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
"}}}1

" vp doesn't replace paste buffer
function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Stop that stupid window from popping up
noremap q: :q

" Stop use <esc> to quit insert mode
inoremap jk <esc>

" Go to the end of block when yank
vnoremap y ygv<esc>

" Section: Function {{{1
"
" Format json
com! FormatJSON %!python -m json.tool
" }}}1
" Section: ToTest {{{1

function! s:escape(path)
    return substitute(a:path, ' ', '\\ ', 'g')
endfunction

function! AgHandler(line)
    let parts = split(a:line, ':')
    let [fn, lno] = parts[0 : 1]
    execute 'e '. s:escape(fn)
    execute lno
    normal! zz
endfunction

command! -nargs=+ Fag call fzf#run({
            \ 'source': 'ag "<args>"',
            \ 'sink': function('AgHandler'),
            \ 'options': '+m',
            \ 'tmux_height': '60%'
            \ })
" }}}1
