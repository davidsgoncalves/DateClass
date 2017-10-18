require './my_date_time'
mdt = MyDateTime.new

# should work with CWI exemple
p "should return 04/03/2010 17:40, result: #{mdt.change_date("01/03/2010 23:00", '+', 4000) == '04/03/2010 17:40'}"
p "should return 04/03/2010 17:40 even if the value is negative, result: #{mdt.change_date("01/03/2010 23:00", '+', -4000) == '04/03/2010 17:40'}"
p "should return 31/12/2011 23:59 when add 365 days, result: #{mdt.change_date("31/12/2010 23:59", '+', 525600) == '31/12/2011 23:59'}"
p "should return 32/13/2011 24:61 when add 365 days and date is invalid , result: #{mdt.change_date("01/01/2010 23:00", '+', 525600) == '01/01/2011 23:00'}"
p "should not work, should raise ArgumentError, result: #{mdt.change_date("01/03/2010 23:00", '/', 4000)}"