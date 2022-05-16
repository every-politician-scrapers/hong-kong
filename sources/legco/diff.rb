#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/comparison'

# For now, only compare which members are included or not, as
# WP has separate memberships by term, whereas WD usually doesn't
class Comparison < EveryPoliticianScraper::NulllessComparison
  def columns
    %i[item name]
  end

  def wikidata_tc
    super.uniq
  end

  def external_tc
    super.uniq
  end
end

diff = Comparison.new('wikidata.csv', 'scraped.csv').diff
puts diff.sort_by { |r| [r[0].to_s.gsub(/\-.*/, '+++').gsub('@@','!!'), r[2].to_s.downcase] }.map(&:to_csv)
