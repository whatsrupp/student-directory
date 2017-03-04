#Hash of students for testing purposes.
@default_students = [
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
   @students =[]
   months = %w(january february march april may june july august september october november december)
   default= "november"
   
   while true
      print "Student Name? (Return empty to finish student entry) > "
      name = STDIN.gets.chomp
      
      break if name.empty?
     
      while true
        print "Which Cohort? (Return for default - #{default}) > "
        cohort = STDIN.gets.chomp.downcase
        if months.include?(cohort)
            break
        elsif cohort.empty?
            cohort = default
            break
        else
            puts "Please insert valid month"
        end
      end
      
      @students << {name: name, cohort: cohort.to_sym}
      puts "Now we have #{@students.count} students"
   end
   
   if @students.empty?
      puts "Empty Student list, are you sure you want to continue?"
      puts "1. Continue"
      puts "2. Re-Enter Students"
      
      ans = STDIN.gets.chomp
      case ans
        when "1" then return 
        when "2" then input_students
        
      end
      
      
   end
end

########FILTERING AND ARRANGING ##############

def arrange_by_cohort
    
    @students = @students.sort_by {|student| student[:cohort].to_s}
    
end


def first_letter_filter
    @students.select! {|student| student[:name].downcase.start_with?(@search_letter.downcase)}
    puts "Searching for student names beginning with #{search_letter}"
    return @students
end

def character_length_filter
    @students.select! {|student| student[:name].length < @search_length}
    puts "Searching for student names less than #{@search_length} characters."
end

################# PRINTING METHODS ##############


def print_footer(pad)
    puts "-" * pad
    puts "Overall, we have #{@students.count} great student#{"s" unless @students.count == 1}.".center(pad)
    
end

def print_header(pad)
    puts "The students of Villains Academy".center(pad)
    puts ("-"*pad).center(pad)
end

def print_student_list(spacing)
    
    padding_hash = calculate_padding(spacing)[0]
   
    @students.each_with_index do |student, i|
        print "#{(i + 1).to_s.ljust(spacing)}" 
        student.each_key {|key| print "#{student[key].to_s.ljust(padding_hash[key])}" }
        print"\n"
    end
end

def calculate_padding (spacing)
    #assuming all hashes have the same key identifiers
    key_names = [] #initalise empty variables required
    key_lengths = {} 
    
    @students[0].each_key {|key| key_names << key} #STDIN.gets key names from student list
    l_total = 0
    
    #Iterate through each key and find the max length of each value in each student hash
    key_names.each do |key|
       l_max = 0
       @students.each do |student| 
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

######## MENU TEXT SET UP AND INITIALISATION METHODS #########

def print_main_menu
   
    puts ""
    puts "MAIN MENU".center(30)
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Change default search parameters"
    puts "4. Clear current student list"
    puts "5. Search Students"
    puts "6. Save Students to .csv"
    puts "7. Load Students from .csv"
    puts "9. Exit"
    print "> "
    
end

def input_student_menu
    
    #Input students
    puts ""
    puts "INPUT STUDENT MENU"
    puts "1. Input your own students"
    puts "2. Generate default student list"
    puts "9. Return to Main Menu"
    print "> "
    
    ans = STDIN.gets.chomp
    case ans
        when "1" then input_students
        when "2" then @students = @default_students
        when "9" then return
        else "I don't know what you mean"
    end

end

def sort_menu
   puts "SORT MENU"
   puts "1. Arrange by cohort"
   puts "9. Exit"
end

def initialise_variables
    @students = []
    #Default Parameters
    @spacing = 10
    @letter = "D"
    @max_characters = 30
    @input_students = []
    
end

######### MAIN MENU FUNCTIONALITY METHODS ########
def interactive_menu
        initialise_variables
        try_load_students
        main_menu_process
end

def main_menu_process 
    loop do
        print_main_menu
        ans = STDIN.gets.chomp
        
        case ans
            when "1" then input_student_menu
                
            when "2" then check_students; show_students
            
            when "3" then set_parameters
                
            when "4" then @students = []; puts "Students Cleared"
            
            when "5" then arrange_by_cohort; puts "Students arranged by cohort"
            
            when "6" then save_students
                
            when "7" then load_students
                
            when "9" then exit 
                
            else puts "I don't know what you mean"
        end
    end
end

####### UNDERLYING MENU METHODS
def show_students
    return if @students.empty?
    pad = calculate_padding(@spacing)[1]
    print_header(pad)
    print_student_list(@spacing)
    print_footer(pad)
end


def check_students
    if @students.empty?
        puts "Currently no students stored in the system!"
        puts "1. Use Defaults"
        puts "2. Input Manually"
        ans = STDIN.gets.chomp
        case ans 
            when "1" then @students = @default_students;
            when "2" then input_students; 
            else puts "I don't understand that"
        end
    end
end


def set_parameters
    loop do
        puts "CURRENT PARAMETER MENU".center(30)
        puts "1. Spacing of table: #{@spacing}"
        puts "2. Start Letter: #{@letter}"
        puts "3. Maximum No Characters: #{@max_characters}"
        puts "9. Exit"
        print "Choose number of variable you need to change >"
        ans = STDIN.gets.chomp
        
        case ans
            when "1"
                @spacing = change_variable(@spacing).to_i
            when "2"
                @letter = change_variable(@letter)
            when "3"
                @max_characters = change_variable(@max_characters).to_i
            when "9"
                puts "VARIABLES SAVED"
                puts "New Parameters"
                puts "Spacing of table: #{@spacing}"
                puts "Start Letter: #{@letter}"
                puts "Maximum No Characters: #{@max_characters}"
                return
            else
                "Please insert valid number"
        end
    end
end

def change_variable(variable)
    print "Insert new value for #{variable} (Return Blank to cancel) > "
    ans = STDIN.gets.chomp 
    variable = ans unless ans.empty?
end


def save_students 
    filename = "students.csv"
    input_filename
    
    File.open(filename, "w") do |f|
        f.truncate(0)
        
        @students.each do |student|
            student_data = [student[:name], student[:cohort]]
            csv_line = student_data.join(",")
            f.puts csv_line
        end
    end
    
    puts "Current student list written to #{filename} successfully."
    sleep(1)
    
end

def filename_check(filename)
      if File.exists?(filename)
         return true 
      else
          puts "File does not exist, using default"
          return false
      end
end

def input_filename
    while true
    print "Insert Filename to load/save students from/to, press return to use default > "
    filename = STDIN.gets.chomp
        if filename_check(filename)
            return filename
        else
            return "students.csv"
        end
    end
end

def load_students (filename = "students.csv")
    filename = input_filename
    
    File.open(filename,"r") do |f|
        @students =[]
        f.readlines.each do |line|
            name, cohort = line.chomp.split(",")
            @students << {name: name, cohort: cohort.to_sym}
        end
    end
    
    puts "Student list imported from #{filename}"
    sleep(1)
end


def try_load_students
    filename = ARGV.first
    filename = "students.csv" if filename.nil?
    if File.exists?(filename)
        load_students(filename)
        puts "Loaded #{@students.count} students from #{filename}"
    else
        puts "Sorry, #{filename} doesn't exist."
        exit
    end
end


#### RUN THE PROGRAMME #######


interactive_menu
