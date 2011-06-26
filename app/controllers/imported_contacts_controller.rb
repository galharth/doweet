class ImportedContactsController < ApplicationController
require 'net/http'
require 'net/https'
require 'uri'
#THIS METHOD TO SEND USER TO THE GOOGLE AUTHENTICATION PAGE.
 def authenticate
  # initiate authentication w/ gmail
  # create url with url-encoded params to initiate connection with contacts api
  # next - The URL of the page that Google should redirect the user to after authentication.
  # scope - Indicates that the application is requesting a token to access contacts feeds.
  # secure - Indicates whether the client is requesting a secure token.
  # session - Indicates whether the token returned can be exchanged for a multi-use (session) token.
  next_param = "http:// localhost:3000/home/newsfeed"
  scope_param = "http://www.google.com/m8/feeds/contacts/userID/projection"
  session_param = "1"
  root_url = "http://www.google.com/accounts/AuthSubRequest"
  #TO FIND MORE AOBUT THESE PARAMTERS AND TEHRE MEANING SEE GOOGLE API DOCS.
  query_string = URI.encode("?scope=#{scope_param}&session=#{session_param}&next=#{next_param}")
  redirect_to root_url + query_string
 end
 
  # YOU WILL BE REDIRECTED TO THIS ACTION AFTER COMPLETION OF AUTHENTICATION PROCESS WITH TEMPORARY SINGLE USE AUTH   TOKEN.
 def authorise
  #FIRST SINGEL USE TOKEN WILL BE RECEIVED HERE..
  token = params[:token]
  #PREPAIRING FOR SECOND REQUEST WITH AUTH TOKEN IN HEADER.. WHICH WILL BE EXCHANED FOR PERMANENT AUTH TOKEN.
  uri = URI.parse("http://www.google.com")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  path = '/accounts/AuthSubSessionToken'
  headers = {'Authorization' => "AuthSub token=#{token}"}
  #GET REQUEST ON URI WITH SPECIFIED PATH...
  resp, data = http.get(path, headers)
  #SPLIT OUT TOKEN FROM RESPONSE DATA.
  if resp.code == "200"
    token = ''
    data.split.each do |str|
    if not (str =~ /Token=/).nil?
      token = str.gsub(/Token=/, '')
    end
  end
    return redirect_to(:action => 'import', :token => token)
  else
    redirect_to PLANNER_HOST.to_s + planner_path.to_s
  end
 end
 
  #USING PERMANENT TOKEN IN THIS ACTION TO GET USER CONTACT DATA.
 def import
  # GET http://www.google.com/m8/feeds/contacts/default/base
  token = params[:token]
  uri = URI.parse("https://www.google.com")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  path = "/m8/feeds/contacts/default/full?max-results=10000"
  headers = {'Authorization' => "AuthSub token=#{token}",
  'GData-Version' => "3.0"}
  resp, data = http.get(path, headers)
  # extract the name and email address from the response data
  # HERE USING REXML TO PARSE GOOGLE GIVEN XML DATA
  xml = REXML::Document.new(data)
  contacts = []
  xml.elements.each('//entry') do |entry|
    person = {}
    person['name'] = entry.elements['title'].text
    gd_email = entry.elements['gd:email']
    person['email'] = gd_email.attributes['address'] if gd_email
    @imported_contact = current_user.imported_contacts.create(person)
  end
  redirect_to applications_planner_path
 end
 end