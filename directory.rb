#Hash of students for testing purposes.
students = [
    {name: "Dr. Hannibal Lecter",           cohort: :march,     hobby: :coding},
    {name: "Darth Vader",                   cohort: :april,     hobby: :coding},
    {name: "Nurse Ratched",                 cohort: :april,     hobby: :coding},
    {name: "Michael Corleone",              cohort: :march,     hobby: :coding},
    {name: "Alex DeLarge",                  cohort: :november,  hobby: :coding},
    {name: "The Wicked Witch of the West",  cohort: :november,  hobby: :coding},
    {name: "Terminator",                    cohort: :november,  hobby: :coding},
    {name: "Freddy Krueger",                cohort: :november,  hobby: :coding},
    {name: "The Joker",                     cohort: :november,  hobby: :coding},
    {name: "Joffrey Baratheon",             cohort: :november,  hobby: :coding},
    {name: "Jeremy Bowers",                 cohort: :november,  hobby: :coding},
    {name: "Norman Bates",                  cohort: :november,  hobby: :coding}
]

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


def print_header(pad)
    puts "The students of Villains Academy".center(pad)
    puts "--------------------------------".center(pad)
end

def print_by_name(students)
    
    students.each_with_index do |student, i|
        print "#{i + 1}.\t" #{student[:name]} (#{student[:cohort]} cohort)".center(pad)
        student.each_key {|key| print "#{student[key].to_s.capitalize}\t" }
        print"\n"
    end
end

def print_by_cohort(student)
    students
    
end

def find_max_padding (students)
    #assuming all hashes have the same key identifiers
    key_names = []
    students[0].each_key {|key| key_names << key}
    #Extracts key names and keeps them as symbols
    key_lengths = {}
    
    key_names.each do |key|
       l_max = 0
       
       students.each {|student| l_max = student[key].length if student[key].length > l_max}
       
       key_lengths[key] = l_max
        
    end
    
    puts key_lengths
    
end

def filter(students, search_letter, search_length)
    puts "Pupils beginning with #{search_letter} and less than #{search_length} characters."
    students.select! {|student| student[:name].downcase.start_with?(search_letter.downcase)}
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

def print_footer(names,pad)
    puts "Overall, we have #{names.count} great students.".center(pad)
end






#students = input_students
#students = filter(students, "", 18)

pad = 80

print_header(pad)
print_by_name(students)
print_footer(students,pad)
find_max_padding(students)
#print_with_while(students)

