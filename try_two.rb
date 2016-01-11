require 'rubygems'  
require 'active_record'  
require 'pp'
ActiveRecord::Base.establish_connection(  
:adapter => "mysql",  
:host => "localhost",  
:database => "c9",
:username => "savitha"
)  
class Store  < ActiveRecord::Base  
end  

def loc(name)
   Store.where(name: name).pluck(:location).join("")
end