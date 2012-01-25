# Introduction

Postal is a gem for working with the Lyris API. "But the Lyris API is just a SOAP service, why
don't I use something like Soap4r?" Well you could, but it wouldn't be very pretty. When the
interface is created all properties passed to a method are required and always in a certain order.

Postal does use the Soap4r interface behind the scenes but gives you a simple ActiveRecord-like
interface for search and adding records.

## Installation

Get the gem:

  gem sources -a http://gems.github.com
  sudo gem install cannikin-postal
  
Then to use just add the require to your script:

  require 'rubygems'
  require 'postal'
  
## Usage

Postal feels a lot like using ActiveRecord. You create/save new Members, find existing ones, etc.
All of the examples below assume you've already set up Postal with your username, password and WSDL
endpoint, and optionally the name of the list that all operations should use:

  Postal.options[:wsdl] = 'http://mymailserver.com:82/?wsdl'
  Postal.options[:username] = 'username'
  Postal.options[:password] = 'password'
  Postal.options[:list_name] = 'my-test-list'

If you don't set your list name in the options you can pass it in with each method call.

See the /test directory for examples of just about everything you can do with Postal.

### Lists

  # find a list based on its name
  Postal::List.find('my-list-name')
  
### Members

  # add a member to a list (the list saved to Postal.options)
  new_member = Postal::Member.new(:email => "john.doe@anonymous.com", :name => "John Doe")
  id = new_member.save
  # id => 1234567 (the new member_id in Lyris)
  
  # add a member to a specific list and save in one call (both lines are equivalent)
  Postal::Member.new(:email => "john.doe@anonymous.com", :name => "John Doe", :list_name => "new-list").save
  Postal::Member.create(:email => "john.doe@anonymous.com", :name => "John Doe", :list_name => "new-list")
  
Postal also has a `save!` method that throws an error if the person can't be saved, rather than just
returning false.

  # update a member's demographics
  new_member = Postal::Member.new(:email => "john.doe@anonymous.com", :name => "John Doe")
  new_member.save
  new_member.update_attributes(:field_0 => 'Male')
  
  # find a member's id based on an email address
  Postal::Member.find('john.doe@anonymous.com')
  
  # find a member based on member_id
  Postal::Member.find(1234567)
  
  # find a member based on Lyris "filters" (see Lyris API docs for syntax)
  Postal::Member.find_by_filter('EmailAddress like john.doe%')
  
  # delete member(s) based on filters
  Postal::Member.destroy("EmailAddress like john.doe-delete%")
  
### Mailings

  # directly send an email to an array of email addresses
  mail = Postal::Mailing.new( :to => ['john.doe@anonymous.com','jane.doe@anonymous.com'], 
                              :html_message => "<p>Test from Postal at #{Time.now.to_s}</p>", 
                              :text_message => 'Test test from Postal at #{Time.now.to_s}', 
                              :from => 'Postmaster <postmaster@company.com>',
                              :subject => 'Test from Postal')
  mail.valid?
  mail.send
  
Mailings require a couple things to be valid, mainly someone to send to, a subject, and 
the name of a list to send to. `mail.valid?` will return false if any of these do not exist.

## To Do

* Implement wrappers for remaining Lyris methods

## Thanks

Special thanks to this article: http://markthomas.org/2007/09/12/getting-started-with-soap4r/
Mark details how to use Soap4r (for which there is very little documentation in the world) and
his example includes talking to Lyris! Postal probably couldn't have happened without his article.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history. (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009 The Active Network. See LICENSE for details.
