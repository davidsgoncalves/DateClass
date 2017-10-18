class MyDateTime
    attr_accessor :year
	attr_accessor :month
	attr_accessor :day
	attr_accessor :hour
	attr_accessor :minute	

    MONTHS = { '1' => 31, '2' => 28,'3' => 31,'4' => 30,'5' => 31,'6' => 30,'7' => 31,'8' => 31,'9' => 30,'10' => 31,'11' => 30,'12' => 31 }

    def change_date(date, op, value)
        raise ArgumentError unless ['+', '-'].include? op
        value = value.abs

        parse_datetime date
                
        calc_time value, op

        masked_return        
    end

    private

    def parse_datetime(datetime_string)
		date, time = datetime_string.split(' ')
		day, month, year = date.split('/')
        hour, minutes = time.split(':')
        
		self.year = year.sub!(/^0*/, "").to_i 
        self.month = month.sub!(/^0*/, "").to_i        
        self.day = day.sub!(/^0*/, "").to_i        
		self.hour = hour.sub!(/^0*/, "").to_i
        self.minute = minutes.sub!(/^0*/, "").to_i

        fix_date_pattern
    end

    def fix_date_pattern
        self.month = 12 if self.month > 12
        self.day = MONTHS[self.month.to_s] if self.day > MONTHS[self.month.to_s]
        self.hour = 23 if self.hour > 23
        self.minute = 59 if self.minute > 59        
    end

    def calc_time(value, op)
        add_time(value) if op == '+'
        sub_time(value) if op == '-'    
    end    

    def sub_time(value)
        mins_to_sub = value % 60        
        hours_to_sub = (value / 60) % 24
        days_to_sub =  (value / 60) / 24        
        
        if self.minute < mins_to_sub            
            self.minute = self.minute + 60 - mins_to_sub
            hours_to_sub = hours_to_sub + 1
        else
             self.minute = self.minute - mins_to_sub
        end
       
        if self.hour < hours_to_sub            
            self.hour = self.hour + 24 - hours_to_sub
            days_to_sub = days_to_sub + 1
        else
            self.hour = self.hour - hours_to_sub
        end 

        sub_date(days_to_sub)
    end

    def sub_date(days_to_sub)
        while days_to_sub > 0
            if days_to_sub >= self.day
                days_to_sub = days_to_sub - self.day                
                self.month = self.month - 1

                if self.month <= 0
                    calc_year(:-)
                    self.month = 12    
                end 

                self.day = MONTHS[self.month.to_s]    
            elsif self.day > days_to_sub                              
                self.day = self.day - days_to_sub
                days_to_sub = 0 
            end 
        end 
    end

    def add_time(value)       
        self.minute = self.minute + value
		hours_to_add = self.minute / 60
		self.minute = self.minute % 60        

        self.hour = hours_to_add + self.hour
		days_to_add = self.hour / 24
        self.hour = self.hour % 24
        
        self.day = days_to_add + self.day
        add_date
    end    

    def mask_value(value)        
        '%02d' % value
    end
    
    def add_date	
        days_to_sub = 0
        actual_day = 1

		while self.day > MONTHS[self.month.to_s]
			days_to_sub = MONTHS[self.month.to_s] - actual_day + 1
			self.day = self.day - days_to_sub 
			self.month = self.month + 1			

			if self.month > 12
				calc_year(:+)
				self.month = 1
			end
		end
    end
    
    def calc_year(op)
        self.year = self.year.send(op, 1)       
    end

    def masked_return
        self.day = mask_value(self.day)
        self.month = mask_value(self.month)
        self.hour = mask_value(self.hour)
        self.minute = mask_value(self.minute)

        "#{self.day}/#{self.month}/#{self.year} #{self.hour}:#{self.minute}"
    end
end