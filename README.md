# SimpleAttributeMapper

Maps attributes values from one object to another

## Installation

Add this line to your application's Gemfile:

    gem 'simple_attribute_mapper'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_attribute_mapper

## Usage

```
class Person
  include Virtus

  attribute :first_name, String
  atrribute :last_name, String
  attribute :email, String
  attribute :home_phone, String
  attribute :mailing_address, String
end

class User < ActiveRecord::Base
  # first_name
  # last_name
  # user_name
  # phone_number
  # street
  # city
  # state
  # zip
end
```

first_name and last_name will be automatically mapped

specify additional mappings, i.e. user_name -> email

```
user = User.find(0000)
user.user_name # => "test@example.com"
mapper = SimpleAttributeMapper::Mapper.new({:user_name => :email})
person = mapper.map(user, Person) # returns a new instance of Person
person.email # => "test@example.com"
```

Typically you won't create instances of SimpleAttributeMapper::Mapper in your code, instead you will configure all mappings and use `SimpleAttributeMapper.map`, see below

### Configuration

```
# in rails: config/initializers/simple_attribute_mapper_config.rb
SimpleAttributeMapper.configure do |config|
  config << SimpleAttributeMapper.from(User).to(Person).with({:user_name => :email}).with({:phone_number => :home_phone})
end

# use later in application to map 
user = User.find(0000)
person = SimpleAttributeMapper.map(user, Person)

```

### Mapping options

```
# default, maps all matching attributes
SimpleAttributeMapper.from(User).to(Person)

# map source to target
SimpleAttributeMapper.from(User).to(Person).with({:user_name => :email})

# map nested source to target
# use array; i.e. User#mailing_address -> Address#country -> Country#name
SimpleAttributeMapper.from(User).to(Person).with({[:mailing_address, :country, :name] => :country_name})

# map composite source to target
# use lambda
SimpleAttributeMapper.from(User).to(Person).with({ lambda { |source| "#{source.street}\n#{source.city}, #{source.state}\n#{source.zip}" } => :mailing_address})
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
