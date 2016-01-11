require 'csv'
require 'awesome_print'
#require 'mysql'  
require 'pp'
require 'facets/kernel/blank'
require 'sqlite3'



def show_me!
  transform do |row|
    ap row
    row # always return the row to keep it in the pipeline
  end
end

class CsvSource
  def initialize(file, options)
    @file = file
    @options = options
  end
  
  def each
        CSV.foreach(@file, @options) do |row|
             yield row.to_hash
        end
  end
end


class VerifyFieldsPresence
  def initialize(expected_fields)
    @expected_fields = expected_fields
  end
  def process(row)
        @expected_fields.each do |field|
              begin
                      if row[field].blank?
                        row = nil # raise "Row lacks value for field #{field} - #{row.inspect}"
                      end
              rescue Exception => e 
                      puts "Field not present"
                      break
              end
        end
        row
  end
end


