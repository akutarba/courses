#1. Сделать хеш, содеращий месяцы и количество дней в месяце. В цикле выводить те месяцы, у которых количество дней ровно 30

days_per_month = {january: 31, february: 28, march: 31, april: 30, may: 31, juni: 30, july: 31, august: 31,
  september: 30, oktober: 31, november: 30, december: 31 }

puts "Months with 30 days: "
days_per_month.each {|month, days| puts month.capitalize if days == 30}





