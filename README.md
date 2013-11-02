WeRKD

Where creative folks come to shmooze

# Environment setup

1. Install git http://git-scm.com/download/mac

1. Install ruby manager
   - [rvm](https://rvm.io)
   - [rbenv](https://github.com/sstephenson/rbenv)
1. Create ssh keys

    `ssh-keygen`

1. add ssh key to bitbucket

    `cd ~/ws`

    `git clone git@bitbucket.org:katzmopolitan/werkd.git`
    `

1. Install [command line tools](https://developer.apple.com/downloads/index.action)
1. Install ruby

    `rvm install ruby 2.0.0`

    or

    `rbenv install 2.0.0`

1. Install [homebrew](http://mxcl.github.io/homebrew/)

## Local dns

1. Add this to /etc/hosts

     `127.0.0.1 localhost`

1. (optional) Git GUI http://www.sourcetreeapp.com/download/
1. Set up [heroku environment](https://toolbelt.heroku.com/)


## Datastore

1. Set up postgres

   `brew install postgres`

   `createuser werkd_dev --createdb`

   `createuser werkd_test --createdb`

1. Install redis

   `brew install redis`

1. Migrate databases

    `rake  db:migrate`

    `RAILS_ENV=test rake db:migrate`

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

1. Run tests

    `spring cucumber features`

    `spring rspec spec`

    `bundle exec guard-jasmine --server-timeout=90 -t 30000`

# In the wild

You can access your server from the outside world:

1. gem install proxylocal

## Heroku prerequisites

- Add heroku remote repostory

`git remote add heroku git@heroku.com:werkd.git`

2. proxylocal 5000 --host \`scutil --get LocalHostName | perl -ne 'print $_ if s/(.*)/\L$1/'\`

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

Install sublime
- If you have sublime, createa link

ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/sublime

- Open ~/.bash_profile and add this line

export EDITOR=/usr/local/bin/sublime

- Close terminal window and restart it
-
