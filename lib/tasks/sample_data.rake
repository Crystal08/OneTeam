namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    def create_employee (location_id)
      new_employee = Employee.create(
                       first_name: Faker::Name.first_name,
                       last_name: Faker::Name.last_name,
                       email: Faker::Internet.email,
                       about_me: Faker::Lorem.paragraph(sentence_count = 1),
                       years_with_company: rand(1..10),
                       manager: Faker::Name.name,
                       position_id: rand(1..5),
                       department_id: 1,
                       group_id: rand(1..4),
                       location_id: location_id,
                       password: "foobar",
                       password_confirmation: "foobar")
      (1..7).each do |n|
        EmployeeCurrentSkill.create(employee_id: new_employee.id,
                                    skill_id: n,
                                    skill_level: rand(0..4))
      end

      (1..7).each do |n|  
        EmployeeDesiredSkill.create(employee_id: new_employee.id,
                                    skill_id: n,
                                    interest_level: rand(0..4))
      end   
    end  

    def create_request(employee_id)
      start_date = rand(6.months).ago
      end_date = start_date + rand(6.months)
      req_created_at = start_date 

      new_request = Request.create(employee_id: employee_id,
                     task: Faker::Lorem.words(num=4).join(' ').capitalize,
                     start_date: start_date,
                     end_date: end_date,
                     title: Faker::Lorem.words(num=2).join(' ').capitalize,
                     location_id: Employee.find(employee_id).location_id,
                     group_id: rand(1..4),
                     created_at: req_created_at)
      rand(7).times do
        RequestSkill.create(request_id: new_request.id,
                            skill_id: rand(1..7))
      end 
    end
    
    def create_response(request_id, employee_id)
      res_delays = [1.days, 2.days, 4.days, 8.days]
      res_created_at = 
        Request.find(request_id).created_at + res_delays.sample

      @new_response = Response.create(request_id: request_id,
                       employee_id: employee_id,
                       comments: Faker::Lorem.words(num=2).join(' ').capitalize,
                       created_at: res_created_at)  
    end

    def location_employee_ids (location_id)
      Employee.find_all_by_location_id(location_id).map(&:id)
    end 

    def location_request_ids (location_id)
      Request.find_all_by_location_id(location_id).map(&:id)
    end  

    def all_employee_ids
      Employee.all.map(&:id)
    end 

    def non_local_employees(location_id)
      all_employee_ids - location_employee_ids(6)
    end  

    def all_request_ids
      Request.all.map(&:id)
    end   

    def all_response_ids
      Response.all.map(&:id)
    end  

    def ids_for_requests_with_responses
      Response.all.map(&:request_id).uniq 
    end 

    def available_request_ids
      available_request_ids = []
      [1,4,5].each do |loc_id|
        available_request_ids.concat(location_request_ids(loc_id))
      end
      available_request_ids
    end 

    def request_location_id(request_id) 
      Request.find(request_id).location_id
    end  

    def ids_for_requests_with_selections
      selected_response_ids = Selection.all.map(&:response_id)
      selected_response_ids.map{|res_id| 
        Response.find(res_id).request_id}.uniq
    end 

    def unselected_request_ids
      ids_for_requests_with_responses - 
        ids_for_requests_with_selections
    end       

    def create_selection(response_id)
      sel_delays = [0.days, 1.days, 3.days, 5.days]
      sel_created_at = 
        Response.find(response_id).created_at + sel_delays.sample
      @new_selection = Selection.create(response_id: response_id,
                       notes: Faker::Lorem.words(num=2).join(' ').capitalize,
                       created_at: sel_created_at)
    end

    #Employees: 45 in Chicago, 5 in Mumbai, 32 in Houston,
    #14 in San Francisco, 20 in Boston, 12 in London
    
    location_employee_totals = {1=>45, 2=>5, 3=>32, 
      4=>14, 5=>20, 6=>12}

    location_employee_totals.each do |location_id, n|
      n.times do 
        create_employee(location_id)
      end    
    end

    #Requests, 120: None from Houston, few each from remaining locations
    
    #2 employees posted more than 10 times
    [13,14].each do |n|
      employee_id = location_employee_ids(1)[n-13]
      n.times do
        create_request(employee_id)
      end  
    end   
   
    #3 employees posted once 
    employee_id = location_employee_ids(2).first
    create_request(employee_id)

    2.times do |n|
      employee_id = location_employee_ids(6)[n]
      create_request(employee_id)
    end

    #remainder of requests, distributed among remaining offices
    [location_employee_ids(4), location_employee_ids(5)].each do |ids|
      9.times do |n|
        employee_id = ids[n]
        5.times do
          create_request(employee_id) 
        end
      end
    end

    #Responses, 70: Need at least 50 unique requests represented,
    #no responses to Mumbai requests 
   
    #9 local responses for 9 unique requests
    available_location_ids = [1,4,5]
    local_response_ids = []
    9.times do |n|
      location_id = available_location_ids.sample
      request_id = 
        location_request_ids(location_id).sample
      while ids_for_requests_with_responses.include?(request_id)  
        location_id = 
          available_location_ids.sample
        request_id = 
          location_request_ids(location_id).sample
      end    
      employee_id = 
        location_employee_ids(location_id).sample
      create_response(request_id, employee_id)
      local_response_ids.push(@new_response.id)
    end  

    #2 personal responses for 2 unique requests
    personal_response_ids = []
    2.times do |n|
      location_id = available_location_ids.sample
      request_id = 
        location_request_ids(location_id).sample
      while ids_for_requests_with_responses.include?(request_id)
        location_id = 
          available_location_ids.sample
        request_id = 
          location_request_ids(location_id).sample
      end    
      employee_id = Request.find(request_id).employee_id
      create_response(request_id, employee_id)
      personal_response_ids.push(@new_response.id)
    end  

    #3 responses to each London request, non-local
    location_request_ids(6).each do |req_id| 
      3.times do 
        request_id = req_id
        employee_id = non_local_employees(6).sample
        create_response(request_id, employee_id)
      end  
    end 

    #remaining responses 
    remaining_responses = 70 - 
      all_response_ids.count
    remaining_responses.times do |n|
      request_id = available_request_ids.sample
      loc_id = request_location_id(request_id)
      employee_id = non_local_employees(loc_id).sample 
      while ids_for_requests_with_responses.include?(request_id)  
        request_id = available_request_ids
.sample
        loc_id = request_location_id(request_id)
        employee_id = non_local_employees(loc_id).sample 
      end   
      create_response(request_id, employee_id)
    end

    #Selections, 50, each selection must be for a unique request

    #7 of the 9 local responses are selected, so
    #7 unique request selections
    7.times do |n|
      response_id = local_response_ids[n]
      create_selection(response_id)
    end  

    #1 of the 2 personal responses is selected, so 
    #1 unique request selection
    response_id = personal_response_ids.first
    create_selection(response_id)

    #remaining selections, 
    #42 more unique request selections
    42.times do      
      request_id = unselected_request_ids.first
      response_id = Request.find(request_id).responses.first.id
      create_selection(response_id)
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