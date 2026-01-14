# bash: function to run just before prompt is output
function before_prompt(){
	update_prompt
}

# bash: update prompt to reflect various changes in dev environment
function update_prompt() {
	DEFAULT='\[\e[0m\]'
	BLUE='\[\e[0;34m\]'
	GREEN='\[\e[0;32m\]'

	PS1="\h:\W"
	GIT_NAME=$(git_get_repository)
	if [[ $GIT_NAME ]]; then
		if [[ $(git diff) ]]; then
			COLOR="$BLUE"
			PREFIX="*"
		else
			COLOR="$GREEN"
			PREFIX="~"
		fi
		PS1="$PS1 ${COLOR}[$PREFIX$(git branch --show-current)]${DEFAULT}"
	fi
	if [[ $VIRTUAL_ENV != "" ]]; then
        if [[ $VIRTUAL_ENV_PROMPT != "" ]]; then
            PS1="${BLUE}(${VIRTUAL_ENV_PROMPT})${DEFAULT} $PS1"
        else
		    PS1="${BLUE}{${VIRTUAL_ENV##*/}}${DEFAULT} $PS1"
        fi
	fi
	PS1="$PS1\$ "
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

# git: Check if we are inside git repository and output repository name 
function git_get_repository(){
    HAS_GIT=$(which git)
    if [[ $HAS_GIT ]]; then
        git rev-parse --is-inside-work-tree &>/dev/null && echo $(basename $(git rev-parse --show-toplevel))
    fi
}

# git: Check git status if current path is a git repository
function git_get_status(){
	IS_GIT=$(git_get_repository)
	if [[ $IS_GIT ]]; then
		git status
	fi
}

# netstat: List open ports
function list_open_ports(){
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $11 | getline procname;colbold="\033[01;01m";colcyan="\033[01;36m";colgreen="\033[01;32m";colclr="\033[0m"; print colbold "proto: " colclr $1 colgreen " | port: " colclr $4 colcyan " | pid: " colclr $11 colcyan " | name: " colclr procname;  }' | column -t -s "|"
}

# netstat: List open ports with optional grep
function list_open_ports_ext(){
    if [ "$#" -eq 0 ]; then
        list_open_ports
    else
        list_open_ports | grep $*
    fi
}

# top: Monitor processes by name
function show_process_by_name(){
	top $(ps aux|grep $1|awk '{print "-pid "$2}'|xargs)
}

# python: Create random alphanumeric string
function create_random_string(){
	python -c 'import string,random,sys; print("".join((random.choice(string.ascii_lowercase + string.ascii_uppercase + string.digits) for i in range(int(sys.argv[1])))))' $1
}

# python: clean cache files
function python_clean_cache(){
	echo "Cleaning cache files"
	find . -type d -name __pycache__ -exec rm -r -v {} \+ 2>/dev/null
}

# ollama: ask code references
function ask_ollama1(){
    PROMPT="$*\nOnly output the code as raw string, nothing else"
    PAYLOAD="{\"model\": \"deepseek-coder-v2:16b\", \"prompt\": \"$PROMPT\", \"stream\": false}"
    ENDPOINT="http://localhost:11434/api/generate"
    of=$(mktemp) && \
    curl -s $ENDPOINT -d "$PAYLOAD" -H "Content-Type: application/json" | jq .response -r > $of && \
    mdv -t "830.9345" $of && \
    /bin/rm $of
}

# chatgpt: ask anything
function ask_chatgpt1(){
    PROMPT="$*"
    MODEL="gpt-4.1-mini"
    ENDPOINT="https://api.openai.com/v1/responses"
    KEY=$(security find-generic-password -s "OPENAI_API_KEY" -a "$USER" -w) && \
        curl "$ENDPOINT" -s \
             -H "Authorization: Bearer $KEY" \
             -H "Content-Type: application/json" \
             -d '{"model": "'"$MODEL"'", "input": "'"$PROMPT"'", "temperature": 0.7}' | jq -r '.output_text[0]'
}
