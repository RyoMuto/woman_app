require 'open-uri'
@path = 'https://rank1-media.com/item/I-PA000000000005872766'

fileName = File.basename(@path)

open(fileName, 'wb') do |output|  
  open(@path) do |data|
    output.write(data.read)         
  end
end
