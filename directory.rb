students = [
    {name: "Dr. Hannibal Lecter",           cohort: :november},
    {name: "Darth Vader",                   cohort: :november},
    {name: "Nurse Ratched",                 cohort: :november},
    {name: "Michael Corleone",              cohort: :november},
    {name: "Alex DeLarge",                  cohort: :november},
    {name: "The Wicked Witch of the West",  cohort: :november},
    {name: "Terminator",                    cohort: :november},
    {name: "Freddy Krueger",                cohort: :november},
    {name: "The Joker",                     cohort: :november},
    {name: "Joffrey Baratheon",             cohort: :november},
    {name: "Norman Bates",                  cohort: :november}
]

def print_header
    puts "The students of Villains Academy"
    puts "--------------------------------"
end

def print(students, search_letter)
    puts "Pupils beginning with #{search_letter}"
    
    students.each_with_index do |student, index|
        if student[:name][0].downcase == search_letter
            puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
        end
    end
end

def print_footer(names)
    puts "Overall, we have #{names.count} great students. "
end

def input_students
   
   puts "Please enter the names of the students"
   puts "To finish, just hit return twice"
   students =[]
   name = gets.chomp
   
   while !name.empty? do 
      students << {name: name, cohort: :november}
      puts "Now we have #{students.count} students"
      name = gets.chomp
   end
    students
end

#students = input_students



print_header
print(students, "d")
print_footer(students)