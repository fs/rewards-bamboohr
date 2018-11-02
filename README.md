# Rewards Bamboohr extension

This is a ruby library to install on Daily Heroku Scheduler.
It will create Reward Bonus for each birthday user.
Birthday determined from BambooHR API.

## Install

```
# Create Heroku app
heroku create rewards-bamboohr

# Create Heroku Scheduler
heroku addons:create scheduler:standard

# Open Heroku Scheduler and create daily job with `bin/rake rewards:give_bonus`
heroku addons:open scheduler

# Create Rollbar addon to track exceptions
heroku addons:create rollbar:free

# Create Little Snitch to track daily execution
# And configure it to define `SNITCH_DAILY`
heroku addons:create deadmanssnitch

# Configure following ENV variables
heroku config:set ROLLBAR_ENV=production
heroku config:set SNITCH_DAILY=
heroku config:set BAMBOOHR_SUBDOMAIN=
heroku config:set BAMBOOHR_API_KEY=
heroku config:set REWARDS_BASE_URI=http://rewards.flatstack.com/api/v1
heroku config:set REWARDS_BOT_NAME=
heroku config:set REWARDS_BOT_PASSWORD=
heroku config:set REWARDS_TEMPLATE="+1000 Happy Birthday @%{username}"
```

## Quality tools

* `bin/quality` based on [RuboCop](https://github.com/bbatsov/rubocop)
* `.rubocop.yml` describes active checks

## Develop

`bin/build` checks your specs and runs quality tools

## Credits

Ruby Base is maintained by [Timur Vafin](http://github.com/timurvafin).
It was written by [Flatstack](http://www.flatstack.com) with the help of our
[contributors](http://github.com/fs/ruby-base/contributors).


[<img src="http://www.flatstack.com/logo.svg" width="100"/>](http://www.flatstack.com)
