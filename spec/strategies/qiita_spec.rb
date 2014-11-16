require 'spec_helper'

describe OmniAuth::Strategies::Qiita do

  def app
    lambda do |_env|
      [200, {}, ['Hello.']]
    end
  end

  subject do
    args = ['client_id', 'client_secret', @options || {}].compact
    OmniAuth::Strategies::Qiita.new(*args)
  end

  describe 'client options' do

    it 'has correct name' do
      expect(subject.options.name).to eq 'qiita'
    end

    it 'has correct site' do
      expect(subject.options.client_options.site).to eq 'https://qiita.com'
    end

    it 'has correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq '/api/v2/oauth/authorize'
    end

    it 'has correct token url' do
      expect(subject.options.client_options.token_url).to eq '/api/v2/access_tokens'
    end

    context 'when overwrite client_options' do
      let(:api_endpoint) {'https://api.foo.com'}
      let(:authorize_url_endpoint) {"#{api_endpoint}/api/v2/oauth/"}
      let(:token_url_endpoint) {"#{api_endpoint}/api/v2/access_tokens"}

      before do
        @client = OmniAuth::Strategies::Qiita.new('client_secret', 'client_secret', {
          client_options: {
            site: api_endpoint,
            authorize_url: authorize_url_endpoint,
            token_url: token_url_endpoint
          }})
      end
      it 'for site' do
        expect(@client.options.client_options.site).to eq api_endpoint
      end

      it 'for authorize_url' do
        expect(@client.options.client_options.authorize_url).to eq authorize_url_endpoint
      end

      it 'for token_url' do
        expect(@client.options.client_options.token_url).to eq token_url_endpoint
      end
    end
  end

  describe 'skip_info option' do
    context 'when skip_info option is enabled' do
      before do
        subject.options['skip_info'] = true
      end
      it 'not includes raw_info in extras hash' do
        allow(subject).to receive(:raw_info).and_return({foo: 'bar'})
        expect(subject.extra[:raw_info]).to be_nil
      end
    end

    context 'when skip_info option is disabled' do
      let(:parsed_response) {
        {foo: 'bar'}
      }
      it 'not includes raw_info in extras hash' do
        allow(subject).to receive(:raw_info).and_return(parsed_response)
        expect(subject.extra[:raw_info]).to eq parsed_response
      end
    end
  end

  describe '#raw_info' do
    let(:parsed_response) do
      { foo: 'bar' }
    end
    let(:response) { double('Response', parsed: parsed_response) }

    it 'uses relative paths' do
      allow_message_expectations_on_nil
      allow(subject.access_token).to receive(:get).with('/api/v2/authenticated_user') { response }
      expect(subject.raw_info).to eq parsed_response
    end
  end


  describe '#client' do
    subject { Class.new(OmniAuth::Strategies::Qiita) }

    it 'is initialized with symbolized client_options' do
      instance = subject.new(app, client_options: {'authorize_url' => 'https://example.com'})
      expect(instance.client.options[:authorize_url]).to eq('https://example.com')
    end

    it 'sets ssl options as connection options' do
      instance = subject.new(app, client_options: {'ssl' => {'ca_path' => 'foo'}})
      expect(instance.client.options[:connection_opts][:ssl]).to eq(:ca_path => 'foo')
    end
  end

end

describe OmniAuth do
  describe '.config' do
    it 'has camelizations' do
      expect(OmniAuth.config.camelizations['qiita']).to eq 'Qiita'
    end
  end
end
