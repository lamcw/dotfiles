" Dein {{{
let s:dein_base_path = '~/.cache/dein'
" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_base_path)
	call dein#begin(s:dein_base_path)

	" Let dein manage dein
	" Required:
	call dein#add('Shougo/dein.vim')

	" UI
	call dein#add('challenger-deep-theme/vim',
				\ { 'normalized_name': 'challenger_deep' })
	call dein#add('itchyny/lightline.vim')

	" Language
	call dein#add('sheerun/vim-polyglot')
	call dein#add('NLKNguyen/c-syntax.vim', { 'on_ft': 'c' })

	call dein#add('neoclide/coc.nvim', { 'merged': 0, 'rev': 'release' })

	" Tools
	call dein#add('majutsushi/tagbar', { 'on_cmd': 'TagbarToggle' })
	call dein#add('lambdalisue/gina.vim', { 'on_cmd': 'Gina' })
	call dein#add('tpope/vim-surround',
				\ { 'on_map': {
				\     'n': ['cs', 'ds', 'ys'],
				\     'x': 'S'
				\ }})
	call dein#add('tpope/vim-commentary', { 'on_map': { 'n': 'gc' }})
	call dein#add('airblade/vim-gitgutter', {
				\ 'on_event': 'BufWinEnter',
				\ 'hook_post_source': 'GitGutterEnable',
				\ })
	call dein#add('junegunn/fzf.vim', { 'on_event': 'VimEnter' })
	call dein#add('norcalli/nvim-colorizer.lua')

	" Required:
	call dein#end()
	call dein#save_state()
endif

" If you want to install not installed plugins on startup.
if !has('vim_starting') && dein#check_install()
	call dein#install()
endif
" }}}
" Colors {{{
set guioptions=M
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

if (has("termguicolors"))
	set termguicolors
endif

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

lua require'colorizer'.setup()
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

let g:tagbar_type_make = { 'kinds': ['m:macros', 't:targets'] }
" }}}
" lsp {{{
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>fs <Plug>(coc-format-selected)
nmap <leader>fs <Plug>(coc-format-selected)

xmap <leader>f  <Plug>(coc-format)
nmap <leader>f  <Plug>(coc-format)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}
" Deoplete {{{
inoremap <expr><tab> pumvisible() ? "\<C-N>" : "\<tab>"
" Close the documentation window when completion is done
augroup deoplete_menu
	autocmd!
	autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END
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
let g:netrw_winsize = 10
let g:netrw_browser_split = 4
let g:netrw_altv = 1
let g:netrw_banner = 0
let g:netrw_sort_sequence = '[\/]$,*'   " sort so directories on the top, files below
let g:netrw_dirhistmax = 0      " suppress history
" }}}
" FZF {{{
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1
let g:fzf_tags_command = 'ctags'
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
autocmd  FileType fzf set laststatus=0
			\| autocmd BufLeave <buffer> set laststatus=2
" }}}
" Lightline {{{
let g:lightline = {
	\ 'colorscheme': 'challenger_deep',
	\ 'active': {
	\   'left': [[ 'mode', 'paste' ],
	\	     [ 'ginabranch', 'filename', 'modified', 'cocstatus' ]]
	\ },
	\ 'component_function': {
	\   'readonly': 'LightlineReadonly',
	\   'ginabranch': 'LightlineGinaBranch',
	\   'fileformat': 'LightlineFileformat',
	\   'filetype': 'LightlineFiletype',
	\   'fileencoding': 'LightlineFileencoding',
	\   'cocstatus': 'coc#status'
	\ },
	\ 'separator': { 'left': '', 'right': '' },
	\ 'subseparator': { 'left': '', 'right': '' }
	\ }

function! LightlineReadonly()
	return &readonly && &filetype !=# 'help' ? '' : ''
endfunction

function! LightlineGinaBranch()
	" Use try catch to check if gina exists, instead of :exists, since
	" gina is lazily loaded
	try
		let l:branch = gina#component#repo#branch()
	catch /^Vim\%((\a\+)\)\=:E117/
		return ''
	endtry
	return l:branch !=# '' ? ' '.branch : ''
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

autocmd User CocStatusChange, CocDiagnosticChange call lightline#update()
" }}}

" vim:foldmethod=marker:foldlevel=0
