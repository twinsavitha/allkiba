require 'csv'
require 'awesome_print'
require 'mysql'  
require 'pp'
require 'facets/kernel/blank'
require 'sqlite3'
require 'logging'




def show_me!
  transform do |row|
    ap row
    row # always return the row to keep it in the pipeline
  end
end

class Source
  def initialize(file, options)
    @file = file
    @options = options
  end
  
  def each
   @file.each do |f|  
        CSV.foreach(f, @options) do |row|
             yield row.to_hash
        end
    end
  end
end