require "rubygems"
require "mp3info"

class FixMp3Name
  
  def initialize(path)
    @path = path
  end

  def update_tag title, file
    if File.exist? file
      begin
        Mp3Info.open(file, :encoding => 'utf-8') do |mp3|
          mp3.tag.title = title
        end  
      rescue
        puts file
      end
    end
  end
  
  def fix_mp3_tag(path=@path)
    Dir.foreach(path) do |file|
      next if file == '.' or file == '..'
      
      file_path = File.join(path, file)
      
      if File.directory? file_path      
        fix_mp3_tag file_path
      else
        if File.extname(file_path) == '.mp3'
          title = File.basename(file_path, ".mp3")
          update_tag(title, file_path)
        end
      end
    end
  end
end

puts "enter the path of the directory you want to fix: "
STDOUT.flush 
dir = gets.chomp

FixMp3Name.new(dir).fix_mp3_tag

puts "done!"