# Omniauth::Qiita

This gem contains the Qiita strategy for OmniAuth.

## Before Use

First you'll sign in into the [Qiita](https://qiita.com) and [create an application](https://qiita.com/settings/applications/new). Make a written note of API Key and API Secret.

## How to Use

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-qiita', :github => 'kazu69/omniauth-qiita'
```

```ruby
use OmniAuth::Builder do
  provider :qiita, 'QIITA_CLIENT_ID', 'QIITA_CLIENT_SECRET'
end
```

If use this gem on your rails app, config/initializers/omniauth.rb file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :qiita, 'QIITA_CLIENT_ID', 'QIITA_CLIENT_SECRET'
end
```

## Authentication Hash
```sh
{"provider"=>"qiita",
 "uid"=>"qiita_user",
 "info"=>
  {"name"=>"Full Name",
   "description"=>"I'm softwear engineer",
   "organization"=>"example. inc",
   "location"=>"Japan",
   "website"=>"http://qiita.com",
   "image"=>"http://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346",
   "followees_count"=>10,
   "followers_count"=>18,
   "items_count"=>26,
   "social"=>{
      "facebook"=>"facebook id",
      "github"=>"github login name",
      "linkedin_id"=>"likedin id",
      "twitter"=>"twitter screen name"
    }
  },
 "credentials"=>{
  "token"=>"8376581625bdd6e5231fbdcdac9d15a5b71eaf3b",
  "expires"=>false
},
 "extra"=>
  {"raw_info"=>
    {"description"=>"I'm softwear engineer",
     "facebook_id"=>"facebook id",
     "followers_count"=>10,
     "followees_count"=>18,
     "github_login_name"=>"github login name",
     "id"=>"qiita_user",
     "items_count"=>26,
     "linkedin_id"=>"likedin id",
     "location"=>"Japan",
     "name"=>"kazu Full Name",
     "organization"=>"example. inc",
     "profile_image_url"=>
      "http://www.gravatar.com/avatar/0bc83cb571cd1c50ba6f3e8a78ef1346",
     "twitter_screen_name"=>"twitter screen name",
     "website_url"=>"http://qiita.com"}}}
```

## Contributing

1. Fork it ( https://github.com/kazu69/omniauth-qiita/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

License

Copyright (c) 2014 by kazu69

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
