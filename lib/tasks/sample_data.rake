namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
   
    #helper methods (can I put these somewhere else?):

    def create_request(location_id, employee_id) 
      #code to create and return one request for this employee/location
      #this assumes employees only post requests for their own location
      new_request = Request.create!(employee_id: employee_id,
                                    task: Faker::Lorem.sentence(word_count = 10),
                                    #start_date: start_date,
                                    #end_date: end_date,
                                    title: Faker::Lorem.sentence(word_count = 4),
                                    location_id: location_id,
                                    group_id: rand(5-1) + 1)
      new_request
    end
  
    #end of helper methods and beginning of main code to 
    #create employees, requests, responses, and selections
    #as per specs 

    # 1..6 are Chicago, Mumbai, Houston, San Francisco,
    # Boston, and London 
    #Employees will be created
    #in these numbers AND this order, so employees 1-45 are 
    #from Chicago, 46-50 from Mumbai and so forth, this is 
    #needed later, when remaining requests are created 
    #after the initial loop

    locations_with_employees = {1=>45, 2=>5, 
      3=>32, 4=>14, 5=>20, 6=>12}
    location_employee_ids = {1=>[1,45], 2=>[46,50], 
     3=>[51,82], 4=>[83,96], 5=>[97,116], 
     6=>[117,128]} 

    all_requests_ids = []
    one_request_ids = []
    ten_request_ids = []

    locations_with_employees.each do |location_id, number_employees|
      number_employees.times do |n|
        #create employees:
        Employee.create!(first_name: Faker::Name.first_name,
                         last_name: Faker::Name.last_name,
                         email: "employee-#{n+1}@aits.com",
                         about_me: Faker::Lorem.paragraph(sentence_count = 2),
                         years_with_company: rand(10-1) + 1,
                         manager: Faker::Name.name,
                         position_id: rand(5-1) + 1,
                         department_id: rand(1-1) + 1,
                         group_id: rand(5-1) + 1,
                         location_id: location_id,
                         password: "foobar",
                         password_confirmation: "foobar")
        
        #create requests for one-request and more-than-ten-requests employees:
        all_requests_count = all_requests_ids.size 
        one_request_count = one_request_ids.size
        ten_request_count = ten_request_ids.size
        employee_id = Employee.last.id
        #directed not to have any requests from Houston, and 120 requests total
        #actually the <120 may not be necessary here b/c if the other conditions are
        #met, then the requests created in the rest of this loop total just 30 anyway
        if location_id != 3 && all_requests_count < 120
          
          #create three requests such that three employees have just one request each
          if location_id == 2 && one_request_count < 1
            new_request = create_request(location_id, employee_id)
            one_request_ids << new_request.id
            all_requests_ids << new_request.id

          elsif location_id == 4 && one_request_count < 2
            new_request = create_request(location_id, employee_id)
            one_request_ids << new_request.id
            all_requests_ids << new_request.id

          elsif location_id == 5 && one_request_count < 3
            new_request = create_request(location_id, employee_id)
            one_request_ids << new_request.id
            all_requests_ids << new_request.id
          end

          #create more than 10 requests each for two employees
          if location_id == 1 && ten_request_count < 12
            12.times do 
              new_request = create_request(location_id, employee_id)
              ten_request_ids << new_request.id
              all_requests_ids << new_request.id
            end 

          elsif location_id == 6 && ten_request_count < 27 
            15.times do 
              new_request = create_request(location_id, employee_id)
              ten_request_ids << new_request.id
              all_requests_ids << new_request.id
            end
          end 
        end
      end  
    end

    #I put generating the remaining requests outside the initial
    #create-employees loop so that all employees are already 
    #created and available to be chosen for the remaining requests
       
    #to make sure I don't add requests to the three employees who should
    #only have one each
    one_request_employee_ids = one_request_ids.map{|id| 
      Request.find(id).employee_id}  

    #to make sure I don't re-use the two employees with over ten requests
    #each, so I get the additional 15 unique employees needed 
    ten_request_employee_ids = ten_request_ids.map{|id|
      Request.find(id).employee_id}

    #select the remaining 15 employees for the required 20 total
    #then create between 1 and 11 requests for each employee
    #for a total of 90 more requests,
    #(b/c with the original 30 requests (above) 
    #that makes 120 total requests as required)

    #Next: check this code in the console:
    remaining_request_employee_ids = []
    while remaining_request_employee_ids.count < 15 
      remaining_request_employee_id = rand(1..128)
      while one_request_employee_ids.include?(remaining_request_employee_id)
        || ten_request_employee_ids.include?(remaining_request_employee_id)
      remaining_request_employee_ids << rand(2..10)
      end
    end  

    #Remember from the beginning:
    #locations_with_employees = {1=>45, 2=>5,
    #  3=>32, 4=>14, 5=>20, 6=>12}
    #location_employee_ids = {1=>[1,45], 2=>[46,50],
    #  3=>[51,82], 4=>[83,96], 5=>[97,116],
    #  6=>[117,128]} 

    #I simply divided the remaining requests among the available offices
    location_requests = {1=>18, 
      2=>18, 4=>18, 
      5=>18, 6=>18} 

    #create the generated number of requests for each location
    location_requests.each do |location_id, number_requests|
      number_requests.times do 
        employee_id_min = location_employee_ids[location_id][0]
        employee_id_max = location_employee_ids[location_id][1]
        employee_id = rand(employee_id_min .. employee_id_max)
        while one_request_employee_ids.include?(employee_id)
         employee_id = rand(employee_id_min .. employee_id_max)
        end
        new_request = create_request(location_id, employee_id)
      end
    end        

    #fill the app's other resources
    Department.create!(name: "IT")
    
    groups = ["Development","Interface Design",
     "QA", "Infrastructure"]
    groups.each do |group_name|
      Group.create!(name: group_name)
    end

    locations = ["Chicago", "Mumbai", "Houston",
     "San Francisco", "Boston", "London"]
    locations.each do |location_name|
      Location.create!(name: location_name)
    end
    
    positions = ["Engineer", "Analyst",
     "Project Lead", "UI Specialist", "QA Specialist"]  
    positions.each do |position_name|
      Position.create!(name: position_name)
    end

    skills = ["PHP", "MySQL", "C#", "Apache", 
      "Ruby on Rails", "SQL Server", "Linux"]
    skills.each do |skill_name|
      Skill.create!(name: skill_name)
    end 
  end
end