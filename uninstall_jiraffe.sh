#!/bin/bash

COLOR="\033[0;33m"
ERROR_COLOR="\033[0;31m"
END_COLOR="\033[0m"

echo $COLOR"removing ~/.jiraffe folder"$END_COLOR
[[ -d "$JIRAFFE_HOME" ]] && rm -rf $JIRAFFE_HOME

if [ -f "$HOME/.profile" ]; then
  HOME_RC=$HOME/.profile

elif [ -f "$HOME/.zshrc" ]; then
  HOME_RC=$HOME/.zshrc

elif [ -f "$HOME/.bashrc" ]; then
  HOME_RC=$HOME/.bashrc

else
  echo $ERROR_COLOR"no valid ._rc file where found to unnistal the reference. Need to configure env vars"$END_COLOR
fi

echo $COLOR"removing jiraffe zsh plugin"$END_COLOR
JIRAFFE_PLUGIN = "~/.oh-my-zsh/plugins/jiraffe"
[[ -d "$JIRAFFE_PLUGIN" ]]  && rm -rf $JIRAFFE_PLUGIN

ZSHRC="~/.bashrc"

[[ -f "$ZSHRC" ]] && sed -i -e "s/^plugins=(\(.*-jiraffe\))/plugins=\(\1\)/g" ~/.zshrc
