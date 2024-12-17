" Set the default encoding to UTF-8
let mapleader =","
set encoding=utf-8
" Enable syntax highlighting
syntax on
" Turn off color column
set colorcolumn=


" Show line numbers
set number
set relativenumber

" Set tabstop and shiftwidth for proper indentation
set tabstop=4
set shiftwidth=4
set expandtab

" Enable mouse support
" set mouse=a

" Highlight search results
set hlsearch

" Incremental search
set incsearch

" Show matching brackets/parentheses
set showmatch

" Enable line wrapping
set nowrap

" Set the default split window directions
set splitbelow
set splitright

" Enable clipboard support (for copying/pasting between Vim and other applications)
set clipboard=unnamedplus

" Custom mapping: Save with Ctrl+S
nnoremap <C-s> :w<CR>

" Custom mapping: Quit with Ctrl+Q
nnoremap <C-q> :q<CR>

" Custom mapping: Open a new tab with Ctrl+t
nnoremap <C-t> :tabnew<CR>

" Custom mapping: Switch between tabs with Ctrl+Left/Right
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
" Show whitespace
set list
set listchars=tab:▸\ ,space:·,eol:¬,trail:·,extends:>,precedes:<

function! PromptReplaceGlobal()
    let l:find = input('Find: ')
    let l:replace = input('Replace with: ')
    let l:cmd = '%s/' . escape(l:find, '/\') . '/' . escape(l:replace, '/\') . '/gc'
    execute l:cmd
endfunction

nnoremap <C-R> :call PromptReplaceGlobal()<CR>

" Initialize vim-plug in Neovim's plugin directory
call plug#begin('~/.local/share/nvim/plugged')
" Add Copilot plugin
Plug 'github/copilot.vim'
" Add the Emmet plugin with the correct spelling
Plug 'mattn/emmet-vim'

Plug 'mfussenegger/nvim-dap'
" Commentary plugin for toggling comments
Plug 'tpope/vim-commentary'

Plug 'junegunn/vim-easy-align'

call plug#end()

map <Esc>[Z <C-Space>
imap <Esc>[Z <C-Space>
let g:user_emmet_expandabbr_key = '<C-Space>'
autocmd FileType html,php,css,xml,js imap <silent><expr> <C-Space> emmet#expandAbbrIntelligent('<C-Space>')


vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

set scrolloff=8

nnoremap <CR> i<CR><Esc>
nnoremap <Space> i <Esc>l

nnoremap <C-s> :w<CR>

" Save in insert mode
inoremap <C-s> <Esc>:w<CR>i

" Save in visual mode
vnoremap <C-s> <Esc>:w<CR>v

" Map 'n' to create a new file in netrw
autocmd FileType netrw nmap <buffer> n :call CreateFileInNetrw()<CR>

" Function to prompt for a new file name in netrw
function! CreateFileInNetrw()
    let l:filename = input("New File Name: ")
    if l:filename != ""
        execute "edit " . expand("%:p") . "/" . l:filename
    endif
endfunction

" Map Caps Lock to Escape in Vim
inoremap <CapsLock> <Esc>
cnoremap <CapsLock> <Esc>



" Resize splits with Ctrl + hjkl
nnoremap <C-h> :vertical resize -2<CR>   " Decrease width
nnoremap <C-l> :vertical resize +2<CR>   " Increase width
nnoremap <C-j> :resize +2<CR>            " Increase height
nnoremap <C-k> :resize -2<CR>            " Decrease height
nnoremap ZS :w<CR>

map <leader>t :vsp \| terminal<CR>
map <leader>w :w<CR>
map <leader>q :q<CR>
map <leader>W :wq<CR>

map <leader>o :setlocal spell! spelllang=en_us<CR>

" easy align with out trailing space
" map <leader>, :EasyAlign /,/r0<CR>:silent! %s/, \{1,}/, /g<CR>
" map <leader>= :EasyAlign /=/r0<CR>:silent! %s/= \{1,}/= /g<CR>
" map <leader>( :EasyAlign /(/r0<CR>:silent! %s/( \{1,}/( /g<CR>
" map <leader>) :EasyAlign /)/r0<CR>:silent! %s/) \{1,}/) /g<CR>
" map <leader>; :EasyAlign /;/r0<CR>:silent! %s/; \{1,}/; /g<CR>
" map <leader>: :EasyAlign /:/r0<CR>:silent! %s/: \{1,}/: /g<CR>

" EasyAlign with exactly one trailing space for visual selection
vnoremap <leader>, :EasyAlign /,/r0<CR>:silent! '<,'>s/, */ , /g<CR>gv
vnoremap <leader>= :EasyAlign /=/r0<CR>:silent! '<,'>s/= */ = /g<CR>gv
vnoremap <leader>: :EasyAlign /:/r0<CR>:silent! '<,'>s/: */ : /g<CR>gv
vnoremap <leader>( :EasyAlign /(/r0<CR>:silent! '<,'>s/( */ ( /g<CR>gv
vnoremap <leader>) :EasyAlign /)/r0<CR>:silent! '<,'>s/) */ ) /g<CR>gv
vnoremap <leader>; :EasyAlign /;/r0<CR>:silent! '<,'>s/; */ ; /g<CR>gv
vnoremap <leader>{ :EasyAlign /{/r0<CR>:silent! '<,'>s/{ */ { /g<CR>gv
vnoremap <leader>} :EasyAlign /}/r0<CR>:silent! '<,'>s/} */ } /g<CR>gv
vnoremap <leader>- :EasyAlign /-/r0<CR>:silent! '<,'>s/- */ - /g<CR>gv
vnoremap <leader>+ :EasyAlign /+/r0<CR>:silent! '<,'>s/+ */ + /g<CR>gv
vnoremap <leader>< :EasyAlign /</r0<CR>:silent! '<,'>s/< */ < /g<CR>gv
vnoremap <leader>> :EasyAlign />/r0<CR>:silent! '<,'>s/> */ > /g<CR>gv
vnoremap <leader>* :EasyAlign /\*/r0<CR>:silent! '<,'>s/\* */ * /g<CR>gv
vnoremap <leader>& :EasyAlign /&/r0<CR>:silent! '<,'>s/& */ & /g<CR>gv


map <leader>l :set wrap!<CR>
map <leader>v :vs .<CR>
map <leader>V :vsp ~/dotfiles/.vimrc<CR>
" Toggle comment with leader k
nmap <leader>k :Commentary<CR>
vmap <leader>k :Commentary<CR>

" marcos 
nnoremap <F5> @q
