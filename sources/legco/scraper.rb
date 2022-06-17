#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class ArrayDate < WikipediaDate
  def to_s
    date_str.map { |str| format('%02d', str) }.join('-')
  end
end

# TODO: switch to Legislature class
class OfficeholderList < OfficeholderListBase
  decorator RemoveReferences
  decorator UnspanAllTables
  decorator WikidataIdsDecorator::Links

  def header_column
    '任期'
  end

  def table_number
    'position()<9'
  end

  class Officeholder < OfficeholderBase
    def columns
      %w[name dob term dates].freeze
    end

    def combo_date
      raw_combo_date.scan(/(\d+)年(\d+)月(\d+)日/)
    end

    def ignore_before
      1900
    end

    def date_class
      ArrayDate
    end
  end
end

url = ARGV.first
puts EveryPoliticianScraper::ScraperData.new(url, klass: OfficeholderList).csv
