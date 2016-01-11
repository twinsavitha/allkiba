require 'rubygems'  
require 'active_record'
require 'resque'
require '/home/ubuntu/workspace/kibaresque/first_worker.rb'
require '/home/ubuntu/workspace/kibaresque/second_worker.rb'
class One
  def first
    
       Resque.enqueue(First)
       Resque.enqueue(Second)
  end
end
a = One.new
a.first