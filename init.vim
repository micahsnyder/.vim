set shell=/bin/bash
let mapleader = "\<Space>"

execute pathogen#infect()

filetype plugin indent on
syntax on

let g:ale_linters = {'rust': ['analyzer']}

set autoindent
set timeoutlen=300 " http://stackoverflow.com/questions/2158516/delay-before-o-opens-a-new-line
set encoding=utf-8
set scrolloff=2
set noshowmode
set hidden
set nowrap
set nojoinspaces
let g:sneak#s_next = 1
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_frontmatter = 1
set printfont=:h10
set printencoding=utf-8
set printoptions=paper:letter
" Always draw sign column. Prevent buffer moving when adding/deleting sign.
set signcolumn=yes

" Quick-save
nmap <leader>w :w<CR>

" Open hotkeys
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>



" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

set tabstop=4 shiftwidth=4

" Plugin settings
let g:secure_modelines_allowed_items = [
      \ "textwidth",   "tw",
      \ "softtabstop", "sts",
      \ "tabstop",     "ts",
      \ "shiftwidth",  "sw",
      \ "expandtab",   "et",   "noexpandtab", "noet",
      \ "filetype",    "ft",
      \ "foldmethod",  "fdm",
      \ "readonly",    "ro",   "noreadonly", "noro",
      \ "rightleft",   "rl",   "norightleft", "norl",
      \ "colorcolumn"
      \ ]

" Lightline
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'coc#status'
      \ },
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Use <c-.> to trigger completion.
inoremap <silent><expr> <c-.> coc#refresh()

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

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>

" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>

" Implement methods for trait
nnoremap <silent> <space>i  :call CocActionAsync('codeAction', '', 'Implement missing members')<cr>

" Show actions available at this location
nnoremap <silent> <space>a  :CocAction<cr>



" from http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
if executable('ag')
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif

" rust
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

" clang-format
let g:clang_format#auto_format = 1
let g:clang_format#detect_style_file = 1

let g:clang_format#style_options = {
    \ "Language": "Cpp", 
	\ "UseTab": "Never", 
	\ "IndentWidth": 4, 
	\ "AlignTrailingComments": "true", 
	\ "AlignConsecutiveAssignments": "true", 
	\ "AlignAfterOpenBracket": "true", 
	\ "AlignEscapedNewlines": "Left", 
	\ "AlignOperands": "true", 
	\ "AllowShortFunctionsOnASingleLine": "Empty", 
	\ "AllowShortIfStatementsOnASingleLine": "true", 
	\ "AllowShortLoopsOnASingleLine": "true", 
	\ "BreakBeforeBraces": "Linux", 
	\ "BreakBeforeTernaryOperators": "true", 
	\ "ColumnLimit": 0, 
	\ "FixNamespaceComments": "true", 
	\ "SortIncludes": "false", 
	\ "MaxEmptyLinesToKeep": 1, 
	\ "SpaceBeforeParens": "ControlStatements", 
	\ "IndentCaseLabels": "true", 
	\ "DerivePointerAlignment": "true" } 

" Completion
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" =============================================================================
" # GUI settings
" =============================================================================
set guioptions-=T " Remove toolbar
set vb t_vb= " No more beeps
set backspace=2 " Backspace over newlines
set nofoldenable
set ttyfast
" https://github.com/vim/vim/issues/1735#issuecomment-383353563
set lazyredraw
set synmaxcol=500
set laststatus=2
set relativenumber " Relative line numbers
set number " Also show current absolute line
set diffopt+=iwhite " No whitespace in vimdiff
" Make diffing better: https://vimways.org/2018/the-power-of-diff/
set diffopt+=algorithm:patience
set diffopt+=indent-heuristic
"set colorcolumn=80 " and give me a colored column
set showcmd " Show (partial) command in status line.
set mouse=a " Enable mouse usage (all modes) in terminals
set shortmess+=c " don't give |ins-completion-menu| messages.

" =============================================================================
" # Footer
" =============================================================================

" nvim
if has('nvim')
	runtime! plugin/python_setup.vim
endif

