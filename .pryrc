Pry.config.editor = 'atom -w'
Pry.config.pager = false
Pry.config.commands.alias_command "lM", "ls -M"

if defined?(Encoding) then
  Encoding.default_external = 'utf-8'
  Encoding.default_internal = 'utf-8'
else
  $KCODE = 'utf-8'
end

# Default Command Set, add custom methods here:
default_command_set = Pry::CommandSet.new do
  command 'copy', 'Copy to clipboard' do |str|
    str = "#{_pry_.input_array[-1]}#=> #{_pry_.last_result}\n" unless str
    IO.popen('pbcopy', 'r+') { |io| io.puts str }
    output.puts "-- Copy to clipboard --\n#{str}"
  end
end

# https://github.com/michaeldv/awesome_print/
# $ gem install awesome_print
begin
  require 'awesome_print'
  Pry.config.print = proc { |output, value| output.puts value.ai(:indent => 2) }
rescue LoadError => e
  warn "[WARN] #{e}"
  puts '$ gem install awesome_print'
end

# Use Array.toy to get an array to play with
class Array
  def self.toy(n = 10, &block)
    block_given? ? Array.new(n, &block) : Array.new(n) { |i| i+1 }
  end
end

# Use Hash.toy to get an hash to play with
class Hash
  def self.toy(n = 10)
    Hash[Array.toy(n).zip(Array.toy(n){ |c| (96+(c+1)).chr })]
  end
end

# Launch Pry with access to the entire Rails stack.
rails = File.join(Dir.getwd, 'config', 'environment.rb')
if File.exist?(rails) && ENV['SKIP_RAILS'].nil?
  require rails
  case Rails.version.to_i
  when 2
    require 'console_app'
    require 'console_with_helpers'
  when 3
    require 'rails/console/app'
    require 'rails/console/helpers'
    extend Rails::ConsoleMethods if Rails.version.to_f >= 3.2
  else
    warn '[WARN] cannot load Rails console commands'
  end
end

Pry.config.commands.import(default_command_set)

# Pry.config.command_prefix = "%"
Pry.config.prompt = [
  proc { |target_self, nest_level, pry|
    nested = (nest_level.zero?) ? '' : ":#{nest_level}"
    "[#{pry.input_array.size}] #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}(#{Pry.view_clip(target_self)})#{nested}> "
  },
  proc { |target_self, nest_level, pry|
    nested = (nest_level.zero?) ? '' : ":#{nest_level}"
    "[#{pry.input_array.size}] #{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}(#{Pry.view_clip(target_self)})#{nested}* "
  }
]

begin
require 'pry-clipboard'
# aliases
Pry.commands.alias_command 'ch', 'copy-history'
Pry.commands.alias_command 'cr', 'copy-result'
rescue LoadError
# Missing goodies, bummer
end
