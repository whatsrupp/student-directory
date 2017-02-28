def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  #create an empty array
  students = []
  #get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
      #add the student hash to the array
      students << {name: name, cohort: :november}
      puts "Now we have #{students.count} students"
      # get another name from the user
      name = gets.chomp
  end
  #return the array of students
  puts "Test values #{students}"
  return students
end

def print_header
  puts "The students of my cohort at Makers Academy"
  puts "-------------"
end

def prints(students)
    puts "pre each #{students}"
  students.each do |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  end
end

def print_footer (names)
  print "Overall, we have #{names.count} great students"
end


students = input_students
print_header

puts "Pre print #{students}"
prints(students)
print_footer(students)