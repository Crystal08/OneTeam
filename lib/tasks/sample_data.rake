namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
   
    #helper methods used later:

    def create_request(location_id, employee_id) 
      #code to create and return one request for this employee/location
      #this assumes employees only post requests for their own location
      start_date = rand(6.months).ago
      end_date = start_date + 6.months
      new_request = Request.create!(employee_id: employee_id,
                                    task: Faker::Lorem.sentence(word_count = 10),
                                    start_date: start_date,
                                    end_date: end_date,
                                    title: Faker::Lorem.sentence(word_count = 4),
                                    location_id: location_id,
                                    group_id: rand(5-1) + 1)
      new_request
    end

    def create_response(request_id, employee_id)
      #code to create and return one response to this request
      #for this employee
      new_response = Response.create!(request_id: request_id,
                                      employee_id: employee_id,
                                      comments: Faker::Lorem.words(num = 5))
    end

    #It would be cool to have another method here-
    #sum, min, max, number of numbers
    #method to generate random addends 
    #def random_addends (sum, num_addends, min, max)
    #  addend_'n'= rand(min..(sum-#total of addends already)-num of addends left * min)
    #  update array to return
    #  shuffle results to take care of favoring first addends
    #end  
    
    #main code to create employees, requests, responses, and selections
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
   
    all_requests_ids = []
    one_request_ids = []
    ten_request_ids = []

    locations_with_employees.each do |location_id, number_employees|
      number_employees.times do |n|
        #create employees (all 128, 
        #divided up as in locations_with_employees):
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
          
          #create three requests such that three unique employees 
          #have just one request each
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

          #create more than 10 requests each for 
          #two more unique employees
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
    #each, so I get the additional selected employees are unique
    ten_request_employee_ids = ten_request_ids.map{|id|
      Request.find(id).employee_id}
    all_used_employee_ids = one_request_employee_ids + 
      ten_request_employee_ids

    #pseudo-randomly select the remaining 15 employees 
    #for the required 20 total, such 
    #that a few (3) come from each office, except Houston (specs),
    #so 5 offices x 3 employees each = 15 remaining employees

    location_employee_ids = {1=>[1,45], 2=>[46,50], 
      3=>[51,82], 4=>[83,96], 5=>[97,116], 
      6=>[117,128]} 

    available_location_employee_ids = location_employee_ids.except(3)
    remaining_request_location_ids = []
    remaining_request_employee_ids = []
 
    available_location_employee_ids.each do |loc_id, bounds|
      location_employees = []
      3.times do 
        employee_id = rand(bounds[0]..bounds[1])
        while all_used_employee_ids.include?(employee_id)
          employee_id = rand(bounds[0]..bounds[1])
          if location_employees.count > 1
            while location_employees.include?(employee_id)
              employee_id = rand(bounds[0]..bounds[1])
            end
          end    
        end
        location_employees << employee_id
        remaining_request_location_ids << loc_id
        remaining_request_employee_ids << employee_id
      end  
    end 

    #now choose how many requests to create for these 
    #15 employees in range 2 to 10 requests for each (specs)
    #I'm choosing to do 18 requests per office (18x5=90), 
    #(so that's per each set of 3 employees, divvied up randomly)
    #for a total of 90 more requests
    #making 120 total requests (specs) with previously created 30

    requests_per_employee = []
    5.times do 
      location_requests = [] 
      until location_requests.sum == 18 
        location_requests = []  
        num_req_1 = rand(2..10)
        num_req_2 = rand(2..10)
        num_req_3 = rand(2..10)
        location_requests = 
          location_requests.push(num_req_1, num_req_2, num_req_3) 
      end
      requests_per_employee = 
        requests_per_employee.push(num_req_1,num_req_2, num_req_3)
    end
    
    #combine location, employee, and number of requests info 
    #e.g. [[1,41,9], [1,30,3],
    #[1,5,6], [2,48,5], [2,47,7]]
    remaining_request_info = 
      remaining_request_location_ids.zip(remaining_request_employee_ids, 
        requests_per_employee)

    # and (finally, ta da!) create the remaining requests:    
    request_ids = []
    request_locations = []
    request_employees = []
    remaining_request_info.each do |location_id, employee_id, number_requests|
      number_requests.times do
        create_request(location_id, employee_id)
        request_ids << Request.last.id 
        request_locations << location_id
        request_employees << employee_id
      end
    end 

    # on to creating responses to the requests, according
    # to specs
    # no responses to requests from Mumbai (location 2)

    request_info = request_locations.zip(request_ids, request_employees)
    available_requests = request_info.delete_if {|loc, id, emp| loc == 2}
    available_request_ids = available_requests.map {|loc, id, emp| id}

    # select 9 requests to respond to "locally" (specs)
    local_request_ids = []
    while local_request_ids.count < 9
      local_request = available_request_ids.sample
      while local_request_ids.include?(local_request)
        local_request = available_request_ids.sample
      end
      local_request_ids << local_request  
    end  

    #Remember: location_employee_ids = {1=>[1,45], 2=>[46,50], 
    # 3=>[51,82], 4=>[83,96], 5=>[97,116], 
    # 6=>[117,128]} 
    #create the responses to the selected 9 requests, such
    #that the responding employee is not the posting employee
    local_request_ids.each do |id|
      request = Request.find(id)
      location_id = request.location_id
      poster_id = request.employee_id
      bounds =  location_employee_ids[location_id] 
      employee_id = rand(bounds[0]..bounds[1])
      while employee_id == poster_id
        employee_id = rand(bounds[0]..bounds[1])
      end
      create_response(id, employee_id)
    end  

    #create 2 personal responses: employee responded to own request
    personal_request_ids = []
    2.times do
      personal_request = available_request_ids.sample
      while personal_request_ids.include?(personal_request)
        personal_request = available_request_ids.sample
      end
      personal_request_ids << personal_request
    end

    personal_request_ids.each do |id|
      request = Request.find(id)
      employee_id = request.employee_id
      create_response(id, employee_id)
    end  

    #Will come back to creating remaining 59 responses
      
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