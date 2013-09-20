e# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Creating Departments"

Department.create(name: "IT")

puts "Creating Groups"

["Development","Interface Design",
     "QA", "Infrastructure"].each do |group|
  Group.find_or_create_by_name(group)
end

puts "Creating Positions"

["Engineer", "Analyst",
     "Project Lead", "UI Specialist", "QA Specialist"].each do |position|
  Position.find_or_create_by_name(position)
end 

puts "Creating Skills"

["PHP", "MySQL", "C#", "Apache", 
      "Ruby on Rails", "SQL Server", "Linux"].each do |skill|
  Skill.find_or_create_by_name(skill)  
end         	

puts "Creating Locations"

{"Chicago" => [41.8781136,-87.6297981], 
 "Mumbai" => [19.0759837, 72.8776559],
 "Houston" => [29.7601927, -95.3693896], 
 "San Francisco" => [37.7749295,-122.4194155],
 "Boston" => [42.3584308, -71.0597732], 
 "London" => [51.5112139, -0.1198244]}.each do |location, coordinates|
 	Location.find_or_create_by_name(location, 
 	  latitude: coordinates[0],
 	  longitude: coordinates[1])
end 	




  
