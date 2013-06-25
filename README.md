I was here

WeRKD

Where creative folks come to shmooze

# Tests

https://www.codeship.io/projects/4271

# In the wild

You can access your server from the outside world:

1. gem install proxylocal

2. proxylocal 5000 --host \`scutil --get LocalHostName | perl -ne 'print $_ if s/(.*)/\L$1/'\`

# Environment setup

- install git http://git-scm.com/download/mac
- install rvm https://rvm.io
- create ssh keys
- add ssh key to bitbucket
- cd ~/ws
- git clone git@bitbucket.org:katzmopolitan/werkd.git
- install command line tools https://developer.apple.com/downloads/index.action#
- install homebrew http://mxcl.github.io/homebrew/

- install mysql http://dev.mysql.com/downloads/mysql/
- install ruby `rvm install ruby 2.0.0`
- install posture http://www.postgresql.org/download/macosx/
