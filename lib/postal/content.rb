module Postal
  class Content
    
    class << self
      
      def find_by_filter(*args)
        unless args.find { |arg| arg.match(/ListName/) }
          args << "ListName=#{Postal.options[:list_name]}"
        end
        if soap_contents = Postal.driver.selectContent(args)
          contents = soap_contents.collect do |content|
            puts content.inspect
            Content.new(:content_id => content.contentID,
                        :date_created => content.dateCreated, 
                        :description => content.description, 
                        :doc_parts => content.docParts, 
                        :doc_type => content.docType,
                        :header_from => content.headerFrom,
                        :header_to => content.headerTo,
                        :is_read_only => content.isReadOnly,
                        :is_template => content.isTemplate,
                        :list_name => content.listName,
                        :native_title => content.nativeTitle,
                        :site_name => content.siteName,
                        :title => content.title)
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
