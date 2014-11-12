require 'nokogiri'
require 'active_support/core_ext/hash/conversions'

def fixnumify obj
  if obj.respond_to?(:to_i) && obj.to_i.to_s == obj
    # If we can cast it to a Fixnum, do it.
    obj.to_i

  elsif obj.is_a? Array
    # If it's an Array, use Enumerable#map to recursively call this method
    # on each item.
    obj.map {|item| fixnumify item }

  elsif obj.is_a? Hash
    # If it's a Hash, recursively call this method on each value.
    obj.merge( obj ) {|k, val| fixnumify val }

  else
    # If for some reason we run into something else, just return
    # it unmodified; alternatively you could throw an exception.
    obj

  end
end

f = File.open("data/br17.xml")
doc = Nokogiri::XML(f)
f.close
hash = Hash.from_xml(doc.to_s)
p fixnumify hash