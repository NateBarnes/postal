require 'test_helper'

class ContentTest < Test::Unit::TestCase
  
  @config = nil

  def setup
    load_config
    #Postal.options[:list_name] = 'active-casting'
    #Postal.options[:proxy] = "http://localhost:8888/"
  end
  
  def test_selecting_all_content
    content = Postal::Content.find_all
    assert_not_nil content
  end
  
  def test_finding_content_by_filter
    assert_not_nil content = Postal::Content.find_by_filter()
  end
  
end