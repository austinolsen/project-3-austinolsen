module UsersHelper

require 'crack' # XML and JSON parsingrequire 'crack/json' # Only JSON parsing
require 'crack/xml'
require 'time'
require 'uri'
require 'openssl'
require 'base64'
require('pp')

def search_items
  search_item = params[:search]
  # Your Access Key ID, as taken from the Your Account page

  # Your Secret Key corresponding to the above ID, as taken from the Your Account page
  secret_key = "7hljoEomUg00rnFeYxLWDq0ZRo6X/H1gi5Bbgxvq"

  # The region you are interested in
  endpoint = "webservices.amazon.com"

  request_uri = "/onca/xml"

  params = {
    "Service" => "AWSECommerceService",
    "Operation" => "ItemSearch",
    "AWSAccessKeyId" => "AKIAIY36EEPI2DZ7GXDQ",
    "AssociateTag" => "project30b-20",
    "SearchIndex" => "All",
    "Keywords" => "#{search_item}",
    "ResponseGroup" => "ItemAttributes,Images"
  }

  # Set current timestamp if not set
  params["Timestamp"] = Time.now.gmtime.iso8601 if !params.key?("Timestamp")

  # Generate the canonical query
  canonical_query_string = params.sort.collect do |key, value|
    [URI.escape(key.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]")), URI.escape(value.to_s, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))].join('=')
  end.join('&')

  # Generate the string to be signed
  string_to_sign = "GET\n#{endpoint}\n#{request_uri}\n#{canonical_query_string}"

  # Generate the signature required by the Product Advertising API
  signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), secret_key, string_to_sign)).strip()

  # Generate the signed URL
  request_url = "http://#{endpoint}#{request_uri}?#{canonical_query_string}&Signature=#{URI.escape(signature, Regexp.new("[^#{URI::PATTERN::UNRESERVED}]"))}"

  puts "Signed URL: \"#{request_url}\""

  response = HTTParty.get "#{request_url}"

  @hash_response = Crack::XML.parse(response.to_s)

  @items_list = @hash_response["ItemSearchResponse"]["Items"]["Item"][0...9]
  render('profile')
  end

  def save_item
    SavedItem.find_or_create_by(title:"#{params["item_title"]}", img:"#{params["item_img"]}", url:"#{params["item_url"]}", price:"#{params["item_price"]}", user_id: current_user[:id])
    redirect_to(user_path(current_user[:id]))
  end

  def delete_item
    item_delete = SavedItem.where(:id => "#{params["id"]}").first
    item_delete.destroy
    redirect_to(user_path(current_user[:id]))
  end


end
