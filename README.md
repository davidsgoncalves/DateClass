# DateClass
It's  a date class in Ruby to add and sub milliseconds from date with time.
This class was a challange for CWI company, and it passed.

It was created without any external library.

## Including and using class
```
require './my_date_time'
mdt = MyDateTime.new

mdt.change_date("01/03/2010 23:00", '+', 4000)
// 04/03/2010 17:40
```

## Just one method
This DateClass has one method only, with this method you can add or sub milliseconds from a datetime
```
change_date(INITIAL_DATE, OPERATOR, MILLISECONDS)
```
**INITIAL_DATE**: Should be a string of brazilian datetime format(dd/mm/YYYY HH:MM), ex: "01/03/2010 23:00";__
**OPERATOR**: Should be a string with any of this symbols ['+', '-'], use + if you want to add or '-' if you wnat to sub;__
**MILLISECONDS**: Should be a string of a number that represents a quantity of milliseconds, ex: "4000".

The return of this method is another string of brazilian datetime format.

## Test
Just run 
```
ruby test.rb
```
All test was created without any framework ou suite, and should break at last test as part of challange.

## Authors
* **David S Gonaçalves**
