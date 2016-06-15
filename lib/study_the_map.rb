require "bundler/setup"
require "launchy"
require "rake"
require 'pry'
require 'open-uri'
require 'nokogiri'

require_relative "../lib/study_the_map/version"
require_relative '../lib/study_the_map/cli'
require_relative '../lib/study_the_map/lookupids'
require_relative '../lib/study_the_map/regions'
require_relative '../lib/study_the_map/ski_map'
require_relative '../lib/study_the_map/ski_map_scraper'
require_relative '../lib/study_the_map/region_scraper'
