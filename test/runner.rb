# typed: true

base_dir = File.dirname(File.absolute_path(__FILE__))
Dir.glob(base_dir + '/**/test_*.rb') do |filename|
  require filename
end
