# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# Colors from http://wiki.archlinux.org/index.php/Color_Bash_Prompt
# misc
NO_COLOR='\e[0m' #disable any colors
# regular colors
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'
# emphasized (bolded) colors
EBLACK='\e[1;30m'
ERED='\e[1;31m'
EGREEN='\e[1;32m'
EYELLOW='\e[1;33m'
EBLUE='\e[1;34m'
EMAGENTA='\e[1;35m'
ECYAN='\e[1;36m'
EWHITE='\e[1;37m'
# underlined colors
UBLACK='\e[4;30m'
URED='\e[4;31m'
UGREEN='\e[4;32m'
UYELLOW='\e[4;33m'
UBLUE='\e[4;34m'
UMAGENTA='\e[4;35m'
UCYAN='\e[4;36m'
UWHITE='\e[4;37m'
# background colors
BBLACK='\e[40m'
BRED='\e[41m'
BGREEN='\e[42m'
BYELLOW='\e[43m'
BBLUE='\e[44m'
BMAGENTA='\e[45m'
BCYAN='\e[46m'
BWHITE='\e[47m'

## Aliases

alias nri='rm -rf node_modules/; npm i'
alias nril='rm -rf node_modules/ package-lock.json; npm i'
alias nrii='rm -rf node_modules/; npm i --ignore-scripts'
alias tri='rm -rf .terraform/; terraform init'

alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gcm='git checkout master'

alias jcurl='curl -H "Content-Type: application/json" -H "Accept: application/json"'

function gc() {
	git commit -v -m "$*"
}
function gac() {
	git add -A :/
	git commit -v -m "$*"
}

# configure completion for aliases
if [ "`type -t __git_complete`" = "function" ]; then
	__git_complete ga _git_add
	__git_complete gd _git_diff
	__git_complete gdc _git_diff
	__git_complete gl _git_log
fi

function whichNode() {
	nvm current
	return 0;
}
function whichTT() {
	tt workspace current | awk '{print $1}'
}

## Environment Variables

# Update the command prompt to be <user> <nvm version> <current_directory> (git_branch) ~

case "$OSTYPE" in
	darwin*)
		PS1="\n\[$GREEN\]\u \[$CYAN\]\$(whichNode) \[$YELLOW\]\w\[$EWHITE\]\$(__git_ps1) \[$NO_COLOR\]\n$ "
		;;
	linux*)
		PS1="\n\[$GREEN\]\u \[$CYAN\]n:\$(whichNode) \[$NO_COLOR\]| \[$MAGENTA\]tt:\$(whichTT) \[$NO_COLOR\]| \[$YELLOW\]\w\[$EWHITE\]\$(__git_ps1) \[$NO_COLOR\]\n$ "
		;;
esac

function ecr_login() {
	PROFILE=${1:-default}
	REGION=${AWS_DEFAULT_REGION:-us-east-1}
	AWS_ACCOUNT_ID=$(aws --profile ${PROFILE} sts get-caller-identity --query 'Account' --output text)

	aws --profile ${PROFILE} --region ${REGION} ecr get-login-password \
	       	| docker login \
	        --password-stdin \
		--username AWS \
	        "${AWS_ACCOUNT_ID}.dkr.ecr.${REGION}.amazonaws.com"
}

function vid2gif() {
	INPUT=$1
	OUTPUT=$(basename $INPUT)
	ffmpeg -t 30 -i $INPUT -vf "fps=30,scale=1024:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "${OUTPUT%%.*}.gif"
}

alias python="python3"
