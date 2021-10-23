" Syntax highlighting
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_fenced_languages = [
			\ 'bash=sh', 'c', 'cmake', 'c++=cpp', 'cs', 'csharp=cs',
			\ 'css', 'diff', 'go', 'html', 'java', 'javascript',
			\ 'js=javascript', 'json', 'less', 'make', 'php',
			\ 'python', 'ruby', 'rust', 'scss', 'sh', 'shell=sh',
			\ 'sql', 'viml=vim', 'xml', 'yaml', 'zsh']

" Formatting
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_toc_autofit = 1

setlocal spell spelllang=en_gb
setlocal fo+=a
setlocal formatoptions=tc
