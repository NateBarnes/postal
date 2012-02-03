# Main class used by client programs

require 'savon'

module Postal
  module Lmapi
    class Driver
      
      DefaultEndpointUrl = "http://www.mymailserver.com/"
      
      def soap_actions
        @client.wsdl.soap_actions
      end
      
      def selectMembers(args)
        response = @client.request :wsdl, :select_members do |soap|
          soap.body = { "FilterCriteriaArray" => {'item' => args} }
        end
        response.to_hash[:select_members_response][:return]
      end
      
      def createSingleMember(email, name, list_name)
        response = @client.request :wsdl, :create_single_member do |soap|
          soap.body = { "EmailAddress" => email,
                        "FullName" => name || "",
                        "ListName" => list_name}
        end
        response.to_hash[:create_single_member_response][:return].to_i
      end
      
      def deleteMembers(args)
        response = @client.request :wsdl, :delete_members do |soap|
          soap.body = { "FilterCriteriaArray" => {'item' => args} }
        end
        response.to_hash[:delete_members_response][:return].to_i
      end
      
      def initialize(wsdl_url = nil, proxy = nil, username = nil, password = nil)
        wsdl_url ||= DefaultEndpointUrl
        @client = Savon::Client.new do |wsdl, http|
          wsdl.document = wsdl_url
          if proxy
            http.proxy = proxy
          end
          if username && password
            http.auth.basic username, password
          end
        end
      end
      
      def updateMemberDemographics(list_name, id, email, demographics)
        response = @client.request :wsdl, :update_member_demographics do |soap|
          soap.body = { "SimpleMemberStructIn" => {
                          'ListName' => list_name,
                          'MemberID' => id,
                          'EmailAddress' => email},
                        "DemographicsArray" => {'item' => demographics} }
        end
        response.to_hash[:update_member_demographics_response][:return]
      end
      
      def selectContent(args)
        response = @client.request :wsdl, :select_content do |soap|
          soap.body = { "FilterCriteriaArray" => {'item' => args} }
        end
        response.to_hash[:select_content_response][:return]
      end  
      
      def selectLists(list_name, site_name)
        response = @client.request :wsdl, :select_lists do |soap|
          soap.body = { "ListName" => list_name,
                        "SiteName" => site_name}
        end
        if response.to_hash[:select_lists_response]
          return response.to_hash[:select_lists_response][:return]
        else
          return nil
        end
      end
      
      def importContent(content_id)
        response = @client.request :wsdl, :import_content do |soap|
          soap.body = { "ContentID" => content_id }
        end
        response.to_hash[:import_content_response][:return]
      end


      def sendMailingDirect(email_addresses=[], member_ids=[], mail)
        response = @client.request :wsdl, :send_mailing_direct do |soap|
          soap.body = { "EmailAddressArray" => {:item => email_addresses},
                        "MemberIDArray" => {:item => member_ids},
                        "MailingStructIn" => mail }
        end
        response.to_hash[:send_mailing_direct_response][:return]
      end

    end
  end
end

