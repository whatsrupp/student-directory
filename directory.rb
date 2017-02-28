#Hash of students for testing purposes.
students = [
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

def print_student_list(students,spacing)
    
   padding_hash = calculate_padding(students, spacing)[0]
   
    students.each_with_index do |student, i|
        print "#{(i + 1).to_s.ljust(spacing)}" 
        student.each_key {|key| print "#{student[key].to_s.ljust(padding_hash[key])}" }
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



#Inputs
spacing = 5
letter = ""
max_characters = 25

#students = input_students
students = first_letter_filter(students, letter)
students = character_length_filter(students, max_characters)


students = arrange_by_cohort(students)
arrange_by_cohort(students)
pad = calculate_padding(students,spacing)[1]
print_header(pad)
print_student_list(students,spacing)
print_footer(students,pad)
calculate_padding(students,spacing)
#print_with_while(students)

