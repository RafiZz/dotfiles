# .bash_profile

. ~/.colorsrc 

# Get the aliases and functions
if [ -f ~/.bashrc ]; 
    then
	. ~/.bashrc
fi

# User specific environment and startup programs
#PATH=$PATH:$HOME/bin
#export PATH

# Set git autocompletion and PS1 integration                                                                                                                                      
if [ -f /etc/bash_completion.d/git ]; 
    then                                                                                                                                        
	. /etc/bash_completion.d/git                                                                                                                                              fi
                                                                                                                                                                            
GIT_PS1_SHOWDIRTYSTATE=true
OMPT_COMMAND='history -a'

shopt -s histappend