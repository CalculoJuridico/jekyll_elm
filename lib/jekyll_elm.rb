require 'elm_compiler'

module Jekyll
  class ElmConverter < Converter
    safe false

    def setup
      return if @setup

      @output_file_extension = @config['jekyll_elm']['output_file_extension']
      @setup = true
    end

    def matches(ext)
      ext =~ /^\.elm$/i
    end

    def output_ext(ext)
      @output_file_extension || '.html'
    end

    def convert(content)
      ElmCompiler.new(content, @output_file_extension).process!
    end
  end
end
