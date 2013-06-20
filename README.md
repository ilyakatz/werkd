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
	
	ssh-keygen
	
- add ssh key to bitbucket
	cd ~/ws
	git clone git@bitbucket.org:katzmopolitan/werkd.git

- install command line tools https://developer.apple.com/downloads/index.action#
- install mysql 
    http://dev.mysql.com/downloads/mysql/
- update paths
    http://stackoverflow.com/questions/10557507/rails-mysql-on-osx-library-not-loaded-libmysqlclient-18-dylib
- install ruby 
	rvm install ruby 2.0.0
- install homebrew http://mxcl.github.io/homebrew/
- brew doctor
- install postgre 
	brew install postgres
- (optional) Git GUI http://www.sourcetreeapp.com/download/

# Work flow

1. Open terminal.app
2. cd ws/werkd
3. Pull the latest code from git repository

	git pull

4 Start server

	foreman start
