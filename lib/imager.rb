require 'rubygems'
require 'httparty'
require 'nokogiri'
require 'uri'

# Main class
class Imager
  def self.get_images
    puts 'Enter the page link:'
    PageParser.get_images_link(gets.chomp)
  end
end

# Get copy of page
class PageLoader
  include HTTParty

  ERROR_MESSAGE = 'Bad URL or internet connevtion'.freeze

  class << self
    def get_page(url)
      response = get(url)

      return response if response.success?
      raise ERROR_MESSAGE
    end
  end
end

# OPerate with loaded page
class PageParser
  ALLOWED_EXTENSIONS = %w[png jpeg jpg gif jpeg ico svg].freeze

  class << self
    def get_images_link(url)
      response = PageLoader.get_page(url)
      get_full_link(url, parse_page_for_images(response))
    end

    private

    def get_full_link(url, images_relative_path)
      uri = URI(url)
      host_part = "#{uri.scheme}://#{uri.host}"
      images_relative_path.map { |rel_path| URI.join(host_part, rel_path).to_s }
    end

    def parse_page_for_images(response)
      images_paths = Nokogiri::HTML(response).css('img').map do |img|
        img.attr(:src) if image?(img)
      end
      images_paths.compact
    end

    def image?(img)
      ALLOWED_EXTENSIONS.include?(get_extension(img))
    end

    def get_extension(img)
      img.attr(:src).split('.')[-1]
    end
  end
end
