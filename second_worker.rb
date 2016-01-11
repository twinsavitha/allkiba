require 'rubygems'  
require 'active_record'  
require 'kiba'
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "c9",
:username => "savitha"
)  


class Second
    @queue = "two"
            def self.perform
              
              puts "inside perform second queue"
              #ENV['source'] = 'second_user.csv'
              etl_filename = './main_dup.rb'
              puts "inside perform2 second queue"
              script_content = IO.read(etl_filename)
              puts "inside perform3 second queue"
              # pass etl_filename to line numbers on errors
              job_definition = Kiba.parse(script_content, etl_filename)
              puts "inside perform4 second queue"
              Kiba.run(job_definition)
              puts "inside perform5 second queue"
            end
end
