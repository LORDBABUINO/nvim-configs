let mapleader =","

set rnu nu
set clipboard+=unnamedplus

" Disables automatic commenting on newline:
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Json format function
  command! -range -nargs=0 -bar JsonTool <line1>,<line2>!python -m json.tool

" Neovide Font
set guifont=Fira\ Code:h8

" set folding to shell files
autocmd FileType sh setlocal foldmethod=marker foldlevel=0 foldcolumn=3

" Enable autocompletion {{{
  set wildmode=full
  set wildmenu
" }}}

" Keymaps {{{
" Replace all is aliased to S.
  nnoremap S :%s//g<Left><Left>

" Compile document, be it groff/LaTeX/markdown/etc.
  map <leader>c :w! \| !compiler "%"<CR>

" Spell-check set to <leader>o, 'o' for 'orthography':
  map <leader>o :setlocal spell! spelllang=en_us,pt_br<CR>
" }}}

" Config tabs {{{
  set tabstop=2
  set softtabstop=0
  set expandtab
  set shiftwidth=2
" }}}

" Visible whitespace with :set list {{{
  setl fileformat?
  set list
  set listchars=tab:▸\ ,eol:¬,space:·
" }}}

" Plugins {{{
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
  echo "Downloading junegunn/vim-plug to manage plugins..."
  silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
" Plug 'eliba2/vim-node-inspect'
" Plug 'fatih/vim-go'
" Plug 'rust-lang/rust.vim'
" Plug 'tomlion/vim-solidity'
" Plug 'vim-scripts/VimClojure'
Plug 'mattn/emmet-vim'
" Plug 'mlaursen/vim-react-snippets'
" Plug 'mxw/vim-jsx'
" Plug 'PotatoesMaster/i3-vim-syntax'
" Plug 'styled-components/vim-styled-components', { 'branch' : 'main' }
" Plug 'vim-airline/vim-airline'

" Color theme
Plug 'ellisonleao/gruvbox.nvim'
Plug 'RRethy/nvim-base16'

" Displays hex color on the fly
Plug 'ap/vim-css-color'

" Add bottom airline themes
Plug 'vim-airline/vim-airline-themes'
Plug 'bling/vim-airline'

" Adds editorconfig configuration
Plug 'editorconfig/editorconfig-vim'

" Sintax highlight for tsx
" Plug 'ianks/vim-tsx'

" git commit tool
" Plug 'jreybert/vimagit'

" some kind of x config highlighting
" Plug 'kovetskiy/sxhkd-vim'

" makes easier to use accents on american layouts
" Plug 'lukesmithxyz/vimling'

" Syntax highlighting
" Plug 'pangloss/vim-javascript'
" Plug 'leafgarland/typescript-vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/playground'

" don't know what it does
" Plug 'prabirshrestha/async.vim'

" shotcuts to comment stuff
" Plug 'tpope/vim-commentary'

" git presentation tool
Plug 'tpope/vim-fugitive' " Use :GvsplitDiff! to resolve merge conflicts
Plug 'lewis6991/gitsigns.nvim' " Shows added/remove lines and git blame
Plug 'hattya/vcs-info.vim' " Shows current git branch

" provides shortcuts to surrounding expressions
" Plug 'tpope/vim-surround'

Plug 'preservim/nerdtree' " possibly deprecated
Plug 'vimwiki/vimwiki'
Plug 'junegunn/goyo.vim'

" lsp related:
" Plug 'w0rp/ale'
" Plug 'ryanolsonx/vim-lsp-typescript' " possibly deprecated
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/asyncomplete-lsp.vim' " possibly uneeded dependency
" Plug 'neovim/nvim-lspconfig' " Enable LSP
" Plug 'williamboman/nvim-lsp-installer' " install diferent linguage supports

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Database management
Plug 'tpope/vim-dadbod'
"Plug 'pbogut/vim-dadbod-ssh'
Plug 'kristijanhusak/vim-dadbod-ui'

" Debugger
Plug 'puremourning/vimspector'

Plug 'xiyaowong/nvim-transparent'

Plug 'github/copilot.vim'

call plug#end()
" }}}

" Plugin Colorscheme {{{
  " colorscheme gruvbox
  " colorscheme base16-solarized-dark
  colorscheme base16-monokai
" }}}

" Plugin Config preservim/nerdtree {{{
  map <leader>n :NERDTreeToggle<CR>
  let NERDTreeWinSize=50
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif
" }}}

" Plugin Config junegunn/goyo.vim {{{
  map <leader>f :Goyo \| set bg=light \| set linebreak<CR>
" }}}

" Plugin Config hattya/vcs-info.vim {{{
  let info = vcs_info#get()
  if !empty(info)
    let s = info.head
    if info.action !=# ''
      let s .= ':' . info.action
    endif
  endif
" }}}

" Plugin Config bling/vim-airline {{{
  let g:airline_theme = 'kolor'
  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 0
  let g:airline_section_y = airline#section#create(['%B'])
  let g:airline_section_z = airline#section#create_right(['%l','%c'])
" }}}

" Plugin Config vimwiki/vimwiki {{{
  map <leader>v :VimwikiIndex
  let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax': 'markdown', 'ext': '.md'}]
" }}}

" Plugin Config nvim-lspconfig {{{
" lua << EOF
" -- Mappings.
" -- See `:help vim.diagnostic.*` for documentation on any of the below functions
" local opts = { noremap=true, silent=true }
" vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
" vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
" vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
" vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
" 
" -- Use an on_attach function to only map the following keys
" -- after the language server attaches to the current buffer
" local on_attach = function(client, bufnr)
"   -- Enable completion triggered by <c-x><c-o>
"   vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
" 
"   -- Mappings.
"   -- See `:help vim.lsp.*` for documentation on any of the below functions
"   local bufopts = { noremap=true, silent=true, buffer=bufnr }
"   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
"   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
"   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
"   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
"   vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
"   vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
"   vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
"   vim.keymap.set('n', '<space>wl', function()
"     print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
"   end, bufopts)
"   vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
"   vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
"   vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
"   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
"   vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
" end
" 
" local lsp_flags = {
"   -- This is the default in Nvim 0.7+
"   debounce_text_changes = 150,
" }
" 
" require('lspconfig').tsserver.setup({
"   on_attach = on_attach,
"   flags = lsp_flags,
" })
" EOF
" }}}

" Plugin Config neoclid/coc.nvim {{{
let g:coc_global_extensions = [ 'coc-rust-analyzer', 'coc-solidity', 'coc-html', 'coc-json', 'coc-tsserver', 'coc-tslint-plugin', 'coc-prettier', 'coc-eslint', 'coc-pyright' ] 

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" auto fix
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <silent> <leader>qa <Plug>(coc-codeaction-cursor)

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Format python files on save
aug python
  au!
  au BufWrite *.py call CocAction('format')
aug END
" }}}

" Plugin Config kristijanhusak/vim-dadbod-ui {{{
nnoremap <silent> <leader>du :DBUIToggle<CR>
nnoremap <silent> <leader>df :DBUIFindBuffer<CR>
nnoremap <silent> <leader>dr :DBUIRenameBuffer<CR>
nnoremap <silent> <leader>dl :DBUILastQueryInfo<CR>
let g:db_ui_save_location = '~/.config/db_ui'
" }}}

" Plugin Config puremourning/vimspector {{{
let g:vimspector_enable_mappings = 'HUMAN'
nmap <leader>il :call vimspector#Launch()<CR>
nmap <leader>iX :call vimspector#ClearBreakpoints()<CR>
nmap <leader>isi :call vimspector#StepInto()<CR>
nmap <leader>iso :call vimspector#StepOver()<CR>
nmap <leader>ir :VimspectorReset<CR>
nmap <leader>ie :VimspectorEval
nmap <leader>iw :VimspectorWatch
nmap <leader>io :VimspectorShowOutput
nmap <leader>ii <Plug>VimspectorBalloonEval
xmap <leader>ii <Plug>VimspectorBalloonEval
let g:vimspector_install_gadgets = [ 'vscode-node-debug2' ]
let g:vimspector_base_dir = expand("$XDG_CONFIG_HOME/vimspector-config")
" }}}

" Plugin Config lewis6991/gitsigns.nvim {{{
lua << EOF
  require('gitsigns').setup()
EOF
" }}}

" Plugin Config nvim-treesitter/nvim-treesitter {{{
lua << EOF
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'typescript', 'query', 'markdown', 'javascript', 'json', 'vim' },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = { enable = true }
})
EOF
" }}}

" Plugin Config xiyaowong/nvim-transparent {{{
lua << EOF
require("transparent").setup({
  extra_groups = { -- table/string: additional groups that should be cleared
    -- In particular, when you set it to 'all', that means all available groups

    -- example of akinsho/nvim-bufferline.lua
    "BufferLineTabClose",
    "BufferlineBufferSelected",
    "BufferLineFill",
    "BufferLineBackground",
    "BufferLineSeparator",
    "BufferLineIndicatorSelected",
  },
  exclude_groups = {}, -- table: groups you don't want to clear
})
EOF
"}}}

" https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
" vim: filetype=vim foldmethod=marker foldlevel=0 foldcolumn=3
