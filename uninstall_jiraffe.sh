#!/bin/bash

COLOR="\033[0;33m"
ERROR_COLOR="\033[0;31m"
END_COLOR="\033[0m"

JIRAFFE_HOME="$HOME/.jiraffe"
if [ -d "$JIRAFFE_HOME" ] then
  echo $COLOR"removing ~/.jiraffe folder"$END_COLOR
  rm -rf $JIRAFFE_HOME
fi

if [ -f "$HOME/.profile" ]; then
  HOME_RC=$HOME/.profile
elif [ -f "$HOME/.zshrc" ]; then
  HOME_RC=$HOME/.zshrc
elif [ -f "$HOME/.bashrc" ]; then
  HOME_RC=$HOME/.bashrc
else
  echo $ERROR_COLOR"no valid ._rc file where found to unnistal the reference. Need to configure env vars"$END_COLOR
fi

if [ -f "$HOME_RC" ]]; then
  echo $COLOR"removing jiraffe reference in rc file"$END_COLOR
  sed -i -e "s/^source \(.*\).jirafferc//g" $HOME_RC
fi

JIRAFFE_PLUGIN = "$HOME/.oh-my-zsh/plugins/jiraffe"
if [ -d "$JIRAFFE_PLUGIN" ]; then
  echo $COLOR"removing jiraffe zsh plugin"$END_COLOR
  rm -rf $JIRAFFE_PLUGIN
fi

ZSHRC="$HOME/.zshrc"
if [ -f "$ZSHRC" ]; then
  echo $COLOR"removing jiraffe plugin reference in zshrc"$END_COLOR
  sed -i -e "s/^plugins=(\(.*\)jiraffe\(.*\))/plugins=\(\1\2\)/g" $ZSHRC
fi
