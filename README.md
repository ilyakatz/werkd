WeRKD

Where creative folks come to shmooze

# Tests

https://www.codeship.io/projects/4271

# In the wild

You can access your server from the outside world:

1. gem install proxylocal

2. proxylocal 5000 --host \`scutil --get LocalHostName | perl -ne 'print $_ if s/(.*)/\L$1/'\`
