#let's put all the students in an array
students = [
{name: "Dr. Hannibal Lecter", cohort: :november,
  hobbies: "Eating (with) friends", country: "USA"},
{name: "Darth Vader", cohort: :november,
  hobbies: "Asphyxiation", country: "Tatoonie (Planet)"},
{name: "Nurse Ratched", cohort: :november,
  hobbies: "Patient welfare", country: "USA"},
{name: "Michael Corleone", cohort: :november,
  hobbies: "Spending time with family", country: "USA"},
{name: "Alex DeLarge", cohort: :november,
  hobbies: "Drinking milk, watching films", country: "UK"},
{name: "The Wicked Witch of the West", cohort: :november,
  hobbies: "Training monkeys", country: "Oz"},
{name: "Terminator", cohort: :november,
  hobbies: "Time travel", country: "SkyNet"},
{name: "Freddy Krueger", cohort: :november,
  hobbies: "Bush pruning", country: "Dreamland"},
{name: "The Joker", cohort: :november,
  hobbies: "Japes", country: "Unknown"},
{name: "Joffrey Baratheon", cohort: :november,
  hobbies: "Archery", country: "Westeros"},
{name: "Norman Bates", cohort: :november,
  hobbies: "Spending time with Mom", country: "USA"}
]

#Doesn't need an input Var only outputs Name
def get_name
  puts "Please enter the name of the students."
  name = gets.chomp
  return name
end

def get_cohort
  puts "Please enter the cohort they will be joining."
  cohort = gets.chomp.to_sym
  return cohort
end
      
def check (name, cohort, students)
  puts "#{name} will be joining #{cohort} cohort. Is this correct? Y/N"
  correct = gets.chomp
  if correct == "Y" || correct == "y"
     input = {name: name, cohort: cohort}
     puts "CHECK INPUT #{input}"
     students << {name: name, cohort: cohort}
     puts " CHECK STUDENT ARRAY #{students}"
    puts "Now we have #{(students.count)} students"
  end
  return students
end

def continue
  puts "Would you like to enter another name? Y/N"
  cont = gets.chomp
  return cont
end

def get_input (students)
    
    name = get_name
    cohort = get_cohort
    students = check(name, cohort, students)
    puts "Check students in input #{students}"
    cont = continue
    output = [students, cont]
    return output
end

def input_students
    # create and empty array
  students = []
  cont = "y"
  while true
    inputs = get_input(students)
    students = inputs[0]
    cont = inputs[1]
    
    unless cont == "Y" || cont == "y"
     break
   end
    
  end
  return students
end



def count(students)
  count = 1
    while count <= students.length
        puts (students[count])
         count =count + 1
      end
  return count
end

def print_header
  puts "The students of Villains Academy"
  puts "----------------"
end

def print_students(students)
  students.each do |student|
    puts "#{student[:name]}".center(50)
  end
end

def print_footer(students)
  puts "Overall, we have #{(students.count)} great students."
end

students = input_students
print_header
print_students(students)
count(students)
print_footer(students)

