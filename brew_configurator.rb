#! /usr/bin/env ruby
# encoding: UTF-8

require 'optparse'

# Configure your environment with Git and Homebrew formulas that satisfy your
# inner-dependencies and noble aspirations.
class BrewConfigurator
  def initialize(formula)
    @formula = formula
  end

  def formula
    @formula.gsub(/[^0-9A-Za-z.\-]/, '_')
  end

  def configurate!
    install_formula unless formula_installed?
  end

private
  def formula_installed?
    formula_location = `brew --cache #{formula}`
    idx = index_of_first_match = formula_location =~ /^*\.tar\.gz$/
    idx > 0 && formula_location[idx..-2] == ".tar.gz" # if true, it's installed
  end

  def install_formula
    puts `brew update && brew doctor && brew install #{formula}`
  end
end

options = {}
option_parser = OptionParser.new do |opts|
  opts.on("-f FORMULA") do |formula|
    # TODO: comma-separated list or something like that
    options[:formula] = formula
  end
end

option_parser.parse!

BrewConfigurator.new(options[:formula]).configurate!

# git config --global core.excludesfile $DOTFILES/.global.gitignore
# git config --global core.editor $EDITOR
