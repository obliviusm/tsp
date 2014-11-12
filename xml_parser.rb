require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

f = File.open("data/br17.xml")
doc = Nokogiri::XML(f)
f.close
hash = Hash.from_xml(doc.to_s)
p hash