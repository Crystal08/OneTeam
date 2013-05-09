namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    def create_employee (n, location_id)
      Employee.create(first_name: Faker::Name.first_name,
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
      3.times do
        EmployeeCurrentSkill.create(employee_id: Employee.last.id,
                                  skill_id: rand(1..7),
                                  skill_level: rand(1..5))
        EmployeeDesiredSkill.create(employee_id: Employee.last.id,
                                  skill_id: rand(1..7),
                                  interest_level: rand(1..5))
      end  
    end
      
    def create_request(location_id, employee_id) 
      start_date = rand(6.months).ago
      end_date = start_date + rand(6.months)
      req_created_at = start_date - rand(3.months)

      Request.create(employee_id: employee_id,
                      task: Faker::Lorem.sentence(word_count = 10),
                      start_date: start_date,
                      end_date: end_date,
                      title: Faker::Lorem.sentence(word_count = 4),
                      location_id: location_id,
                      group_id: rand(5-1) + 1,
                      created_at: req_created_at)
      3.times do
        RequestSkill.create(request_id: Request.last.id,
                            skill_id: rand(1..7))
      end                      
    end

    def create_response(request_id, employee_id)
      res_delays = [1.days, 2.days, 4.days, 8.days]
      res_created_at = Request.find(request_id).created_at 
        + res_delays.sample

      Response.create(request_id: request_id,
                       employee_id: employee_id,
                       comments: Faker::Lorem.words(num = 8),
                       created_at: res_created_at)  
    end

    def create_selection(response_id)
      sel_delays = [0.days, 1.days, 3.days, 5.days]
      sel_created_at = Response.find(response_id).created_at 
        + sel_delays.sample
      Selection.create(response_id: response_id,
                        notes: Faker::Lorem.words(num = 4),
                        created_at: sel_created_at)
    end

    def unique_randoms(size_of_desired_set, sample_set)
      new_set = []
      size_of_desired_set.times do
        element = sample_set.sample
        while new_set.include?(element)
          element = sample_set.sample
        end
      new_set << element
      end
      new_set
    end 

    location_names_and_ids = {"Chicago"=>1, "Mumbai"=>2,
      "Houston"=>3, "San Francisco"=>4, "Boston"=>5, 
      "London"=>6}
    location_ids_with_num_employees = {1=>45, 2=>5, 3=>32, 
      4=>14, 5=>20, 6=>12}
   
    #Create employees
    employee_ids_indexed_by_location_id = {}

    location_ids_with_num_employees.each do |loc_id, num_employees|
      emp_ids_array = []
      num_employees.times do |n| 
        create_employee(n, loc_id)
        employee_id = Employee.last.id
        emp_ids_array << employee_id
      end
      employee_ids_indexed_by_location_id[loc_id] = 
          emp_ids_array
      # e.g. employee_ids_indexed_by_location_id = { 1 => [1,2,3,4,..45],
      # 2 => [1,2,3,4,5]..}     
    end
    
    #Create requests
    #locations with num of requests per each developer who posted
    #20 developers posted, for total of 120 requests as per specs
    #no requests from location 3 (Houston) as per specs
    location_ids_with_num_requests = {1=>[1,2,10,6], 
      2=>[12,3,9,6], 4=>[1,4,9,5], 5=>[15,5,5,8], 
      6=>[1,7,4,7]} 
    
    request_ids_indexed_by_location_id = {}

    location_ids_with_num_requests.each do |loc_id, num_requests|
      req_ids_array = []
      employee_ids = unique_randoms(num_requests.size, 
        employee_ids_indexed_by_location_id[loc_id])
      employee_ids_with_num_requests =
        Hash[employee_ids.zip(num_requests)]
      #e.g. employee_ids_with_num_requests = {21=>1, 27=>2, 32=>10, 44=>6}  

      employee_ids_with_num_requests.each do |emp_id, num_requests|  
        num_requests.times do 
          employee_id = emp_id
          location_id = loc_id
          create_request(location_id, employee_id)
          request_id = Request.last.id
          req_ids_array << request_id
        end 
      end
      request_ids_indexed_by_location_id[loc_id] =
          req_ids_array 
        # e.g. request_ids_indexed_by_location_id = { 1 => [1,2,3,4,..19],
        # 2 => [20,21..30]..} 
    end 
            
    #Create responses
    #all requests from 6 get 3 responses, 0 to requests from 2, as per specs
    #at least 9 "local" responses, 2 "personal" responses, as per specs
    #total responses, 70, as per specs
    local_response_ids = []
    personal_response_ids = []
    all_response_ids = []
    responses_count = 0
    [1,4,5,6,'extra'].each do |loc_id|  
      if loc_id == 1
        3.times do #3/9 local responses
          request_id = request_ids_indexed_by_location_id[loc_id].sample
          employee_id = employee_ids_indexed_by_location_id[loc_id].sample
          create_response(request_id, employee_id)
          local_response_ids << Response.last.id
          all_response_ids << Response.last.id
          responses_count += 1
        end 
        
      elsif loc_id == 4
        3.times do #6/9 local responses
          request_id = request_ids_indexed_by_location_id[loc_id].sample
          employee_id = employee_ids_indexed_by_location_id[loc_id].sample
          create_response(request_id, employee_id)
          local_response_ids << Response.last.id
          all_response_ids << Response.last.id 
          responses_count += 1  
        end
        1.times do #1/2 personal responses
          request_id = request_ids_indexed_by_location_id[loc_id].sample
          employee_id = Request.find(request_id).employee.id
          create_response(request_id, employee_id)
          personal_response_ids << Response.last.id
          all_response_ids << Response.last.id
          responses_count += 1
        end  
        
      elsif loc_id == 5
        3.times do #9/9 local responses
          request_id = request_ids_indexed_by_location_id[loc_id].sample
          employee_id = employee_ids_indexed_by_location_id[loc_id].sample
          create_response(request_id, employee_id)
          local_response_ids << Response.last.id
          all_response_ids << Response.last.id
          responses_count += 1
        end   
        
      elsif loc_id == 6
        request_ids_indexed_by_location_id[loc_id].each do |req_id|
          request_id = req_id
          3.times do #3 responses per each loc 6 request
            employee_id = employee_ids_indexed_by_location_id.values.flatten.sample
            create_response(request_id, employee_id)
            all_response_ids << Response.last.id
            responses_count += 1
          end  
        end
        1.times do #2/2 personal responses
          request_id = request_ids_indexed_by_location_id[loc_id].sample
          employee_id = Request.find(request_id).employee.id
          create_response(request_id, employee_id)
          personal_response_ids << Response.last.id
          all_response_ids << Response.last.id
          responses_count += 1
        end

      else #extra responses to reach 70 total
        remaining = 70 - responses_count
        remaining.times do
          employee_id = employee_ids_indexed_by_location_id.values.flatten.sample
          request_id = request_ids_indexed_by_location_id.values.flatten.sample
          create_response(request_id, employee_id)
          all_response_ids << Response.last.id
        end  
      end
    end 

    #Create selections
    #Total selections, 50, as per specs 
    locals = []
    7.times do #7 of the 9 local responses selected, specs
      response_id = local_response_ids.sample 
      while locals.include?(response_id) #to choose a new response
        response_id = local_response_ids.sample
      end

      create_selection(response_id)
      locals << response_id 
    end  

    personals = []
    1.times do #1 of the 2 personal responses selected, specs
      response_id = personal_response_ids.sample
      create_selection(response_id)
      personals << response_id
    end  

    used_response_ids = locals + personals
    available_response_ids = all_response_ids - used_response_ids
    generics = []
    42.times do #remaining 42 selections for required total of 50
      response_id = available_response_ids.sample
      while generics.include?(response_id) #to choose a new response
        response_id = available_response_ids.sample
      end
      
      create_selection(response_id)
      generics << response_id
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