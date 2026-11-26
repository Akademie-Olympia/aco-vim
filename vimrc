" ============================================================================
" ~/.config/vim/vimrc - Minimalistische Vim-Konfiguration
" Synchronisiert mit den Optionen & Keymaps aus ~/.config/nvim
" ============================================================================

set nocompatible
filetype plugin indent on
syntax enable

" Leader-Tasten (identisch zu Neovim: <Space> als Leader, \ als LocalLeader)
let mapleader = " "
let maplocalleader = "\\"

" ============================================================================
" UI & DARSTELLUNG
" ============================================================================
set number                  " Aktuelle Zeilennummer anzeigen
set relativenumber          " Relative Zeilennummern standardmäßig aktiv
set cursorline              " Aktuelle Zeile hervorheben
set signcolumn=yes          " Sign-Spalte immer anzeigen (verhindert Springen)
set scrolloff=8             " Mindestens 8 Zeilen Abstand oben/unten beim Scrollen
set sidescrolloff=8         " Mindestens 8 Spalten Abstand links/rechts
set splitbelow              " Horizontale Splits unten öffnen
set splitright              " Vertikale Splits rechts öffnen
set nowrap                  " Kein automatischer Zeilenumbruch
set list                    " Unsichtbare Zeichen dezent darstellen
set listchars=tab:»\ ,trail:·,nbsp:␣
set pumheight=12            " Maximale Höhe des Autocomplete-Popups
set cmdheight=1             " Befehlszeile 1 Zeile hoch
set laststatus=2            " Statuszeile unten immer anzeigen
set noshowmode              " Modus steht bereits farbig in der Statuszeile
set showcmd                 " Eingetippte Befehle rechts unten anzeigen
set wildmenu                " Verbesserte Tab-Vervollständigung in der Befehlszeile
set wildoptions=pum         " Popup-Menü für Befehlszeilen-Vervollständigung
set shortmess+=I            " Kein Intro-Startbildschirm

if has('termguicolors')
    set termguicolors
endif

" ============================================================================
" EDITIEREN & SUCHE
" ============================================================================
set mouse=a                 " Mausunterstützung in allen Modi
set encoding=utf-8          " UTF-8 Standardkodierung
set expandtab               " Tabs in Leerzeichen umwandeln
set shiftwidth=4            " Einrückung: 4 Leerzeichen
set tabstop=4               " Tab-Breite: 4 Leerzeichen
set softtabstop=4           " Backspace löscht 4 Leerzeichen auf einmal
set smartindent             " Intelligentes Einrücken
set autoindent              " Einrückung der Vorzeile übernehmen
set backspace=indent,eol,start
set ignorecase              " Groß-/Kleinschreibung bei Suche ignorieren...
set smartcase               " ...außer es werden Großbuchstaben getippt
set incsearch               " Live-Vorschau während der Suche
set hlsearch                " Suchtreffer hervorheben
set completeopt=menu,menuone,noselect,popup
set virtualedit=block       " Freie Bewegung im Visual-Block-Modus (CTRL-V)

" System-Zwischenablage nutzen (falls +clipboard verfügbar)
if has('clipboard')
    set clipboard=unnamedplus,unnamed
endif

" ============================================================================
" DATEIEN, PERSISTENZ & XDG-SAUBERKEIT (kein Müll in ~)
" ============================================================================
set hidden                  " Buffer wechseln ohne Speichern-Zwang
set autoread                " Geänderte Dateien automatisch neu laden
set confirm                 " Nachfragen statt Fehler bei ungespeicherten Änderungen
set noswapfile              " Keine .swp-Dateien erzeugen
set nobackup                " Keine Backup-Dateien erzeugen
set nowritebackup           " Kein temporäres Backup beim Überschreiben
set updatetime=250          " Schnellere Reaktionszeit (250ms)
set timeoutlen=400          " Timeout für Keymap-Sequenzen (400ms)
set ttimeoutlen=10          " Schnelles Escape im Terminal

" Persistent Undo & Viminfo sauber unter ~/.local/state/vim ablegen
let s:vim_state_dir = expand('~/.local/state/vim')
let s:vim_undo_dir  = s:vim_state_dir . '/undo'
if !isdirectory(s:vim_undo_dir)
    silent! call mkdir(s:vim_undo_dir, 'p', 0700)
endif
if has('persistent_undo')
    let &undodir = s:vim_undo_dir
    set undofile
endif
let &viminfofile = s:vim_state_dir . '/viminfo'

" ============================================================================
" FARBEN: folgen dem Desktop-Theme (aco-theme, Hell/Dunkel + Akzent).
" Ohne aco-theme bleibt das mitgelieferte habamax. Neue Vim-Fenster laden
" Änderungen; laufende mit :source ~/.config/aco/theme/vim/colors.vim
" ============================================================================
set background=dark
silent! colorscheme habamax
let s:aco_colors = expand('~/.config/aco/theme/vim/colors.vim')
if filereadable(s:aco_colors)
    execute 'source ' . fnameescape(s:aco_colors)
endif

" ============================================================================
" STATUSZEILE UNTEN (Mit Live-Modus, Datei-Infos & REL/ABS-Indikator)
" ============================================================================
function! StlModeLabel() abort
    let l:m = mode()
    if l:m ==# 'n' || l:m ==# 'no'
        return ' NORMAL '
    elseif l:m ==# 'i' || l:m ==# 'ic'
        return ' INSERT '
    elseif l:m ==# 'v'
        return ' VISUAL '
    elseif l:m ==# 'V'
        return ' V-LINE '
    elseif l:m ==# "\<C-v>"
        return ' V-BLOCK '
    elseif l:m ==# 'R' || l:m ==# 'Rv'
        return ' REPLACE '
    elseif l:m ==# 'c'
        return ' COMMAND '
    elseif l:m ==# 't'
        return ' TERMINAL '
    endif
    return ' ' . toupper(l:m) . ' '
endfunction

function! StlModeColor() abort
    let l:m = mode()
    if l:m ==# 'i' || l:m ==# 'ic'
        return '%#StlModeInsert#'
    elseif l:m ==# 'v' || l:m ==# 'V' || l:m ==# "\<C-v>"
        return '%#StlModeVisual#'
    elseif l:m ==# 'R' || l:m ==# 'Rv'
        return '%#StlModeReplace#'
    elseif l:m ==# 'c'
        return '%#StlModeCommand#'
    endif
    return '%#StlModeNormal#'
endfunction

function! StlLineNumberMode() abort
    if !&number && !&relativenumber
        return ' NUM:OFF '
    elseif &relativenumber
        return ' NUM:REL '
    else
        return ' NUM:ABS '
    endif
endfunction

function! BuildStatusLine() abort
    let l:stl  = '%{StlModeColor()}%{StlModeLabel()}'
    let l:stl .= '%#StlSectionFile# %f %*'
    let l:stl .= '%#StlSectionModified#%{&modified ? "[+] " : ""}%{&readonly ? "[RO] " : ""}%*'
    let l:stl .= '%#StlSectionMid#%='
    let l:stl .= '%#StlSectionNumMode#%{StlLineNumberMode()}'
    let l:stl .= '%#StlSectionFile# %{&filetype != "" ? &filetype : "plain"} │ %{&fileencoding != "" ? &fileencoding : &encoding} │ %{&fileformat} '
    let l:stl .= '%#StlSectionPos# %l:%v (%p%%) '
    return l:stl
endfunction

set statusline=%!BuildStatusLine()

" ============================================================================
" ZEILENNUMMERN: UMSCHALTEN ZWISCHEN RELATIV & ABSOLUT
" ============================================================================
function! ToggleRelativeAbsoluteNumbers() abort
    if !&number && !&relativenumber
        set number
        set relativenumber
        echo "Zeilennummern: Relativ (Hybrid)"
    elseif &relativenumber
        set number
        set norelativenumber
        echo "Zeilennummern: Absolut"
    else
        set number
        set relativenumber
        echo "Zeilennummern: Relativ (Hybrid)"
    endif
    redrawstatus
endfunction

function! ToggleNumbersOff() abort
    if &number || &relativenumber
        set nonumber
        set norelativenumber
        echo "Zeilennummern: Aus"
    else
        set number
        set relativenumber
        echo "Zeilennummern: Relativ (Hybrid)"
    endif
    redrawstatus
endfunction

command! ToggleRelNum call ToggleRelativeAbsoluteNumbers()

" <Space>un (wie in Neovim), <Space>rn, <Space>n oder <F3>: Relativ <-> Absolut umschalten
nnoremap <silent> <leader>un :call ToggleRelativeAbsoluteNumbers()<CR>
nnoremap <silent> <leader>rn :call ToggleRelativeAbsoluteNumbers()<CR>
nnoremap <silent> <leader>n  :call ToggleRelativeAbsoluteNumbers()<CR>
nnoremap <silent> <F3>       :call ToggleRelativeAbsoluteNumbers()<CR>
inoremap <silent> <F3>       <C-o>:call ToggleRelativeAbsoluteNumbers()<CR>

" <Space>uN (wie in Neovim): Zeilennummern komplett an/aus
nnoremap <silent> <leader>uN :call ToggleNumbersOff()<CR>

" ============================================================================
" WEITERE KEYMAPS (Synchronisiert mit ~/.config/nvim/lua/config/keymaps.lua)
" ============================================================================
" Fenster-Navigation mit CTRL + h/j/k/l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Fenster-Splits (<Space>wv / ws / wc / we)
nnoremap <silent> <leader>wv :vsplit<CR>
nnoremap <silent> <leader>ws :split<CR>
nnoremap <silent> <leader>wc :close<CR>
nnoremap <silent> <leader>we <C-w>=

" Buffer-Navigation mit SHIFT + H / L & Buffer schließen (<Space>bd)
nnoremap <silent> <S-h>      :bprevious<CR>
nnoremap <silent> <S-l>      :bnext<CR>
nnoremap <silent> <leader>bd :bdelete<CR>

" UI-Toggles: Zeilenumbruch (<Space>uw) & Unsichtbare Zeichen (<Space>ul)
nnoremap <silent> <leader>uw :set wrap!<CR>
nnoremap <silent> <leader>ul :set list!<CR>

" Suchhervorhebung mit <Esc> ausblenden
nnoremap <silent> <Esc> :nohlsearch<CR><Esc>

" System-Zwischenablage (<Space>y / <Space>Y)
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Einrücken im Visual-Mode behält die Auswahl bei
vnoremap < <gv
vnoremap > >gv

" Halbe Seite scrollen und Cursor zentriert halten
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" ============================================================================
" AUTOCOMMANDS
" ============================================================================
augroup vim_config_autocmds
    autocmd!
    " Letzte Cursor-Position beim Öffnen einer Datei wiederherstellen
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") && &ft !~# 'commit' |
        \   exe "normal! g`\"" |
        \ endif

    " Splits automatisch anpassen, wenn das Terminal-Fenster skaliert wird
    autocmd VimResized * wincmd =
augroup END
