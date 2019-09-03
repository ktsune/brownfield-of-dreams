# Brownfield Of Dreams

Brownfield of Dreams is a Ruby on Rails application used to organize YouTube content used for online learning. Each tutorial is a playlist of video segments. Within the application an admin is able to create tags for each tutorial in the database. A visitor or registered user can then filter tutorials based on these tags.

A visitor is able to see all of the content on the application but in order to bookmark a segment they will need to register. Once registered a user can bookmark any of the segments in a tutorial page.

### Intent
---

This group project was completed in 10 days as a requirement for Module 2 at Turing School of Software and Design.

The project was built using Rails which implements the following:

- consume a JSON API
- Build an app that authenticates using OAuth
- Make API calls to an authenticated API
- Build on top of brownfield code
- Empathy for developers facing deadlines
- Empathy for teammates that might work with your code in the future (or future you!)
- Prioritize what code is relevant to your immediate task (and ignore the rest)
- Send email from a Rails application

### Contributors

- Sarah Tatro 
- Aurie Gochenour 

### GitHub Repository

https://github.com/ktsune/brownfield-of-dreams

### Instructions 

Clone down the repo
```
$ git clone
```

Install the gem packages
```
$ bundle install
```

Install node packages for stimulus
```
$ brew install node
$ brew install yarn
$ yarn add stimulus
```

Set up the database
```
$ rake db:create
$ rake db:migrate
$ rake db:seed
```

Run the test suite:
```ruby
$ bundle exec rspec
```

## Technologies
* [Stimulus](https://github.com/stimulusjs/stimulus)
* [will_paginate](https://github.com/mislav/will_paginate)
* [acts-as-taggable-on](https://github.com/mbleigh/acts-as-taggable-on)
* [webpacker](https://github.com/rails/webpacker)
* [vcr](https://github.com/vcr/vcr)
* [selenium-webdriver](https://www.seleniumhq.org/docs/03_webdriver.jsp)
* [chromedriver-helper](http://chromedriver.chromium.org/)

### Versions
* Ruby 2.4.1
* Rails 5.2.0
