module Postal
  class Content
    
    class << self
      
      def find_by_filter(*args)
        unless args.find { |arg| arg.match(/ListName/) }
          args << "ListName=#{Postal.options[:list_name]}"
        end
        if soap_contents = Postal.driver.selectContent(args)[:item]
          contents = soap_contents.collect do |content|
            Content.new(:content_id => content[:content_id],
                        :date_created => content[:date_created], 
                        :description => content[:description], 
                        :doc_parts => content[:doc_parts], 
                        :doc_type => content[:doc_yype],
                        :header_from => content[:header_from],
                        :header_to => content[:header_to],
                        :is_read_only => content[:is_read_only],
                        :is_template => content[:is_template],
                        :list_name => content[:list_name],
                        :native_title => content[:native_title],
                        :site_name => content[:site_name],
                        :title => content[:title])
          end
          if contents.size == 1
            return contents.first
          else
            return contents
          end
        else
          return nil
        end
      end
      
      
      # really just an alias for find_by_filter but with no options
      def find_all
        find_by_filter
      end
      
    
    end
    
    DEFAULT_ATTRIBUTES = {:content_id => nil,
                          :date_created => nil,
                          :description => nil,
                          :doc_parts => nil,
                          :doc_type => nil,
                          :header_from => nil,
                          :header_to => nil,
                          :is_read_only => nil,
                          :is_template => nil,
                          :list_name => nil,
                          :native_title => nil,
                          :site_name => nil,
                          :title => nil}
    
    attr_accessor :content_id ,:date_created ,:description ,:doc_parts ,:doc_type ,:header_from ,:header_to ,:is_read_only ,:is_template ,:list_name ,:native_title ,:site_name ,:title
    
    
    # Create a new member instance
    def initialize(attributes={})
      attributes = DEFAULT_ATTRIBUTES.merge(attributes)
      @content_id = attributes[:content_id]
      @date_created = attributes[:date_created]
      @description = attributes[:description]
      @doc_parts = attributes[:doc_parts]
      @doc_type = attributes[:doc_type]
      @header_from = attributes[:header_from]
      @header_to = attributes[:header_to]
      @is_read_only = attributes[:is_read_only]
      @is_template = attributes[:is_template]
      @list_name = attributes[:list_name]
      @native_title = attributes[:native_title]
      @site_name = attributes[:site_name]
      @title = attributes[:title]
    end
    
  end
end
