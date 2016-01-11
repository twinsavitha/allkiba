# ETL declaration
require_relative 'common'
require  'awesome_print'

start_time = Time.now
pre_process do
  puts "*** START TIME #{start_time}***"
end
#source = ENV['source']  #use this for passing the input from outside
#source << 'user.csv'
puts "source check"
#pp source
puts "sources"
source CsvSource,'user.csv', col_sep: ';', headers: true, header_converters: :symbol
transform VerifyFieldsPresence, [:name, :item, :amount, :delivered]
transform CheckStockPresent,'stock_out.csv'
transform GetLocation,'no_location.csv'
transform GenerateInvoiceNUmber  # do later
#destination DestinationDatabase
show_me!

post_process do
  end_time = Time.now
  duration_in_minutes = (end_time - start_time)/60
  puts "*** END TIME #{end_time}***"
  puts "*** Duration (min): #{duration_in_minutes}" ##{duration_in_minutes.round(2)}
end
=begin

transform CheckStatus, from: :item
transform CheckAvailability, from: :item
#show_me!
#transform AddNew
show_me!
output_fields = [:billnum, :amount]
destination UserDestination
=end


