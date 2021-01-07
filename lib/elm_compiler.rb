require 'open3'
require 'securerandom'

class ElmCompiler
  ELM_COMMAND = 'PATH=$(yarn bin):$PATH elm make'

  def initialize(content, output_file_extension)
    setup_dir

    @content = content
    @output_file_extension = output_file_extension
    @destination_folder = destination_folder
  end

  def process!
    output = '', status = nil

    with_error_handling do
      result = File.open(tmp_path, 'w') { |f| f.write(@content) }


      command = "#{ELM_COMMAND} #{tmp_path} --output #{dest_path}"
      puts "Compiling Elm file... $ #{command}"
      out, err, status = Open3.capture3(command)

      if status.success?
        output = File.read(dest_path)
        File.delete(dest_path)
      else
        puts '*** ERROR: Elm'
        puts "** OUT:\n#{out}"
        puts "** ERR:\n#{err}"
      end
    end

    output
  end

  private

  def setup_dir
    Dir.mkdir(elm_dir) unless File.exist?(elm_dir) && File.directory?(elm_dir)
  end

  def with_error_handling
    begin
      yield
    rescue Errno::ENOENT => e
      puts "*** ERROR Elm: #{e.inspect}"
    ensure
      File.delete(tmp_path)
    end
  end

  def in_elm_dir
    Dir.chdir(elm_dir)
    yield
    Dir.chdir('..')
  end

  def elm_dir
    '_elm'
  end

  def tmp_file
    @tmp_file ||= SecureRandom.hex(16)
  end

  def tmp_path
    File.join(elm_dir, "#{tmp_file}.elm")
  end

  def output_file_extension
    @output_file_extension || ".html"
  end

  def destination_folder
    @destination_folder || "elm"
  end

  def dest_path
    File.join(destination_folder, "#{tmp_file}.#{output_file_extension}")
  end
end
