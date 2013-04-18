# Enrar

Who doesn't love the simplicity of working with Rails and ActiveRecord when you have to touch a database?  Unfortunately, there are times that you have to use a database and _don't_ get to work in Rails.  This gem tries to make your life a little bit easier by providing a lot of the Rails-y/ActiveRecord goodness without all the Rails.

There are a few opinions that Enrar holds onto from Rails that tend to not be a problem, but that you should be aware of:

1. The default location for you database configuration is in PROJECT\_ROOT/config/database.yml.  If that's where you've got it, you're all set from the get-go.
2. Your migrations will get placed in PROJECT\_ROOT/db/migrate.  This is non-negotiable at the moment.
3. Your schema.rb will get placed in PROJECT\_ROOT/db.  This is also non-negotiable.

## Installation

Add this line to your application's Gemfile:

    gem 'enrar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install enrar

## Usage

After you've added Ernar to your project, add the following lines to your Rakefile:

    require 'enrar/task'
    Enrar.initialize! # Connect to DB
    Enrar::Task.new # Generate the Rake tasks

Then you can run around almost as if you're in Rails-land.

    $ rake 'enrar:db:migrations:generate[migration_name]' 
    $ # The quotes are necessary if you're in zsh.  You can leave them off in you're in bash.

    $ rake 'enrar:db:migrate'
    $ rake 'enrar:db:version'

Additionally, you can use Enrar in your code to manage the ActiveRecord configurations.

    #!/usr/bin/env ruby
    require 'enrar'

    Enrar.initialize!
    # From here on out, ActiveRecord::Base is setup with ENRAR_ENV as the environment 
    # and ActiveRecord::Base.configurations is defined as expected.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
