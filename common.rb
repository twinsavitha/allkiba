require 'csv'
require 'awesome_print'
require 'mysql'  
require 'pp'
require 'facets/kernel/blank'
require 'sqlite3'
require 'logging'
require '/home/ubuntu/workspace/kibascenario/try'
require '/home/ubuntu/workspace/kibascenario/try_two'
require '/home/ubuntu/workspace/kibascenario/try_three'

Logging.color_scheme( 'bright',
    :levels => {
      :info  => :green,
      :warn  => :yellow,
      :error => :red,
      :fatal => [:white, :on_red]
    },
    :date => :blue,
    :logger => :cyan,
    :message => :magenta
    #works for the appenders at console
  )




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
    @logger = Logging.logger['Missing fields']
    @logger.appenders = Logging.appenders.file('output.log')
  end
  def process(row)
        @expected_fields.each do |field|
              begin
                      if row[field].blank?
                        @logger.debug "#{field} - #{row.inspect}"
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

class CheckStockPresent
    def initialize(file)
        @file = file
        @csv = CSV.open(@file, 'w')
        @logger = Logging.logger['Missing Stock']
        @logger.appenders = Logging.appenders.file('output.log')
    end
     def process(row)
       #check if empty and also check if the count is lesser than 1 and accordingly update the available number in the db item table
       if(row[:delivered] == "no")
           if (try(row[:item]) == 0 )
               @csv << row.values
               @logger.debug "#{row[:item]}-  #{row.inspect}"
               row = nil
           end
       end
       #@csv.flush check @csv.flush or @csv.close
      row
     end
end

class GetLocation
    def initialize(file)
        @file = file
        @twocsv = CSV.open(@file, 'w')
        @logger = Logging.logger['Missing Location']
        @logger.appenders = Logging.appenders.file('output.log')
=begin 
        #to log on console
        @logg = Logging.logger['Missing Location']
        @logg.appenders = Logging.appenders.stdout
        @logg.debug "location of delivery not provided by #{row[:name]}"
=end
    end
     def process(row)
        if(row[:delivered] == "no")
                location = loc(row[:name])
                if (location.empty?)
                   @twocsv << row.values
                   @logger.debug "location of delivery not provided by #{row[:name]}"
                   row = nil
               else 
                   row[:location] = location
                end
        end
        #@twocsv.flush check @csv.flush or @csv.close
        row
     end
end


class GenerateInvoiceNUmber
     def process(row)
         if(row[:delivered] == "no")
           row[:invoice] = invoice(row)
         end
        row
     end
end

class DestinationDatabase
  # connect_url should look like;
  #  mysql://user:pass@localhost/dbname
  def initialize
   # @conn = PG.connect(connect_url)
   #connect_url = "mysql://sari:sarvi@localhost/c9" #not working
    @db_host  = "localhost"
    @db_user  = "sari"
    @db_name = "c9"
    begin
        @client = Mysql.connect('localhost', 'sari', "sarvi", 'c9') #@client = Mysql.connect(connect_url)
        @cdr_result = @client.prepare("INSERT INTO deliver (name,location,item,amount,invoice) VALUES (?,?,?,?,?) ")
        @cdr_result_two = @client.prepare("INSERT INTO delivered (name,item) VALUES (?,?);")
    rescue Mysql::Error => e 
        puts e
    end
    @logger = Logging.logger['Success']
    @logger.appenders = Logging.appenders.file('success.log')
  end
  def write(row)
        begin
            if row[:delivered] == "no" 
                @cdr_result.execute(row[:name],row[:location],row[:item],row[:amount],row[:invoice])
                @logger.info "#{row.inspect}"
            else
                @cdr_result_two.execute(row[:name],row[:item])
                @logger.info "#{row.inspect}"
            end
        rescue  Exception=>e 
            puts e
        end
  end
  def close
   begin      
    @client.close 
    @cdr_result.close
    @cdr_result_two.close
   rescue  Exception=>e 
            puts e
   end  
  end
end


#only csv issues - i.e. is similar kind present it dosn take them
#try ActiveRecord with sqlite
#efficient
#logger hierarchy
#DB connection
#DB connection url
#better rescue
#Rake 
#Resque
#DelayedJObs
#Task Runner


#Resque, DelayedJob, Sidekiq, Rake


