## setup ##

    $ git clone git://github.com/sugyan/momoclo-timeline.git
    $ cd momoclo-timeline
    $ git submodule update --init
    $ bundle install
    $ foreman start


## database ##

    $ foreman run rake db:migrate
    $ foreman run ./db/seed.rb


## .env example ##

    TWITTER_CONSUMER_KEY=*********************
    TWITTER_CONSUMER_SECRET=****************************************
    SHARED_DATABASE_URL=postgres://localhost/momoclo
    SESSION_SECRET=************

