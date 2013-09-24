WeRKD

Where creative folks come to shmooze

# Tests

https://www.codeship.io/projects/4271

## Test locally

1. Install spring

    `gem install spring`

1. Install bundler

    `gem install bundler`

1. Install gems

    `bundle install`

1. Install phontom.js (for JS testing)

    `brew install phantomjs`

1. Migrate databases

    `rake db:create db:migrate`

    `RAILS_ENV=test rake db:create db:migrate`

1. Run tests

    `spring cucumber features`

    `spring rspec spec`

# In the wild

You can access your server from the outside world:

1. gem install proxylocal

2. proxylocal 5000 --host \`scutil --get LocalHostName | perl -ne 'print $_ if s/(.*)/\L$1/'\`

# Environment setup

- Install sublime
- If you have sublime, createa link

        ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime

- Open ~/.bash_profile and add this line

        export EDITOR=/usr/local/bin/sublime

- Close terminal window and restart it
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

- Add this to /etc/hosts

    127.0.0.1 localhost

- (optional) Git GUI http://www.sourcetreeapp.com/download/
- Set up heroku environment

      https://toolbelt.heroku.com/

- Add heroku remote repostory

      git remote add heroku git@heroku.com:werkd.git

# Work flow

1. Open terminal.app
2. cd ws/werkd
3. Pull the latest code from git repository

	`git pull`

4. Make sure that all libraries are installed

    `bundle install`

5. Migrate database changes

    `rake db:migrate`

6. Stop server if already running

    `open window where foreman is running`
    `Cntrl-C`

7. Start server

	`foreman start`

8. Open local version

    `http://localhost:5000`

9. Write your code and do your magic!

10. Push your changes back to the repository

    `git add .`

	`git commit -m "brief message about what changes your made"`

	`git push`

    1. If you get a message
	` ! [rejected]        HEAD -> master (non-fast-forward)`
	That means that someone already made changes upstream (bitbucket) and you need to pull then with `git pull`
	2. If there are no conflicts, do `git push` again

# To preview emails in the browser

1. Follow instructions to bring up the server
2. Go to

    `http://localhost:5000/email_preview`

# Other git commands

## When a file is deleted

git rm [path to file]

## When you want to reset all changes made to a file since last commit

git checkout [path to file]
