require 'elm_compiler'

module Jekyll
  class ElmConverter < Converter
    safe false

    def setup
      return if @setup

      @output_file_extension = @config['jekyll_elm']['output_file_extension']
      @destination_folder = @config['jekyll_elm']['destination_folder']
      @setup = true
    end

    def matches(ext)
      ext =~ /^\.elm$/i
    end

    def output_ext(ext)
      @output_file_extension || '.html'
    end

    def convert(content)
      setup unless @setup
      ElmCompiler.new(content, @output_file_extension, @destination_folder).process!
    end
  end
end
