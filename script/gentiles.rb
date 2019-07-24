#!/usr/bin/env ruby -wKU

require "optparse"
# require "optparse/time"
# require "ostruct"
require "pp"

PLANET_PACKS = {
  default: %w(
    Moho
    Eve Gilly
    Kerbin Mun Minmus
    Duna Ike
    Dres
    Jool Laythe Vall Tylo Bop Pol
    Eeloo
  ) - ["Jool"],
  jnsq: %w(
    Moho
    Eve Gilly
    Kerbin Mun
    Minmus
    Duna Ike
    Edna Dak
    Dres
    Jool Laythe Vall Tylo Bop Pol
    Lindor Krel Aden Riga Talos
    Eeloo Celes Tam
    Hamek
    Nara Amos Enon Prax
  )
}

ALL_STYLES = %w(
  Biome
  Map
  Slope
)

class Options
  attr_accessor :bodies, :pack, :styles, :zoom_levels

  def initialize
    self.bodies = []
    self.pack = :default
    self.styles = []
    self.zoom_levels = nil
  end

  def define_options(parser)
    parser.banner = "Usage: gentiles.rb [options]"

    parser.separator ""
    parser.separator "Specific options:"

    set_bodies_option(parser)
    set_pack_option(parser)
    set_styles_option(parser)
    set_zoom_levels_option(parser)

    parser.separator ""
    parser.separator "Common options:"

    parser.on_tail("-h", "--help", "Show this message") do
      puts parser
      exit
    end
  end

  def set_bodies_option(parser)
    parser.on("-b BODY_LIST", "--body=BODY_LIST", Array,
              "A list of bodies for which to generate map tiles",
              "(may be 'All')") do |body_list|
      self.bodies = if body_list == ["All"]
                      PLANET_PACKS[self.pack]
                    else
                      PLANET_PACKS[self.pack] & body_list
                    end
    end
  end

  def set_pack_option(parser)
    parser.on("-p PLANET_PACK", "--pack=PLANET_PACK", String,
              "An installed planet pack to use instead of the default KSP system",
              "(if not specified, assume default)") do |pack_name|
      self.pack = if pack_name.nil?
                    :default
                  else
                    pack_name.downcase.to_sym
                  end
    end
  end

  def set_styles_option(parser)
    parser.on("-s STYLE_LIST", "--style=STYLE_LIST", Array,
              "A list of styles for which to generate map tiles",
              "(may be 'All')") do |style_list|
      self.styles = if style_list == ["All"]
                      ALL_STYLES
                    else
                      ALL_STYLES & style_list
                    end
    end
  end

  def set_zoom_levels_option(parser)
    parser.on("-z ZOOM_LEVELS", "--zoom_levels=ZOOM_LEVELS", Array,
              "Zoom levels for which to generate map tiles",
              "(may be 'All')") do |zoom_levels|
      self.zoom_levels = zoom_levels.map do |zl|
                           case zl
                           when "All"
                             (0..7).to_a
                           when /^\d(?:-|\.\.)\d$/
                             (start_value, end_value) = zl.split(/-|\.\./, 2)
                             (start_value.to_i..end_value.to_i).to_a
                           else
                             zl.to_i
                           end
                         end.flatten
    end
  end

  def self.parse(args)
    options = Options.new

    OptionParser.new do |parser|
      options.define_options(parser)
      parser.parse!(args)
    end

    options
  end
end

options = Options.parse ARGV

puts <<-END_OF_TEXT
@SigmaCartographer
{
END_OF_TEXT

options.bodies.each do |body|
  options.zoom_levels.each do |zoom_level|
    puts <<-END_OF_TEXT
  Maps
  {
    body = #{body}
    biomeMap = false
    colorMap = false
    slopeMap = false
    satelliteBiome = #{options.styles.include?("Biome").to_s}
    satelliteMap = #{options.styles.include?("Map").to_s}
    satelliteSlope = #{options.styles.include?("Slope").to_s}
    oceanFloor = true
    width = #{512 * 2**zoom_level}
    tile = 256
    exportFolder = #{zoom_level}
    leaflet = false
  }
    END_OF_TEXT
  end
end

puts <<-END_OF_TEXT
}
END_OF_TEXT
