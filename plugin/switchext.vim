" switchext.vim - Yuxuan Wang (wang@yuxuan.org)
"
" Switch between source and header files
"
"Usage:
" Set g:switchext_srcext in your vimrc for your source file extension.
" (default is "cpp" if ommited)
" You can map a key to :call SwitchExt() for fast switch
"
" Here's a vimrc example:
"
" let g:switchext_srcext = "cpp"
" map <F3> <ESC>:call SwitchExt()<CR>
"
"Version:
" 2006-04-12 - 0.1 - initial version
" 2018-11-02 - 0.2 - modified version for multiple ext support
" (swhjkl@gmail.com)

function! SwitchExt()
	let s:header_ext_list = ["h", "hpp"]
	let s:src_ext_list = ["cpp", "cc", "cxx", "c"]
	let s:ext = expand('%:e')
	if index(s:header_ext_list, s:ext) >= 0
		let s:ext_list = s:src_ext_list
	elseif index(s:src_ext_list, s:ext) >= 0
		let s:ext_list = s:header_ext_list
	else
		echo "unknown file type"
		return
	endif
	for ext in s:ext_list
		let peer_name = expand('%<') . "." . ext
		if filereadable(peer_name)
			execute "e! " . peer_name
			return
		endif
	endfor
	execute "e! " . expand('%<') . "." . s:ext_list[0]
endfunction

