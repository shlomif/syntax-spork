" Vim syntax plugin.
" Language:	Spork
" Filenames:    slides
" Maintainer:	shlomif <shlomif@cpan.org>
" Version:	0.1
" Last Change:  2005 Nov 11 - very, very, very beta release
" Description:	Long description.
" License:	Unknown - see
" https://github.com/statico/dotfiles/blob/master/.vim/syntax/spork.vim
" Location:	syntax/spork.vim
" Website:	https://github.com/shlomif/syntax-spork
"
" See spork.txt for help. This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help spork

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" TODO remove when releasing
syntax clear
if version < 600
  syntax clear
"elseif exists("b:current_syntax")
"  finish
endif

syn cluster kwikiStylers contains=waflPhrase,kwikiHyper,kwikiLink,kwikiStrong,kwikiEmphasize,kwikiUnderline,kwikiInline,kwikiDelete,kwikiDash,kwikiMistake

syn match sporkMore         "^+" contained

syn match kwikiHead         "^=\{1,6}\s\+.*$"
syn match kwikiPre          "^+\?\s.*$" contains=sporkMore
syn match kwikiComment      "^#\s.*$" contains=kwikiTodo
syn keyword kwikiTodo       contained TODO FIXME XXX NOTE
syn match kwikiItem         "^+\?[*0]\+" contains=sporkMore
syn match KwikiTable        "^|.*|$" contains=@kwikiStylers
syn match kwikiStrong       "^\@<![^\w]\@=\*.\{-1,}\*[^\w]\@=" contains=@kwikiStylers
syn match kwikiEmphasize    "^\@<![^\w\/]\@=\/.\{-1,}\/[^\w]\@=" contains=@kwikiStylers
syn match kwikiUnderline    "^\@<![^\w]\@=_.\{-1,}_[^\w]\@=" contains=@kwikiStylers
syn match kwikiInline       "^\@<![^\w]\@=\[=.\{-1,}\]\([^\w]\|$\)\@="
syn match kwikiDelete       "^\@<![^\w]\@=-.\{-1,}-[^\w]\@=" contains=@kwikiStylers

syn match kwikiDash         "---\?"
syn match kwikiDash         "^-\{4,\}\s*$"
syn match kwikiLine         "^----\+\s*$"
syn match kwikiMistake      "^-\{1,3\}\s*$"

syn match kwikiHyper        "\w\@<!http:\/\/([\w\.]\+@)\?([\w\.]\+:)\?[\w\.%\/]\+"

" asis

"syn region kwikiLink    start="\[\{1,2}" end="\]\{1,2}"
" url, title
" forcedlink
" hyperlink
" titledhyperlin
" wikilink
" titledwikilink
" maillink
" titledmaillink

syn include @YAML <sfile>:p:h/yaml.vim
syn region sporkConfig      matchgroup=sporkYAMLSection start="\%^----\+\s*$" end="^----\+\s*$" contains=@YAML keepend
syn region sporkWaflPhrase  matchgroup=sporkYAMLSection start="{" skip="\\}" end="}" contains=@YAML oneline

" Define the default highlighting.
" For version 5.7 and earlier: only when not done already
" For version 5.8 and later: only when an item doesn't have highlighting yet
if version >= 508 || !exists("did_spork_syntax_inits")
  if version < 508
    let did_spork_syntax_inits = 1
    command -nargs=+ HiLink hi link <args>
  else
    " TODO - remove ! below
    command -nargs=+ HiLink hi! def link <args>
  endif

  HiLink kwikiTodo              Todo
  HiLink kwikiLine              Operator
  HiLink kwikiHead              Function
  HiLink kwikiPre               PreProc
  HiLink kwikiComment           Comment
  HiLink kwikiItem              Label

  HiLink kwikiTable             NonText

  HiLink kwikiIndent            Number
  HiLink kwikiDef               Special
  HiLink kwikiLink              Identifier
  HiLink kwikiHyper             Identifier

  HiLink kwikiDash              NonText

  HiLink kwikiMistake           Error

  HiLink sporkMore              MoreMsg
  HiLink sporkYAMLSection       Operator
  HiLink sporkMistake           Error

  HiLink kwikiInline            PreProc
  hi def kwikiStrong    term=bold cterm=bold gui=bold
  hi def kwikiEmphasize term=italic cterm=italic gui=italic
  hi def kwikiUnderline term=underline cterm=underline gui=underline
  hi def kwikiDelete    term=standout cterm=standout gui=standout

  delcommand HiLink
endif

let b:current_syntax = "spork"

let &cpo = s:save_cpo
unlet s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
