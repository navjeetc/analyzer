require 'nokogiri'
require 'net/http'

class Analyzer
  attr_accessor :characters
  
  def parse(text)
    @play_details = Nokogiri::XML(text)
  end
  
  def characters
    @play_details.xpath('//PERSONA')
  end
    
  def call
    uri = URI('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
    analyzer = Analyzer.new()
    analyzer.parse(Net::HTTP.get(uri))
    characters = analyzer.characters
    character_lines = {}
    characters.each do |character|
      puts "Character \"#{character.text}\" spoke => #{analyzer.lines_for(character.text)} lines"
    end
  end
  
  def lines_for(character)
    speaker_lines = {}
    speaker_lines[character] = 0
    @play_details.xpath('//SPEAKER').each do |speaker|
      if speaker.text == character
        count = 0
        speaker.parent.children.each do |child|
          case child.name
            when 'LINE'
              count = count + 1
            end
        end
        speaker_lines[speaker.text] += count
      end
    end
    speaker_lines[character]
  end
  
end
# Uncomment the following line to print the lines spoken by each character
#
# Analyzer.new.call
