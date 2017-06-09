require './lib/imager.rb'
require 'spec_helper'

describe PageParser do

  it '.get_full_link make absolute path for each relative link path' do
    url = 'http://rusrails.ru/active-model-basics'

    rel_paths = ["assets/github-d473003a87b900591c99049027eae946.png",
                 "assets/twitter-af2b497dd3cfb88d94d171c3ea5ca397.png"]

    result = [
      'http://rusrails.ru/assets/github-d473003a87b900591c99049027eae946.png',
      'http://rusrails.ru/assets/twitter-af2b497dd3cfb88d94d171c3ea5ca397.png']

    expect(PageParser.send(:get_full_link, url, rel_paths)).to eq result
  end

  it '.parse_page_for_images return array of images related paths' do
    exp_result = [
      'https://assets-cdn.github.com/images/modules/site/home-illo-conversation.svg',
      'https://assets-cdn.github.com/images/modules/site/home-illo-chaos.svg',
      'https://assets-cdn.github.com/images/modules/site/home-illo-business.svg',
      'https://assets-cdn.github.com/images/modules/site/integrators/slackhq.png',
      'https://assets-cdn.github.com/images/modules/site/integrators/zenhubio.png',
      'https://assets-cdn.github.com/images/modules/site/integrators/travis-ci.png',
      'https://assets-cdn.github.com/images/modules/site/integrators/atom.png',
      'https://assets-cdn.github.com/images/modules/site/integrators/circleci.png',
      'https://assets-cdn.github.com/images/modules/site/integrators/codeship.png',
      'https://assets-cdn.github.com/images/modules/site/integrators/codeclimate.png',
      'https://assets-cdn.github.com/images/modules/site/logos/airbnb-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/sap-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/ibm-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/google-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/paypal-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/bloomberg-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/spotify-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/swift-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/facebook-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/node-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/nasa-logo.png',
      'https://assets-cdn.github.com/images/modules/site/logos/walmart-logo.png'
    ]

    page = File.read('./spec/web_page.html')
    result = PageParser.send(:parse_page_for_images, page)

    expect(result).to all(be_an(String))
    expect(result.size).to eq 22
    expect(result).to eq exp_result
  end

  it '.get_extension return extension of image src file' do
    page = File.read('./spec/web_page.html')
    extension = Nokogiri::HTML(page).css('img').each do |img_node|
      extension = img_node.attr(:src).split('.')[-1]
      result = PageParser::ALLOWED_EXTENSIONS.include?(extension)

      expect(result).to be_truthy
    end
  end
end
