$:.unshift File.dirname(__FILE__) # for use/testing when no gem is installed

# external
require 'logger'

# internal
require 'postal/lmapi/lmapi.rb'
require 'postal/lmapi/lmapi_driver.rb'
require 'postal/lmapi/lmapi_mapping_registry.rb'
require 'postal/base'
require 'postal/content'
require 'postal/list'
require 'postal/member'
require 'postal/mailing'

module Postal
  
  # error classes
  class CouldNotCreateMember < StandardError; end;
  class CouldNotUpdateMember < StandardError; end;
  class CouldNotSendMailing < StandardError; end;
  class WouldDeleteAllMembers < StandardError; end;
  
  VERSION = '0.2.0'
  LOGGER = Logger.new(STDOUT)
  
  DEFAULT_OPTIONS = { :debug => false }
  
  @options = {  :wsdl => nil, 
                :username => nil, 
                :password => nil,
                :proxy => nil }
  @driver = nil
  
  attr_accessor :options
  
  # Make a driver instance available at Postal.driver
  def driver
    unless @driver
      @driver = Postal::Lmapi::Soap.new(@options[:wsdl])
      @driver.options['protocol.http.basic_auth'] << [@options[:wsdl], @options[:username], @options[:password]]
      @driver.options['protocol.http.proxy'] = @options[:proxy]
    end
    return @driver
  end
  
  # make @options available so it can be set externally when using the library
  extend self
  
end
