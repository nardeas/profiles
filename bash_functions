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
function check_git_status(){
	IS_GIT=$(ls -la|grep -Ei "\.git$")
	if [[ $IS_GIT ]]; then
		git status
	fi
}

# python: Create random alphanumeric string
function create_random_string(){
	python -c 'import string,random,sys; print("".join((random.choice(string.ascii_lowercase + string.ascii_uppercase + string.digits) for i in range(int(sys.argv[1])))))' $1
}

# netstat: List open ports
function list_open_ports(){
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colbold="\033[01;01m";colcyan="\033[01;36m";colgreen="\033[01;32m";colclr="\033[0m"; print colbold "proto: " colclr $1 colgreen " | port: " colclr $4 colcyan " | pid: " colclr $9 colcyan " | name: " colclr procname;  }' | column -t -s "|"
}

# bash: Flush DNS cache
function flush_dns_cache(){
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
}

# fzf: fuzzy finder file with ccat
function fuzzy_find_file(){
	result=$(fzf --preview '([[ -f {} ]] && (bat --theme=Nord --style=numbers --color=always {} || cat {})) || ([[ -d {} ]] && (tree -C {} | less)) || echo {} 2> /dev/null | head -200' "$@")
	echo $result
}

# fzf: fuzzy finder and edit with vim
function fuzzy_find_and_edit(){
	filename=$(fuzzy_find_file "$@")
	nvim $filename
}

# fzf: fuzzy finder and less
function fuzzy_find_and_show(){
	filename=$(fuzzy_find_file "$@")
	bat --theme=Nord $filename
}

# fzf: fuzzy finds string in files, usage: fuzzy_find_in_file <search term>
function fuzzy_find_in_file(){
	if [ ! "$#" -gt 0 ]; then
		echo "Need a string to search for!";
		return 1;
	fi
	result=$(rg --files-with-matches --no-messages "$1" | fzf $FZF_PREVIEW_WINDOW --preview "rg --ignore-case --pretty --context 10 '$1' {}")
    echo $result
}

# fzf: fuzzy finds string in files and edit, usage: fuzzy_find_in_file <search term>
function fuzzy_find_in_file_and_edit(){
    filename=$(fuzzy_find_in_file "$@")
    nvim $filename
}

# top: Monitor processes by name
function show_process_by_name(){
	top $(ps aux|grep $1|awk '{print "-pid "$2}'|xargs)
}

# python: clean cache files
function python_clean_cache(){
	echo "Cleaning cache files"
	find . -type d -name __pycache__ -exec rm -r -v {} \+ 2>/dev/null
}
