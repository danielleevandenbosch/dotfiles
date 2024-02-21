" Set the default encoding to UTF-8
set encoding=utf-8

" Enable syntax highlighting
syntax on

" Show line numbers
set number

" Set tabstop and shiftwidth for proper indentation
set tabstop=4
set shiftwidth=4
set expandtab

" Enable mouse support
set mouse=a

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

function! InsertAsClause()
    " Get the current column number
    let l:col = col('.')
    " Calculate how many spaces are needed to reach the 80th column
    let l:spaces_needed = 80 - l:col
    " If already past the 80th column, don't add spaces
    if l:spaces_needed < 0
        let l:spaces_needed = 1
    endif
    " Insert the spaces and the AS keyword
    execute "normal! i" . repeat(' ', l:spaces_needed) . "AS "
endfunction

" Map the function to a key combination, <Leader>a in this case
nnoremap <Leader>a :call InsertAsClause()<CR>

function! PromptReplaceGlobal()
    let l:find = input('Find: ')
    let l:replace = input('Replace with: ')
    let l:cmd = '%s/' . escape(l:find, '/\') . '/' . escape(l:replace, '/\') . '/gc'
    execute l:cmd
endfunction

nnoremap <C-R> :call PromptReplaceGlobal()<CR>

