require 'nokogiri'
require 'net/http'
#
# Performs analysis of script of a play in xml format and prints
# speaker name and number of lines spoken
#
class Analyzer
  
  def parse(text)
    @play_details = Nokogiri::XML(text)
  end
  
  def characters
    @play_details.xpath('//PERSONA')
  end
  
  # main service method to parse xml and print output  
  def call
    uri = URI('http://www.ibiblio.org/xml/examples/shakespeare/macbeth.xml')
    analyzer = Analyzer.new()
    analyzer.parse(Net::HTTP.get(uri))
    characters = analyzer.characters
    character_lines = {}
    characters.each do |character|
      puts format(character.text, analyzer.lines_for(character.text))
    end
  end
  
  def lines_for(character)
    speaker_lines = {}
    speaker_lines[character] = 0
    @play_details.xpath('//SPEAKER').each do |speaker|
      speaker_lines[character] += line_count(speaker, character)
    end
    speaker_lines[character]
  end
  
end

private

def line_count(speaker, character)
  count = 0
  if speaker.text == character
    speaker.parent.children.each do |child|
      case child.name
        when 'LINE'
          count += 1
        end
    end
  end
  count
end

def format(name, linecount)
  "#{linecount} #{name}"
end

# Uncomment the following line to print the lines spoken by each character
#
#Analyzer.new.call
