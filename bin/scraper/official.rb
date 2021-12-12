#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      noko.css('a').text.gsub(/The Honourable/i, '').tidy
    end

    def position
      noko.xpath('.//text()').last.text.tidy
    end
  end

  class Members
    def member_container
      # This removes the 'Non-Official Members'. TODO: include them
      noko.xpath('.//h2[contains(., "Non-Official Members")]//following::*').remove
      noko.css('.members')
    end
  end
end

file = Pathname.new 'html/official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
