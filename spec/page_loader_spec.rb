require './lib/imager.rb'
require 'spec_helper'

describe PageLoader do
  it '.get_page return 200 for proper URL' do
    url = 'http://github.com'
    successs_status = '200 OK'

    expect(PageLoader.get_page(url).headers['status']).to eq(successs_status)
  end

  it '.get_page shows error if page can"t be loaded' do
    url = 'http://rusrails.ru/active-model-basic'
    expect { PageLoader.get_page(url) }.to raise_error(RuntimeError, PageLoader::ERROR_MESSAGE)
  end
end
