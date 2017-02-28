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
    {name: "Jeremy Bowers",                 cohort: :novemeber},
    {name: "Norman Bates",                  cohort: :november}
]

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


def print_header
    pad = 80
    puts "The students of Villains Academy".center(pad)
    puts "--------------------------------".center(pad)
end

def print(students)

    students = filter(students, "c", 18)
    puts "#{students}"
    students.each_with_index do |student, index|
        puts "#{index + 1}. #{student[:name]} (#{student[:cohort]} cohort)"
    end
end


def filter(students, search_letter, search_length)
    #puts "Pupils beginning with #{search_letter} and less than #{search_length} characters."
    students.select! {|student| student[:name].downcase.start_with?(search_letter)}
    students.select! {|student| student[:name].length < search_length}
    return students
end

def print_with_while (students)
    i=0
    while i < students.length
       puts "#{i + 1}. #{students[i][:name]} #{students[i][:cohort]}" 
       i+=1
    end
end

def print_footer(names)
    puts "Overall, we have #{names.count} great students. "
end


#students = input_students



print_header
print(students)
#print_with_while(students)
print_footer(students)