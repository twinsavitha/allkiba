require 'rubygems'  
require 'active_record'  
require 'kiba'
=begin
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "c9",
:username => "savitha"
) 
=end

class First
    @queue = "one"
            def self.perform
              puts "inside perform"
              #ENV['source'] = 'user.csv'
              etl_filename = './main.rb'
              puts "inside perform2"
              script_content = IO.read(etl_filename)
              puts "inside perform3"
              # pass etl_filename to line numbers on errors
              job_definition = Kiba.parse(script_content, etl_filename)
              puts "inside perform4"
              Kiba.run(job_definition)
              puts "inside perform5"
            end
end
