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

def print_student_list(students)
    
   padding_hash = find_max_padding(students)
   
    students.each_with_index do |student, i|
        print "#{i + 1}.\t" 
        student.each_key {|key| print "#{student[key].to_s.capitalize.ljust(padding_hash[key] + 5)}" }
        print"\n"
    end
end

def arrange_by_cohort(students)
    
    arranged_students = []
    cohort_array =[]
    students.each {|student| cohort_array << student[:cohort]}
    cohort_array.uniq!.sort!
    cohort_array.each do |cohort|
        arranged_students += students.map{|student| student if student[:cohort] == cohort}.compact
    end
    return arranged_students
    
end

def find_max_padding (students)
    #assuming all hashes have the same key identifiers
    key_names = [] #initalise empty variables required
    key_lengths = {} 
    students[0].each_key {|key| key_names << key} #gets key names from student list
    
    #Iterate through each key and find the max length of each value in each student hash
    key_names.each do |key|
       l_max = 0
       students.each {|student| l_max = student[key].length if student[key].length > l_max}
       key_lengths[key] = l_max
        
    end
    
    key_lengths
    
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

students = arrange_by_cohort(students)
#puts "HELLO #{students}"
print_header(pad)
print_student_list(students)
print_footer(students,pad)
find_max_padding(students)
arrange_by_cohort(students)
#print_with_while(students)

