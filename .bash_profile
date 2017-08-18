# .bash_profile

# If coming in over SSH, .profile is not loaded
if [ -f ~/.profile ]; then
 . ~/.profile
fi

# Neither is .bashrc
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

