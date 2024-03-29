syntax on
" wget https://raw.githubusercontent.com/sjl/badwolf/master/colors/badwolf.vim
" colorscheme badwolf
" wget https://raw.githubusercontent.com/taniarascia/new-moon.vim/master/colors/new-moon.vim
colorscheme new-moon

" basics
set number                      " line numbers
set cursorline                  " highlight current line
set wildmenu                    " visual autocomplete for command menu

" spacing
set tabstop=2                   " show tabs as two spaces
set softtabstop=2               " number of spaces in tab when editing
set expandtab                   " tabs are spaces
set shiftwidth=2                " number of spaces to indent

" vi ui
set showcmd                     " show command in bottom bar
set showmatch                   " highlight matching [{()}]

" searching
set incsearch                   " search as characters are entered
set hlsearch                    " highlight matches

" code folding
set foldenable                  " enable folding
set foldlevelstart=10           " open most folds by default
set foldnestmax=10              " 10 nested fold max
set foldmethod=indent           " fold based on indent level

set laststatus=2
set mouse=
set title
set backspace=indent,eol,start  " make sure backspace works everywhere

set list
set listchars=tab:->

highlight SpecialKey guifg=#4a4a59

" clear highlighting
nnoremap <silent> <C-l> :nohl<CR><C-l>

" blank lines
nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>
