let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
      \ 'name': 'manpage',
      \ 'hooks': {},
      \ 'action_table': {'*': {}},
      \ }

function! s:unite_source.hooks.on_init(args, context)
  let s:beforecolor = get(g:, 'colors_name', 'default')
endfunction

function! s:unite_source.hooks.on_close(args, context)
  if s:beforecolor == g:colors_name
    return
  endif
  execute s:manpage(s:beforecolor)
endfunction

let s:unite_source.action_table['*'].preview = {
      \ 'description' : 'open this manpage',
      \ 'is_quit' : 0,
      \ }

function! s:unite_source.action_table['*'].preview.func(candidate)
  execute a:candidate.action__command
endfunction

function! s:manpage(x)
  return printf("%s %s", "Man", a:x)
endfunction

function! s:unite_source.gather_candidates(args, context)
  " [(name, path)]
  " e.g. [('adaryn', '/Users/ujihisa/.vimbundles/ColorSamplerPack/colors/adaryn.vim'), ...]

  let l:manpages = system("apropos . | awk \'{print $1}\'")

  let manpageslist = unite#util#sort_by(unite#util#uniq_by(
      \ map(split(l:manpages, '\n'),
      \'[fnamemodify(v:val, ":t:r"), fnamemodify(v:val, ":p")]'), 'v:val[0]'),
      \'v:val[0]')

  " "action__type" is necessary to avoid being added into cmdline-history.
  return map(manpageslist, '{
        \ "word": v:val[0],
        \ "source": "manpage",
        \ "kind": ["file", "command"],
        \ "action__command": s:manpage(v:val[0]),
        \ "action__type": ": ",
        \ "action__path": v:val[1],
        \ "action__directory": fnamemodify(v:val[1], ":h"),
        \ }')
endfunction

function! unite#sources#manpage#define()
  return s:unite_source
endfunction


"unlet s:unite_source

let &cpo = s:save_cpo
unlet s:save_cpo
