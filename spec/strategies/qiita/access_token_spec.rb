require 'spec_helper'

describe OmniAuth::Strategies::Qiita::AccessToken do
  let(:token) { 'monkey' }
  let(:refresh_body) { MultiJson.encode(:access_token => 'refreshed_foo', :expires_in => 600, :refresh_token => 'refresh_bar') }
  let(:client) do
    OmniAuth::Strategies::Qiita::Client.new('abc', 'def', :site => 'https://api.example.com') do |builder|
      builder.request :url_encoded
      builder.adapter :test do |stub|
        VERBS.each do |verb|
          stub.send(verb, '/token/header') { |env| [200, {}, env[:request_headers]['Authorization']] }
          stub.send(verb, "/token/query?access_token=#{token}") { |env| [200, {}, Addressable::URI.parse(env[:url]).query_values['access_token']] }
          stub.send(verb, '/token/body') { |env| [200, {}, env[:body]] }
        end
        stub.post('/oauth/token') { |env| [200, {'Content-Type' => 'application/json'}, refresh_body] }
      end
    end
  end

  subject { OmniAuth::Strategies::Qiita::AccessToken.new(client, token) }

  describe '#from_hash_with_token' do
    it 'initializes with a Hash' do
      hash = {:access_token => token, :expires_at => Time.now.to_i + 200, 'foo' => 'bar', 'token' => token}
      target = OmniAuth::Strategies::Qiita::AccessToken.from_hash_with_token(client, hash)
      expect(target.token).to eq(token)
      expect(target).to be_expires
      expect(target.params.keys).to include('foo')
      expect(target.params['foo']).to eq('bar')
    end
  end
end
