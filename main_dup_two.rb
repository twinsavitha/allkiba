# ETL declaration
require_relative 'common'
require  'awesome_print'

source CsvSource,['user_three.csv'], col_sep: ';', headers: true, header_converters: :symbol
transform VerifyFieldsPresence, [:name, :item, :amount, :delivered]
transform CheckStockPresent,'stock_out.csv'
transform GetLocation,'no_location.csv'
transform GenerateInvoiceNUmber  # do later
show_me!
destination DestinationDatabase