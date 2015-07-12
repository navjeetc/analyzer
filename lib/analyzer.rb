require 'nokogiri'
require 'net/http'

class Analyzer
  attr_accessor :characters
  
  def initialize(text)
    @play_details = Nokogiri::XML(text)
  end
  
  def characters
    @play_details.xpath('//PERSONA')
  end
    
  def call
    uri = URI('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
    analyzer = Analyzer.new(Net::HTTP.get(uri))
    characters = analyzer.characters
    character_lines = {}
    characters.each do |character|
      character_lines[character.text] = analyzer.lines_for(character.text)
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
