call plug#begin('~/.vim/plugged')
Plug 'wakatime/vim-wakatime'


call plug#begin('~/.vim/plugged')
  Plug 'prabirshrestha/vim-lsp'
  Plug 'prabirshrestha/vim-lsp-settings'
call plug#end()

call plug#end()


au User lsp_setup call lsp#register_server({
    \ 'name': 'pyright',
    \ 'cmd': {server_info->['pyright-langserver', '--stdio']},
    \ 'whitelist': ['python'],
    \ })

au User lsp_setup call lsp#register_server({
    \ 'name': 'ts_ls',
    \ 'cmd': {server_info->['typescript-language-server', '--stdio']},
    \ 'whitelist': ['javascript', 'typescript'],
    \ })

let g:lsp_diagnostics_enabled = 1
"let g:lsp_diagnostics_virtual_text_enabled = 1
"let g:lsp_diagnostics_signs_enabled = 1
"let g:lsp_diagnostics_highlights_enabled = 1
"
let g:lsp_settings_filetype_config_enabled = 0


set number

colorscheme unokai
