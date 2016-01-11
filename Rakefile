require 'kiba'
require 'benchmark'
task :default => 'mytask'

task :kiba do
    puts "in one"
    ENV['source'] = 'one.csv'
  etl_filename = './main.rb'
  script_content = IO.read(etl_filename)
  # pass etl_filename to line numbers on errors
  job_definition = Kiba.parse(script_content, etl_filename)
  Kiba.run(job_definition)
end

task :kiba_one do
    puts "in two"
  etl_filename = './main_dup.rb'
  script_content = IO.read(etl_filename)
  # pass etl_filename to line numbers on errors
  job_definition = Kiba.parse(script_content, etl_filename)
  Kiba.run(job_definition)
end

task :kiba_two do
    puts "in three"
     ENV['change'] = 'two.csv'
  etl_filename = './main_dup.rb'
  script_content = IO.read(etl_filename)
  # pass etl_filename to line numbers on errors
  job_definition = Kiba.parse(script_content, etl_filename)
  Kiba.run(job_definition)
end


multitask :mytask => [:kiba, :kiba_two] do
          puts "Completed parallel execution of tasks 1 through 3."
end


#must and shud the environmental variable name shud be different els it takes the same csv files twice 
