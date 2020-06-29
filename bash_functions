# git: Check git status if current path is a git repository
function check_git_status(){
	IS_GIT=$(ls -la|grep -Ei "\.git$")
	if [[ $IS_GIT ]]; then
		git status
	fi
}

# cd: Change directory hook to always display git status
function cd(){
	builtin cd "$@" && check_git_status
}

# top: Monitor processes by name
function pmon(){
	top $(ps aux|grep $1|awk '{print "-pid "$2}'|xargs)
}

# random: Generate random alphanumeric string
function rstr(){
	python -c 'import string,random,sys; print("".join((random.choice(string.ascii_lowercase + string.ascii_uppercase + string.digits) for i in range(int(sys.argv[1])))))' $1
}

# fzf fuzzy finder with ccat
function ffind(){
	result=$(fzf --preview '([[ -f {} ]] && (bat --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' "$@")
	echo $result
}

# fzf fuzzy finder and edit with vim
function ffedit(){
	filename=$(ffind "$@")
	nvim $filename
}

# find-in-file - usage: fif <SEARCH_TERM>
function fif() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!";
    return 1;
  fi
  rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}"
}

# python: clean cache files
function pyclean(){
	find . -type d -name __pycache__ -exec rm -r -v {} \+ 2>/dev/null
}
