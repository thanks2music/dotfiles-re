let g:python3_host_prog = expand('~/.anyenv/envs/pyenv/versions/3.6.6/bin/python3')
nmap <silent> <C-u><C-t> :<C-u>Denite filetype<CR>
nmap <silent> <C-u><C-p> :<C-u>Denite file_rec -highlight-mode-insert=Search<CR>
nmap <silent> <C-u><C-b> :<C-u>Denite buffer<CR>
nmap <silent> <C-u><C-j> :<C-u>Denite line<CR>
nmap <silent> <C-u><C-j> :<C-u>Denite line<CR>
nmap <slient> <C-u><C-f> :<C-u>Denite -auto_preview grep<CR>
nmap <silent> <C-u><C-g> :<C-u>Denite grep<CR>
nmap <silent> <C-u><C-]> :<C-u>DeniteCursorWord grep<CR>
nmap <silent> <C-u><C-m> :<C-u>Denite file_mru<CR>
nmap <silent> <C-u><C-y> :<C-u>Denite neoyank<CR>
nmap <silent> <C-u><C-r> :<C-u>Denite -resume<CR>
nmap <silent> <C-u>; :<C-u>Denite -resume -immediately -select=+1<CR>
nmap <silent> <C-u>- :<C-u>Denite -resume -immediately -select=-1<CR>
nmap <silent> <C-u><C-d> :<C-u>call denite#start([{'name': 'file_rec', 'args': ['~/dotfiles']}])<CR>
nnoremap ml :<C-u>call denite#start([{'name': 'file_rec', 'args': [g:memolist_path]}])<CR>
