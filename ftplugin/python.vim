" code header
nnoremap <leader><cr> ggO#**************************************************<cr>#  File: VAR<cr>#  Date created: VAR<cr>#  Date edited: VAR<cr>#  Author: Nathan Martindale<cr>#  Copyright © 2018 Digital Warrior Labs<cr>#  Description: VAR<cr>#**************************************************<esc>gg/VAR<cr>cw



" class
inoremap <leader>c <esc>Iclass <esc>A:<cr><cr>def __init__(self):<cr>pass<cr><cr>

" function
inoremap <leader>f <esc>Idef <esc>A():<cr>pass<esc>k$hi