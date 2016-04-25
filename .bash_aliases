## Aliases

alias nri='rm -rf node_modules/; npm i'
alias nrii='rm -rf node_modules/; npm i --ignore-scripts'

alias ga='git add'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
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

## Environment Variables

# Update the command prompt to be <user>:<current_directory>(git_branch) >
# Note that the git branch is given a special color
if [ "$OS" == "Windows_NT" ] ; then
	PS1="\n\[$GREEN\]\u \[$YELLOW\]\w\[$EBLACK\]\$(__git_ps1) \[$NO_COLOR\]\n$ "
else
	PS1="\n\[$GREEN\]\u \[$CYAN\]\$(whichNode) \[$YELLOW\]\w\[$EBLACK\]\$(__git_ps1) \[$NO_COLOR\]\n$ "
fi

