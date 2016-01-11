require 'pp'
def invoice(row)
    "#{(row[:name])[0..2]}#{(row[:location])[0..2]}#{rand(1..100)}"
end