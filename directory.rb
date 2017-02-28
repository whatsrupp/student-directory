#Hash of students for testing purposes.
default_students = [
    {name: "Dr. Hannibal Lecter",           cohort: :march,     hobby: :coding,     age: 45},
    {name: "Darth Vader",                   cohort: :april,     hobby: :coding,     age: 45},
    {name: "Nurse Ratched",                 cohort: :april,     hobby: :coding,     age: 45},
    {name: "Michael Corleone",              cohort: :march,     hobby: :coding,     age: 45},
    {name: "Alex DeLarge",                  cohort: :november,  hobby: :coding,     age: 45},
    {name: "The Wicked Witch of the West",  cohort: :november,  hobby: :coding,     age: 45},
    {name: "Terminator",                    cohort: :november,  hobby: :coding,     age: 45},
    {name: "Freddy Krueger",                cohort: :november,  hobby: :coding,     age: 45},
    {name: "The Joker",                     cohort: :november,  hobby: :coding,     age: 45},
    {name: "Joffrey Baratheon",             cohort: :november,  hobby: :coding,     age: 45},
    {name: "Jeremy Bowers",                 cohort: :november,  hobby: :coding,     age: 45},
    {name: "Norman Bates",                  cohort: :november,  hobby: :coding,     age: 45}
]

#############INPUTS################
def input_students
   
   puts "Please enter the names of the students"
   puts "To finish, just hit return twice"
   students =[]
   months = %w(january february march april may june july august september october november december)
   default= "november"
   
   while true
      print "Student Name? (Return empty to finish student entry) > "
      name = gets.chomp
      
      break if name.empty?
     
      while true
        print "Which Cohort? (Return for default - #{default}) > "
        cohort = gets.chomp.downcase
        if months.include?(cohort)
            break
        elsif cohort.empty?
            cohort = default
            break
        else
            puts "Please insert valid month"
        end
      end
      
      students << {name: name, cohort: cohort.to_sym}
      puts "Now we have #{students.count} students"
   end
    students
end

########FILTERING AND ARRANGING ##############

def arrange_by_cohort(students)
    
    arranged_students = []
    cohort_array =[]
    students.each {|student| cohort_array << student[:cohort]}
    cohort_array.uniq!
    cohort_array.sort!
    cohort_array.each do |cohort|
        arranged_students += students.map{|student| student if student[:cohort] == cohort}.compact
    end
    return arranged_students
    
end


def first_letter_filter(students, search_letter)
    students.select! {|student| student[:name].downcase.start_with?(search_letter.downcase)}
    puts "Searching for student names beginning with #{search_letter}"
    return students
end

def character_length_filter(students, search_length)
    students.select! {|student| student[:name].length < search_length}
    puts "Searching for student names less than #{search_length} characters."
    return students
end

################# PRINTING ##############

def print_with_while (students)
    i=0
    while i < students.length
       puts "#{i + 1}. #{students[i][:name]} #{students[i][:cohort]}" 
       i+=1
    end
end

def print_footer(students,pad)
    puts "-" * pad
    puts "Overall, we have #{students.count} great student#{"s" unless students.count == 1}.".center(pad)
    
end

def print_header(pad)
    puts "The students of Villains Academy".center(pad)
    puts ("-"*pad).center(pad)
end

def print_student_list(students,spacing)
    
    padding_hash = calculate_padding(students, spacing)[0]
   
    students.each_with_index do |student, i|
        print "#{(i + 1).to_s.ljust(spacing)}" 
        student.each_key {|key| print "#{student[key].to_s.ljust(padding_hash[key])}" }
        print"\n"
    end
end

def calculate_padding (students, spacing)
    #assuming all hashes have the same key identifiers
    key_names = [] #initalise empty variables required
    key_lengths = {} 
    students[0].each_key {|key| key_names << key} #gets key names from student list
    l_total = 0
    
    #Iterate through each key and find the max length of each value in each student hash
    key_names.each do |key|
       l_max = 0
       students.each do |student| 
           l = student[key].to_s.length 
           l_max = l if l > l_max
       end
       key_lengths[key] = l_max + spacing
    end
    
    key_lengths.each_key do|key|
        l_total += key_lengths[key]
    end
    
    [key_lengths, l_total]
    
end


def interactive_menu (default_students)
    students = []
    #Default Parameters
    spacing = 10
    letter = "D"
    max_characters = 30
    
    loop do
        # Print the menu and ask user
        puts ""
        puts "MAIN MENU".center(30)
        puts "1. Input the students"
        puts "2. Show the students"
        puts "3. Change default search parameters"
        puts "4. Clear current student list"
        puts "5. Search Students"
        puts "9. Exit"
        print "> "
        
        ans = gets.chomp
        
        case ans
            when "1" 
                #Input students
                puts ""
                puts "INPUT STUDENT MENU"
                puts "1. Input your own students"
                puts "2. Generate default student list"
                puts "9. Return to Main Menu"
                print "> "
                ans = gets.chomp
                
                
                case ans
                    when "1" then students = input_students
                    when "2" then students = default_students
                    when "9" then next
                    else "I don't know what you mean"
                end
               
                
            when "2"
                #print students
                if students.empty?
                    puts "Currently no students stored in the system!"
                    puts "1. Use Defaults"
                    puts "2. Input Manually"
                    puts "9. Return to Main Menu"
                    print "> "
                    ans = gets.chomp
                    case ans 
                        when "1" then students = default_students
                        when "2" then students = input_students
                        when "9" then next
                        else puts "I don't understand that"
                    end
                end
                    pad = calculate_padding(students,spacing)[1]
                    print_header(pad)
                    print_student_list(students,spacing)
                    print_footer(students,pad)
                    
            when "3"
                # Change Parameters
                changed_parameters = set_parameters(spacing,letter,max_characters)
                spacing = changed_parameters[0]
                letter = changed_parameters[1]
                max_characters = changed_parameters[2]
                puts "New Parameters"
                puts "Spacing of table: #{spacing}"
                puts "Start Letter: #{letter}"
                puts "Maximum No Characters: #{max_characters}"
            when "4"
                students = []
                puts "Students Cleared"
            
            when "5"
                puts "pending"
                
            when "9"
                exit 
            else 
                puts "I don't know what you mean"
            end
    end
    
end

def set_parameters(spacing, letter, max_characters)
    loop do
        puts "CURRENT PARAMETER MENU".center(30)
        puts "1. Spacing of table: #{spacing}"
        puts "2. Start Letter: #{letter}"
        puts "3. Maximum No Characters: #{max_characters}"
        puts "9. Exit"
        print "Choose number of variable you need to change >"
        ans = gets.chomp
        
        case ans
            when "1"
                spacing = change_variable(spacing)
            when "2"
                letter = change_variable(letter)
            when "3"
                max_characters = change_variable(max_characters)
            when "9"
                return [spacing,letter,max_characters]
            else
                "Please insert valid number"
        end
    end
end

def change_variable(variable)
    print "Insert new value for #{variable} (Return Blank to cancel) > "
    ans = gets.chomp 
    variable = ans unless ans.empty?
end
=begin
#Inputs
spacing = 10
letter = "D"
max_characters = 30

#Sorting and Filtering
#students = default_students
#students = input_students # Comment out for default students
students = first_letter_filter(students, letter)
students = character_length_filter(students, max_characters)
students = arrange_by_cohort(students)

if students.empty?
   puts "No Search Results"
   exit
end
#Calculating variables from generated student list
pad = calculate_padding(students,spacing)[1]

#Printing
print_header(pad)
print_student_list(students,spacing)
print_footer(students,pad)
#print_with_while(students)
=end
interactive_menu(default_students)