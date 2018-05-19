" code header
nnoremap <leader><cr> ggO#***************************************************************************<cr>#<cr>#  File: VAR<cr>#  Date created: <C-r>=strftime('%m/%d/%Y')<cr><cr>#  Date edited: <C-r>=strftime('%m/%d/%Y')<cr><cr>#<cr>#  Author: Nathan Martindale<cr>#  Copyright © 2018 Digital Warrior Labs<cr>#<cr>#  Description: VAR<cr>#<cr>#***************************************************************************<cr><esc>gg/VAR<cr>cw

" class
inoremap <leader>c <esc>Iclass <esc>A:<cr><cr>def __init__(self):<cr>pass<cr><cr>

" function
inoremap <leader>f <esc>Idef <esc>A():<cr>pass<esc>k$hi
