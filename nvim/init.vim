" Vim Plug {{{
" Automatic vim plug installation
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
	silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

" UI
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'itchyny/lightline.vim'

" Langauge
Plug 'sheerun/vim-polyglot'
Plug 'NLKNguyen/c-syntax.vim', { 'for': 'c' }

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neoinclude.vim', { 'for': ['c', 'cpp'] }

" Tags
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

" Tools
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary', { 'on': [] }
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/fzf.vim'

call plug#end()

" lazy load plugins
augroup lazy_load
	autocmd!
	autocmd BufNewFile,BufRead * call plug#load('vim-commentary')
	autocmd InsertEnter * call deoplete#enable()
				\| autocmd! lazy_load
augroup END
" }}}
" Colors {{{
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if (has("termguicolors"))
	set termguicolors
endif

syntax enable			" turn on syntax highlight
if &term =~ '256color'
	" disable Background Color Erase (BCE) so that color schemes
	" render properly when inside 256-color tmux and GNU screen.
	" see also http://sunaku.github.io/vim-256color-bce.html
	set t_ut=
	set t_Co=256
endif
colorscheme challenger_deep

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
	syntax on
endif
" }}}
" Misc {{{
set pastetoggle=<F2>		" Use F2 to toggle paste mode

set noerrorbells		" No annoying sound on errors
set novisualbell
set t_vb=
set tm=500

set lazyredraw			" buffer the redraw

set noshowcmd
set noruler

set updatetime=250		" set file update delay to 250ms

set history=50			" Sets how many lines of history VIM has to remember
set autoread			" Set to auto read when a file is changed from
" the outside

set grepprg=rg\ --vimgrep
" }}}
" Search {{{
set ignorecase			" Ignore case when searching
set smartcase			" When searching try to be smart about cases 
set hlsearch			" Highlight search results
set incsearch			" Search as characters are entered 

nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
" }}}
" Completion {{{
set wildmode=list:full
set wildignore=*.o,*.obj,*.so,*~	"stuff to ignore when tab completing
set wildignore+=*.swp
set wildignore+=*.git*
set wildignore+=*.meteor*
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif
set wildignore+=*.zip
" }}}
" UI Layout {{{
set nu rnu			" hybrid line number

set colorcolumn=80		" 80 column limit marker
set synmaxcol=200

set noshowmode			" do not show original status bar
set laststatus=2
" }}}
" Splits {{{
" Map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>

" Use `ALT+{h,j,k,l}` to navigate windows from any mode":
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" adjust split size
map <silent> <S-h> <C-w><
map <silent> <S-k> <C-W>-
map <silent> <S-j> <C-W>+
map <silent> <S-l> <C-w>>

set splitbelow			" natural split opening
set splitright
" }}}
" Space & Tabs {{{
filetype plugin indent on
set modelines=1
set smartindent			" indent based on filetype
" }}}
" Tags {{{
set tags=.tags;

nmap <F8> :TagbarToggle<CR>
" }}}
" LanguageClient {{{
let g:LanguageClient_serverCommands = {
			\ 'python': ['pyls'],
			\ 'cpp': ['cquery', '--log-file=/tmp/cq.log'],
			\ 'c': ['cquery', '--log-file=/tmp/cq.log'],
			\ }
let g:LanguageClient_settingsPath = "$DOTFILES/nvim/settings.json"
set formatexpr=LanguageClient_textDocument_rangeFormatting()

nnoremap <silent> <Leader>h :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> <Leader>R :call LanguageClient_textDocument_rename()<CR>
nnoremap <silent> <Leader>f :call LanguageClient_textDocument_formatting()<CR>
nnoremap <silent> <Leader>d :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <Leader>r :call LanguageClient_textDocument_references()<CR>
nnoremap <silent> <Leader>s :call LanguageClient_textDocument_documentSymbol()<CR>
" }}}
" Deoplete {{{
inoremap <expr><tab> pumvisible() ? "\<C-N>" : "\<tab>"
" Close the documentation window when completion is done
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" }}}
" Gitgutter {{{
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_removed_first_line = '│'
let g:gitgutter_sign_modified_removed = '│'
" }}}
" Netrw {{{
let g:netrw_liststyle = 3	" tree-view
let g:netrw_winsize = 86
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_sort_sequence = '[\/]$,*'   " sort so directories on the top, files below
" }}}
" FZF {{{
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags -R'
let g:fzf_colors =
			\ { 'fg':    ['fg', 'Normal'],
			\ 'bg':      ['bg', 'Normal'],
			\ 'hl':      ['fg', 'Comment'],
			\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
			\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
			\ 'hl+':     ['fg', 'Statement'],
			\ 'info':    ['fg', 'PreProc'],
			\ 'border':  ['fg', 'Ignore'],
			\ 'prompt':  ['fg', 'Conditional'],
			\ 'pointer': ['fg', 'Exception'],
			\ 'marker':  ['fg', 'Keyword'],
			\ 'spinner': ['fg', 'Label'],
			\ 'header':  ['fg', 'Comment'] }
nnoremap <C-p> :Files<CR>
" hide status line
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode
			\| autocmd BufLeave <buffer> set laststatus=2 showmode
" }}}
" Lightline {{{
let g:lightline = {
			\ 'colorscheme': 'challenger_deep',
			\ 'active': {
			\   'left': [[ 'mode', 'paste' ],
			\	     [ 'fugitive', 'filename', 'modified']]
			\ },
			\ 'component_function': {
			\   'readonly': 'LightlineReadonly',
			\   'fugitive': 'LightlineFugitive',
			\   'fileformat': 'LightlineFileformat',
			\   'filetype': 'LightlineFiletype',
			\   'fileencoding': 'LightlineFileencoding',
			\ },
			\ 'separator': { 'left': '', 'right': '' },
			\ 'subseparator': { 'left': '', 'right': '' }
			\ }

function! LightlineReadonly()
	return &readonly && &filetype !=# 'help' ? '' : ''
endfunction

function! LightlineFugitive()
	if exists("*fugitive#head")
		let branch = fugitive#head()
		"Master branch symbol
		return branch !=# '' ? ' '.branch : ''   	
	endif
	return ''
endfunction

function! LightlineFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
	return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
	return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
" }}} 

" vim:foldmethod=marker:foldlevel=0
