export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="bira"
plugins=(git docker kubectl aws brew docker-compose go golang helm iterm2)

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH
source $ZSH/oh-my-zsh.sh

# No exit on ctrl+d
set -o ignoreeof

# hstr
export HISTFILE=~/.zsh_history
export HSTR_CONFIG=prompt-bottom,keywords-matching,raw-history-view
export HSTR_PROMPT="bck-i-search: "
bindkey -s "\C-r" "\eqhstr\n"

# direnv
eval "$(direnv hook zsh)"

export HISTSIZE=10000  # how many lines of history to keep in memory
export SAVEHIST=10000  # how many lines to keep in the history file

# colordiff
function diff {
     colordiff -u "$@" | less
}

# k8s PS1
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_PREFIX=' ['
export KUBE_PS1_SUFFIX=']'
export KUBE_PS1_CTX_COLOR=cyan
export KUBE_PS1_NS_COLOR=blue

# Hack zsh bira prompt to prettify virtualenv, kube-ps1 and git.
prompt_git() {
  # based on agnoster
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    setopt promptsubst
    autoload -Uz vcs_info
    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }"
  fi
}
export VIRTUAL_ENV_DISABLE_PROMPT=1
local pythonenv='`[ -z "$VIRTUAL_ENV" ] || echo "(${VIRTUAL_ENV##*/}) "`'
local kubeenv='' #local kubeenv='`[ -z "$KUBECONFIG" ] || kube_ps1`'
local git='%F{2}`prompt_git`%f%b'

#PROMPT=" ╭─${pythonenv}${current_dir}${git}${kubeenv}
# ╰─ᐅ "
PROMPT="%B%F{1}❯%F{3}❯%F{2}❯%f%b ${pythonenv}${current_dir}${git}${kubeenv} ❯ "

function iterm2_print_user_vars() {
    iterm2_set_user_var kubecontext $(kubectl config current-context)
    iterm2_set_user_var kubens $(kubectl config view --minify --output 'jsonpath={..namespace}')
}
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

source ~/.commonshellrc

export PATH="/usr/local/sbin:$PATH"

# GO
export GOPATH="$HOME/Dev"


# Ben's Bash Profile Stuff

################################################################################
#                          Bash
################################################################################
declare -x CLICOLOR="" # enables color
declare -x LSCOLORS="exExDxdxbxegedabagacad"

################################################################################
#                          Colors
################################################################################
# see: http://linux.101hacks.com/ps1-examples/prompt-color-using-tput/

# declare -x BASH_COMPLETION_DEBUG=true
if [ -f /usr/local/etc/bash_completion ]; then
  . /usr/local/etc/bash_completion
fi

export RED='\033[0;31m'
export NC='\033[0m' # No Color

export NLS_LANG=AMERICAN_AMERICA.US7ASCII

export HOTRED="\[\033[1;31m\]"
export HOTBLK="\[\033[1;30m\]"
export REGRED="\[\033[0;31m\]"
export COLRCL="\[\033[0m\]"

export HOTPNK="\033[1;31m"
export HOTBLK2="\033[1;30m"
export HOTRED2="\033[1;31m"
export REGRED2="\033[0;31m"


export HOTRED="\[\033[1;34m\]"
export HOTBLK="\[\033[1;30m\]"
export REGRED="\[\033[0;34m\]"
export COLRCL="\[\033[0m\]"

export HOTPNK="\033[1;34m"
export HOTBLK2="\033[1;30m"
export HOTRED2="\033[1;34m"
export REGRED2="\033[0;34m"

################################################################################
#                          Emoji
################################################################################

# https://apps.timwhitlock.info/emoji/tables/unicode#block-5-uncategorized

export explosion='\xF0\x9F\x92\xA5'

################################################################################
#                          Utility Functions
################################################################################

####################################
#               Bash
####################################

# Edit Bash Profile then reload it.
alias bp="vim ~/.zshrc; source ~/.zshrc"

# Look through all files recursively and look for the string inside, prints all files with it found.
# `ff "BEGIN RSA PRIVATE KEY"` # ff stands for F@!$ing Find "abc"
alias ff="find ./ -type f -print0 | xargs -0 grep -l"

# prints the above command, `doh display` that command again
alias dd='echo "find ./ -type f -print0 | xargs -0 grep -l "' 
# alias dd='echo "find ./ -type f -print0 | xargs -0 grep -l " | pbcopy' 

# usage `whatson <portnumber>` to find out the process binding a port
whatson() {
  netstat -vanp tcp | grep $1
}

## helper function to have other functions halt execution if an environment variable sent isn't found.
breakFunc() {
    if [[ -z ${!1} ]]; then 
      printf "${explosion} ${RED}$1${explosion} not set,${NC} please fix that first\n"
      return 1;
    fi;
}

#######################################
#         Parallel Bash - Gotta Go Fast
#######################################

# Helper function to run bash function in parallel threads. For example building every repository in a folder.
waitPids() {
    while [ ${#pids[@]} -ne 0 ]; do
        echo "Waiting for pids: ${pids[@]}"
        local range=$(eval echo {0..$((${#pids[@]}-1))})
        local i
        for i in $range; do
            if ! kill -0 ${pids[$i]} 2> /dev/null; then
                echo "Done -- ${pids[$i]}"
                unset pids[$i]
            fi
        done
        pids=("${pids[@]}") # Expunge nulls created by unset.
        sleep 1
    done
    echo "Done!"
}

# Helper Function to run with waitPids, this adds the pid of a command to the list of waits.
addPid() {
    desc=$1
    pid=$2
    echo "$desc -- $pid"
    pids=(${pids[@]} $pid)
}
# Sample Example of how to run parallel bash commands.
# https://stackoverflow.com/questions/1455695/forking-multi-threaded-processes-bash
# Forgot how to write this? `type samplePid` then start writing
samplePid() {
  for i in {2..5}; do
      sleep $i &
      addPid "Sleep for $i" $!
  done
  waitPids
}

## Goes to the directory where the executable is found.
# E.g. `goto helm` changes directory to /usr/local/bin (or wherever it lives)
goto() {
  cd $(which $1 | awk -F '/' '{$(NF--)="";OFS="/"; print $0}')
}
## Copies the shrug ascii text to your clipboard for easy copy pasta
shrug() {
  echo -n '¯\_(ツ)_/¯' | pbcopy
}
## Prints the directory and the size of each folder for debugging where your storage went
# TODO sort by actual Size, not largest number, e.g. 5TB > 6Bytes...
size() {
  du -h -d 1 | sort
}

####################################
#               Kubernetes/aws
####################################

alias k='kubectl'
alias dockerkill="docker ps -a -q | xargs docker rm -f" # Kills all containers
#alias dockerkill="docker ps -a -q | xargs docker rm -f" # Kills all containers
alias dockerhistory="docker history --no-trunc --human --format {{.CreatedBy}}" # run dockerhistory <IMAGE> to view how it was made
alias kk="kubectl config current-context"
alias pods='watch kubectl get po -o=custom-columns=NAME:.metadata.name,STATUS:.status.phase'
#alias useLocal='kubectl config set-context docker-for-desktop'
#alias useLocal='kubectl config set-context docker-desktop'

# removes evicted pods from all namespaces
remove_evicted() {
  kubectl get po -a --all-namespaces -o json | jq  '.items[] | select(.status.reason!=null) | select(.status.reason | contains("Evicted")) | "kubectl delete po \(.metadata.name) -n \(.metadata.namespace)"' | xargs -n 1 bash -c
}

## Looks for ambassador on your default namespace and gets the pod, then port forwards it and opens the ui for you.
ambyadmin() {
  local ambypod=$(kubectl get po | grep ambassador | tail -n 1 | awk -F ' ' '{print$1}')
  echo "forwarding $ambypod"
  open http://localhost:8877/ambassador/v0/diag/
  kubectl port-forward $ambypod 8877
}

kubectldash() {
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml
  kubectl create -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
  kubectl create -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/grafana.yaml
  kubectl create -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
  kubectl create -f https://raw.githubusercontent.com/kubernetes/kops/master/addons/kubernetes-dashboard/v1.6.3.yaml

#  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta1/aio/deploy/recommended.yaml
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
  kubectl proxy &
  kubectl apply -f ~/dev/dashboard-admin.yaml
  dashboardtoken
  open http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
#  kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | awk '/^deployment-controller-token-/{print $1}') | awk '$1=="token:"{print $2}' | head -n 1 | pbcopy
}
killdash() {
  kubectl -n kube-system delete clusterrolebinding heapster

  kubectl -n kube-system delete svc monitoring-influxdb
  kubectl -n kube-system delete deployment monitoring-influxdb

  kubectl -n kube-system delete svc monitoring-grafana
  kubectl -n kube-system delete deployment monitoring-grafana

  kubectl -n kube-system delete svc heapster
  kubectl -n kube-system delete deployment heapster
  kubectl -n kube-system delete serviceaccount heapster

  kubectl -n kube-system delete serviceaccount kubernetes-dashboard
  kubectl -n kube-system delete ClusterRoleBinding kubernetes-dashboard
  kubectl -n kube-system delete deployment kubernetes-dashboard
  kubectl -n kube-system delete svc kubernetes-dashboard

  whatson 8001 | awk '{print $9}' | xargs kill
}
## Generates a kube dashboard token and puts it on your clipboard
dashboardtoken() {
  kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep admin-user | awk '{print $1}') | grep token | tail -n 1 | awk -F ' ' '{print $2}' | pbcopy
}

generateAwsToken ()
{
    breakFunc AWS_ACCOUNT || return 1
    breakFunc AWS_REGION || return 1
    DOCKER_REGISTRY_SERVER=https://${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com;
    DOCKER_PASSWORD=$(aws ecr get-login --region ${AWS_REGION} --registry-ids ${AWS_ACCOUNT} | awk -F ' ' '{ print $6}');
    echo $DOCKER_PASSWORD | pbcopy;
    echo $DOCKER_PASSWORD
}

aws_login()
{
  aws ecr get-login  --registry-ids ${AWS_ACCOUNT} --region ${AWS_REGION} --no-include-email | bash
# Add lines above for each AWS Account
# Alternatively add duplicate lines here by profile `--profile X`.
}

# Nice to have for local enivronment kube cluster
installtiller() {
  kubectl -n kube-system create serviceaccount tiller # Cluster Control Permissions

  kubectl create clusterrolebinding tiller \
    --clusterrole=cluster-admin \
    --serviceaccount=kube-system:tiller # Cluster Control Permissions

  helm init --service-account tiller # Deployment

}

####################################
#               GIT
####################################

alias gitlog='git log --graph --oneline --all'


nonoiamtheauthornow() {
  git commit --amend --reset-author
}

## Lists all remotes and their url for git
remotes() {
 for x in $(git remote); do echo -n "$x "; git remote get-url $x; done
}

################################################################################
#             Additional Files - uncomment to enable, then add to override stuff in here or add more.
################################################################################
 source ~/.bash_personal_preferences # Use for things with a personalized touch or to override this file
