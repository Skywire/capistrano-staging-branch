# Staging Branch

- Gem for capistrano to add a `.branch` file with the name of the branch for this cap deploy

## Add to your project:

Add the following to your project Gemfile

~~~
gem 'capistrano-staging-branch', :git => 'git@github.com:Skywire/capistrano-staging-branch.git', :branch => 'master'
~~~

Then run 

~~~
bundle install
~~~

Add the following to your project Capfile

~~~
require "capistrano/staging-branch"
~~~

# Slack staging Branch

To integrate with skywire slack staging branches add these values to your staging site deployment configs

```
# staging branch config
set :channel, 'slack_channel_name'
set :site, 'staging_site_name' # e.g s1, s2, etc
```
