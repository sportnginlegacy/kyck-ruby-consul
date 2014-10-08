dir = File.expand_path("../core", __FILE__)
rb_ext = ".rb"
Dir.chdir dir do
  Dir.glob("*#{rb_ext}") do |file|
    require "consul/core/#{File.basename(file, rb_ext)}"
  end
end
