require 'rubygems'  
require 'active_record'  
require 'pp'
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "c9",
:username => "savitha"
)  
class Item  < ActiveRecord::Base  
end  

def try(name)
   Item.where(name: name).pluck(:quantity).join.to_i
end