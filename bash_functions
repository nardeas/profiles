# bash: function to run just before prompt is output
function before_prompt(){
	update_prompt
}

# bash: update prompt to reflect various changes in dev environment
function update_prompt() {
	DEFAULT='\[\e[0m\]'
	BLUE='\[\e[0;34m\]'
	CYAN='\[\e[0;36m\]'
	GREEN='\[\e[0;32m\]'

	PS1="\h:\W"
	IS_GIT=$(ls -la|grep -Ei "\.git$")
	if [[ $IS_GIT ]]; then
		if [[ $(git diff) ]]; then
			COLOR="$CYAN"
			PREFIX="*"
		else
			COLOR="$GREEN"
			PREFIX="~"
		fi
		PS1="$PS1 ${COLOR}[$PREFIX$(git branch --show-current)]${DEFAULT}"
	fi
	if [[ $VIRTUAL_ENV != "" ]]; then
		PS1="${BLUE}{${VIRTUAL_ENV##*/}}${DEFAULT} $PS1"
	fi
	PS1="$PS1\$ "
}

# git: Check git status if current path is a git repository
function gitstatus(){
	IS_GIT=$(ls -la|grep -Ei "\.git$")
	if [[ $IS_GIT ]]; then
		git status
	fi
}

# cd: Change directory hook to always display git status
function cd(){
	builtin cd "$@"
}

# top: Monitor processes by name
function pmon(){
	top $(ps aux|grep $1|awk '{print "-pid "$2}'|xargs)
}

# netstat: List open ports
function lsop(){
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colbold="\033[01;01m";colcyan="\033[01;36m";colgreen="\033[01;32m";colclr="\033[0m"; print colbold "proto: " colclr $1 colgreen " | port: " colclr $4 colcyan " | pid: " colclr $9 colcyan " | name: " colclr procname;  }' | column -t -s "|"
}

# random: Generate random alphanumeric string
function rstr(){
	python -c 'import string,random,sys; print("".join((random.choice(string.ascii_lowercase + string.ascii_uppercase + string.digits) for i in range(int(sys.argv[1])))))' $1
}

# fzf fuzzy finder with ccat
function ffind(){
	result=$(fzf --preview '([[ -f {} ]] && (bat --theme=GitHub --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' "$@")
	echo $result
}

# fzf fuzzy finder and edit with vim
function ffedit(){
	filename=$(ffind "$@")
	nvim $filename
}

# fzf fuzzy finder and less
function ffless(){
	filename=$(ffind "$@")
	less $filename
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
	echo "Cleaning cache files"
	find . -type d -name __pycache__ -exec rm -r -v {} \+ 2>/dev/null
}

# pyenv: activate virtualenv
function workon() {
	pyenv activate $1
}

# pyenv: deactivate virtualenv
function workoff() {
	pyenv deactivate
}
