require 'restclient'
require 'openssl'

module RestClient
  def self.ssl_settings
    options = { :verify_ssl => OpenSSL::SSL::VERIFY_PEER }
    if ENV['REST_CLIENT_CERT_FILE_PATH'].present?
      options[:ssl_ca_file] = ENV['REST_CLIENT_CERT_FILE_PATH']
    end
    options
  end

  def self.get(url, headers={}, &block)
    Request.execute(ssl_settings.merge(:method => :get, :url => url, :headers => headers), &block)
  end

  def self.post(url, payload, headers={}, &block)
    Request.execute(ssl_settings.merge(:method => :post, :url => url, :payload => payload, :headers => headers), &block)
  end

  def self.put(url, payload, headers={}, &block)
    Request.execute(ssl_settings.merge(:method => :put, :url => url, :payload => payload, :headers => headers), &block)
  end

  def self.delete(url, headers={}, &block)
    Request.execute(ssl_settings.merge(:method => :delete, :url => url, :headers => headers), &block)
  end
end
