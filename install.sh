set -e

COLOR="\033[0;33m"
ERROR_COLOR="\033[0;31m"
END_COLOR="\033[0m"

echo $COLOR"Installing Jiraffe"$END_COLOR
if [ -z "${1}" ]; then
    echo $ERROR_COLOR"a valid jira ID is required.$END_COLOR example: ./install_jiraffe.sh aabdala"
    exit
fi

JIRA_ID=${1}
echo $COLOR"jira user: $JIRA_ID"$END_COLOR

J_HOME=~/.jiraffe

if [ -d "$J_HOME" ]; then
  echo $ERROR_COLOR"You already have Jiraffe installed.$END_COLOR  You'll need to remove $J_HOME if you want to install it again"
  exit
fi

echo $COLOR"Cloning Jiraffe$END_COLOR"
hash git >/dev/null 2>&1 && /usr/bin/env git clone -q git@github.com:matiasbargas/jiraffe.git $J_HOME || {
  echo $ERROR_COLOR"git not installed$END_COLOR"
  exit
}

if [ -f "$HOME/.profile" ]; then
  HOME_RC=$HOME/.profile
elif [ -f "$HOME/.zshrc" ]; then
  HOME_RC=$HOME/.zshrc
elif [ -f "$HOME/.bashrc" ]; then
  HOME_RC=$HOME/.bashrc
else
  echo $ERROR_COLOR"no valid ._rc file where found. Need to configure env vars$END_COLOR "
  exit
fi


echo $COLOR"installing in : $J_HOME$END_COLOR"

JIRAFFE_RC=$J_HOME/.jirafferc

echo "export JIRA_ID=$JIRA_ID" > $JIRAFFE_RC
echo "export JIRAFFE_HOME=$J_HOME" >> $JIRAFFE_RC
echo "export PATH=\$JIRAFFE_HOME:\$PATH" >> $JIRAFFE_RC
echo "export PYTHONPATH=\$PYTHONPATH:\$JIRAFFE_HOME/client" >> $JIRAFFE_RC

echo $COLOR"adding reference in : $HOME_RC$END_COLOR "
echo "source $J_HOME/.jirafferc" >> $HOME_RC

chmod +x $J_HOME/client/jiraffe

hash `. $HOME_RC` >/dev/null 2>&1 || {
      echo "$ERROR_COLOR Please restart your shell$END_COLOR "
      exit 1
}

if [ -d "$HOME/.oh-my-zsh" ]; then
  export ZSH="$HOME/.oh-my-zsh"
  echo $COLOR"installing zsh autocompletion plugin"$END_COLOR
  cp -r $J_HOME/zsh_plugin/jiraffe $HOME/.oh-my-zsh/plugins/
  sed -i -e "s/^plugins=(\(.*\))/plugins=\(\1 jiraffe\)/g" ~/.zshrc
  hash `. ~/.zshrc` >/dev/null 2>&1 || {
        echo "$ERROR_COLOR Please restart your shell$END_COLOR "
        exit 1
  }
fi

hash jiraffe >/dev/null 2>&1 || {
  echo "$ERROR_COLOR Please restart your shell$END_COLOR "
  exit 1
}

echo $COLOR"done"$END_COLOR
