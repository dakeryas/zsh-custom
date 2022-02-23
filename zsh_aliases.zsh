alias ls='ls --color=always --group-directories-first'
alias ll='ls -lh'
alias lt='ls -lth'
alias pl='print -l'
alias rma='rm -rf *'
alias diff='colordiff'
alias root='root -l'
alias ipython3='ipython3 --pylab'
alias sort='LC_ALL=C sort'
alias mpv='mpv --loop-playlist'
alias par="parallel -k --verbose"

function subMIT(){
	local remote=submit.mit.edu
	if klist | grep -q "Valid";then
		ssh $remote
	else
		kinit -A -f vsibille@LNS.MIT.EDU
		ssh $remote
	fi
}

function xop(){
    parallel xdg-open {} ::: $@
}
