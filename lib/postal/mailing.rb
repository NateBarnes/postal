module Postal
  class Mailing < Postal::Base
    
    class << self
      
      def import(content_id)
        mail = Mailing.new(Postal.driver.importContent(content_id))
        return mail
      end
      
    end
    
    
    DEFAULT_ATTRIBUTES = {:additional_headers => nil, 
                          :attachments => nil, 
                          :bypass_moderation => nil, 
                          :campaign => nil, 
                          :char_set_id => nil, 
                          :detect_html => nil, 
                          :dont_attempt_after_date => nil, 
                          :enable_recovery => nil, 
                          :from => nil, 
                          :html_message => nil, 
                          :html_section_encoding => nil, 
                          :is_html_section_encoded => nil, 
                          :is_text_section_encoded => nil,
                          :list_name => nil,
                          :recency_number_of_mailings => nil,
                          :recency_which => nil,
                          :reply_to => nil,
                          :resend_after_days => nil,
                          :sample_size => nil,
                          :scheduled_mailing_date => nil,
                          :subject => nil,
                          :text_message => nil,
                          :text_section_encoding => nil,
                          :title => nil,
                          :to => nil,
                          :track_opens => nil,
                          :rewrite_date_when_sent => nil,
                          :mailing => nil }
    
    attr_accessor :additional_headers, 
                  :attachments, 
                  :bypass_moderation, 
                  :campaign, 
                  :char_set_id, 
                  :detect_html, 
                  :dont_attempt_after_date, 
                  :enable_recovery, 
                  :from, 
                  :html_message, 
                  :html_section_encoding, 
                  :is_html_section_encoded, 
                  :is_text_section_encoded,
                  :list_name,
                  :recency_number_of_mailings,
                  :recency_which,
                  :reply_to,
                  :resend_after_days,
                  :sample_size,
                  :scheduled_mailing_date,
                  :subject,
                  :text_message,
                  :text_section_encoding,
                  :title,
                  :to,
                  :track_opens,
                  :rewrite_date_when_sent,
                  :mailing
    
    # Create a new mailing ready to send
    def initialize(args={})
      args = DEFAULT_ATTRIBUTES.merge(args)
      
      @list_name = args[:list_name] || Postal.options[:list_name]
      @to = args[:to] 
      
      if args[:mailing].nil?
        @additional_headers = args[:additional_headers] 
        @attachments = args[:attachments] 
        @bypass_moderation = args[:bypass_moderation] 
        @campaign = args[:campaign] 
        @char_set_id = args[:char_set_id] 
        @detect_html = args[:detect_html] 
        @dont_attempt_after_date = args[:dont_attempt_after_date] 
        @enable_recovery = args[:enable_recovery] 
        @from = args[:from] 
        @html_message = args[:html_message] 
        @html_section_encoding = args[:html_section_encoding] 
        @is_html_section_encoded = args[:is_html_section_encoded] 
        @is_text_section_encoded = args[:is_text_section_encoded]
        @recency_number_of_mailings = args[:recency_number_of_mailings]
        @recency_which = args[:recency_which]
        @reply_to = args[:reply_to]
        @resend_after_days = args[:resend_after_days]
        @sample_size = args[:sample_size]
        @scheduled_mailing_date = args[:scheduled_mailing_date]
        @subject = args[:subject]
        @text_message = args[:text_message]
        @text_section_encoding = args[:text_section_encoding]
        @title = args[:title]
        @to = args[:to]
        @track_opens = args[:track_opens]
        @rewrite_date_when_sent = args[:rewrite_date_when_sent]
        @mailing = args[:mailing]
      else
        @subject = args[:mailing].subject
        @is_html_section_encoded = args[:mailing].is_html_section_encoded
        @html_section_encoding = args[:mailing].html_section_encoding
        @html_message = args[:mailing].html_message
        @char_set_id = args[:mailing].char_set_id
        @is_text_section_encoded = args[:mailing].is_text_section_encoded
        @text_section_encoding = args[:mailing].text_section_encoding
        @title = args[:mailing].title
        @text_message = args[:mailing].text_message
        @attachments = args[:mailing].attachments
        @from = args[:mailing].from
        @additional_headers = args[:mailing].additional_headers
        @mailing = args[:mailing]
      end
    end
    
    
    # Send the mailing
    def send
      if valid?
        
        # are we sending to a list of email addresses or member ids
        case [@to].flatten.first
        when ::String
          emails = [@to].flatten
          member_ids = []
        when ::Fixnum
          emails = []
          member_ids = [@to].flatten
        end
        
        if @mailing.nil?
          mail = { 'AdditionalHeaders' => @additional_headers, 
                   'Attachments' => @attachments, 
                   'BypassModeration' => @bypass_moderation, 
                   'Campaign' => @campaign, 
                   'CharSetID' => @char_set_id, 
                   'DetectHtml' => @detect_html, 
                   'DontAttemptAfterDate' => @dont_attempt_after_date, 
                   'EnableRecovery' => @enable_recovery, 
                   'From' => @from, 
                   'HtmlMessage' => @html_message,
                   'HtmlSectionEncoding' => @html_section_encoding, 
                   'IsHtmlSectionEncoded' => @is_html_section_encoded, 
                   'IsTextSectionEncoded' => @is_text_section_encoded,
                   'ListName' => @list_name,
                   'RecencyNumberOfMailings' => @recency_number_of_mailings,
                   'RecencyWhich' => @recency_which,
                   'ReplyTo' => @reply_to,
                   'ResendAfterDays' => @resend_after_days,
                   'SampleSize' => @sample_size,
                   'ScheduledMailingDate' => @scheduled_mailing_date,
                   'Subject' => @subject,
                   'TextMessage' => @text_message,
                   'TextSectionEncoding' => @text_section_encoding,
                   'Title' => @title,
                   'To' => @to,
                   'TrackOpens' => @track_opens,
                   'RewriteDateWhenSent' => @rewrite_date_when_sent }
          return Postal.driver.sendMailingDirect(emails,member_ids,mail)
        else
          mail = { 'AdditionalHeaders' => @mailing.additional_headers, 
                   'Attachments' => @mailing.attachments, 
                   'BypassModeration' => @mailing.bypass_moderation, 
                   'Campaign' => @mailing.campaign, 
                   'CharSetID' => @mailing.char_set_id, 
                   'DetectHtml' => @mailing.detect_html, 
                   'DontAttemptAfterDate' => @mailing.dont_attempt_after_date, 
                   'EnableRecovery' => @mailing.enable_recovery, 
                   'From' => @mailing.from, 
                   'HtmlMessage' => @mailing.html_message, 
                   'HtmlSectionEncoding' => @mailing.html_section_encoding, 
                   'IsHtmlSectionEncoded' => @mailing.is_html_section_encoded, 
                   'IsTextSectionEncoded' => @mailing.is_text_section_encoded,
                   'RecencyNumberOfMailings' => @mailing.recency_number_of_mailings,
                   'RecencyWhich' => @mailing.recency_which,
                   'ReplyTo' => @mailing.reply_to,
                   'ResendAfterDays' => @mailing.resend_after_days,
                   'SampleSize' => @mailing.sample_size,
                   'ScheduledMailingDate' => @mailing.scheduled_mailing_date,
                   'Subject' => @mailing.subject,
                   'TextMessage' => @mailing.text_message,
                   'TextSectionEncoding' => @mailing.text_section_encoding,
                   'Title' => @mailing.title,
                   'To' => @mailing.to,
                   'TrackOpens' => @mailing.track_opens,
                   'RewriteDateWhenSent' => @mailing.rewrite_date_when_sent,
                   'ListName' => @mailing.list_name || Postal.options[:list_name] }
          return Postal.driver.sendMailingDirect(emails,member_ids,mail)
        end
        
      else  # mail wasn't valid
        return false
      end
    end
    
    
    # same as send() but throws an error instead of just returning false
    def send!
      if id = send
        return id
      else
        raise Postal::CouldNotSendMailing, 'Your mail was invalid and could not be sent.'
      end
    end
    
    alias_method :save, :send
    alias_method :save!, :send!
    
    
    # Determines whether the email is valid to send
    def valid?
      return validate
    end
    
    
    # Determines whether we have everything we need to send an email
    def validate
      return (@list_name && @to && @subject) ? true : false
    end
    
  end
end
