# ETL declaration
require_relative 'common'
require  'awesome_print'

start_time = Time.now
pre_process do
  puts "*** START TIME #{start_time}***"
end
source = 'second_user.csv'
#source = ENV['source'] 
source CsvSource,source, col_sep: ';', headers: true, header_converters: :symbol
transform VerifyFieldsPresence, [:name, :item, :amount, :delivered]  # do later
show_me!


post_process do
  end_time = Time.now
  duration_in_minutes = (end_time - start_time)/60
  puts "*** END TIME #{end_time}***"
  puts "*** Duration (min): #{duration_in_minutes}" ##{duration_in_minutes.round(2)}
end


