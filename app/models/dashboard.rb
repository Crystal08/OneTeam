class Dashboard 
  
  def select_all(query)
  	ActiveRecord::Base.connection.select_all(query)
  end 	

  def requests_summary
    select_all("SELECT 
    	            strftime('%Y-%m',req.created_at) 
    	            AS request_post_date, 
    	            req.title,
    	            loc.name 
                  AS request_location,
    	            emp.first_name ||' '|| emp.last_name
    	            AS selected_employee, 
    	            emp_location.name 
                  AS employee_location
    	          FROM requests req 
    	          LEFT OUTER JOIN locations loc 
    	          ON req.location_id = loc.id
    	          LEFT OUTER JOIN responses res 
    	          ON res.request_id = req.id
    	          LEFT OUTER JOIN selections sel
    	          ON sel.response_id = res.id
    	          LEFT OUTER JOIN employees emp
    	          ON res.employee_id = emp.id
    	          LEFT OUTER JOIN locations emp_location
    	          ON emp.location_id = emp_location.id
    	          ORDER BY req.location_id, 
                  emp.last_name DESC,
    	            req.created_at")	
  end

  def requests_summary_by_month
  	select_all("SELECT
                  strftime('%Y-%m',req.created_at)
                  AS month,
                  COUNT(DISTINCT req.id) 
                  AS req,
                  COUNT(DISTINCT res.request_id)
                  AS req_w_res,
                  COUNT(sel.response_id) 
                  AS req_w_sel,
                  COUNT(req.status='cancelled')
                  AS cancelled
                FROM requests req
                LEFT OUTER JOIN responses res
                ON res.request_id = req.id
                LEFT OUTER JOIN selections sel 
                ON sel.response_id = res.id
                GROUP BY 
                  strftime('%Y-%m',req.created_at)")
  end

  def requests_time_to_fill
  	select_all("SELECT
                  SUM(t.days <= 1) AS 'less_than_1',
                  SUM(t.days>1 AND t.days <=3) 
                    AS 'between_1_and_3',
                  SUM(t.days>3 AND t.days <=6)
                    AS 'between_3_and_6',
                  SUM(t.days>6) AS 'greater_than_6'
                FROM
                  (SELECT
                     (julianday(sel.created_at) -
                      julianday(req.created_at)) days
                   FROM requests req
                   JOIN responses res 
                   ON res.request_id = req.id
                   JOIN selections sel 
                   ON sel.response_id = res.id) t")
  end	

  def employees_w_skill_interest_by_location
    select_all("SELECT skill.name AS skill,
                  SUM(CASE emp.location_id 
                      WHEN 1
                      THEN 1 END) AS Chicago,
                  SUM(CASE emp.location_id 
                      WHEN 2
                      THEN 1 END) AS Mumbai,
                  SUM(CASE emp.location_id
                      WHEN 3
                      THEN 1 END) AS Houston,
                  SUM(CASE emp.location_id
                      WHEN 4
                      THEN 1 END) AS San_Fran,
                  SUM(CASE emp.location_id
                      WHEN 5
                      THEN 1 END) AS Boston,
                  SUM(CASE emp.location_id
                      WHEN 6
                      THEN 1 END) AS London
                FROM employee_desired_skills emp_skill
                JOIN employees emp 
                ON emp_skill.employee_id = emp.id
                JOIN skills skill ON emp_skill.skill_id = skill.id
                WHERE emp_skill.interest_level != 0
                GROUP BY emp_skill.skill_id")
  end

  def average_employee_skill_interest_by_location
    select_all("SELECT skill.name AS skill,
                  ROUND( 
                  (AVG(CASE emp.location_id
                       WHEN 1 
                       THEN emp_skill.skill_level END)), 
                  2) AS Chicago,
                  ROUND( 
                  (AVG(CASE emp.location_id
                       WHEN 2 
                       THEN emp_skill.skill_level END)), 
                  2) AS Mumbai,
                  ROUND( 
                  (AVG(CASE emp.location_id
                       WHEN 3 
                       THEN emp_skill.skill_level END)), 
                  2) AS Houston,
                  ROUND( 
                  (AVG(CASE emp.location_id
                       WHEN 4 
                       THEN emp_skill.skill_level END)), 
                  2) AS San_Fran,
                  ROUND( 
                  (AVG(CASE emp.location_id
                       WHEN 5 
                       THEN emp_skill.skill_level END)), 
                  2) AS Boston,
                  ROUND( 
                  (AVG(CASE emp.location_id
                       WHEN 6 
                       THEN emp_skill.skill_level END)), 
                  2) AS London
                FROM employee_current_skills emp_skill
                JOIN employees emp ON emp_skill.employee_id = emp.id
                JOIN skills skill ON emp_skill.skill_id = skill.id
                WHERE emp_skill.skill_level != 0
                GROUP BY emp_skill.skill_id")
  end

  def request_developers_per_office
    select_all("SELECT loc.name AS visitors,
                COUNT(DISTINCT 
                      CASE
                      WHEN req.location_id = 1
                      THEN res.employee_id END) AS Chicago,
                COUNT(DISTINCT
                      CASE
                      WHEN req.location_id = 2
                      THEN res.employee_id END) AS Mumbai,
                COUNT(DISTINCT
                      CASE
                      WHEN req.location_id = 3
                      THEN res.employee_id END) AS Houston,
                COUNT(DISTINCT
                      CASE
                      WHEN req.location_id = 4
                      THEN res.employee_id END) AS San_Fran,
                COUNT(DISTINCT
                      CASE
                      WHEN req.location_id = 5
                      THEN res.employee_id END) AS Boston,
                COUNT(DISTINCT
                      CASE
                      WHEN req.location_id = 6
                      THEN res.employee_id END) AS London
                FROM requests req
                JOIN responses res ON res.request_id = req.id
                JOIN selections sel ON sel.response_id = res.id
                JOIN employees emp ON res.employee_id = emp.id
                JOIN locations loc ON emp.location_id = loc.id
                WHERE req.created_at <
                  (SELECT DATETIME(MIN(req.created_at),'+6 month') 
                   FROM requests req)
                GROUP BY emp.location_id
                ORDER BY emp.location_id")
  end

  def offices_worked_in_for_each_developer
    select_all("SELECT emp.last_name AS Name,
                COUNT(DISTINCT req.location_id) AS Total,
                COUNT(DISTINCT 
                      CASE
                      WHEN sel.created_at > date('now','-1 month')
                      THEN req.location_id END) AS '-1Mo',
                COUNT(DISTINCT 
                      CASE
                      WHEN sel.created_at > date('now','-2 month')
                      AND sel.created_at <= date('now','-1 month')
                      THEN req.location_id END) AS '-2Mo',
                COUNT(DISTINCT 
                      CASE
                      WHEN sel.created_at > date('now','-3 month')
                      AND sel.created_at <= date('now','-2 month')
                      THEN req.location_id END) AS '-3Mo',
                COUNT(DISTINCT 
                      CASE
                      WHEN sel.created_at > date('now','-4 month')
                      AND sel.created_at <= date('now','-3 month')
                      THEN req.location_id END) AS '-4Mo',
                COUNT(DISTINCT 
                      CASE
                      WHEN sel.created_at > date('now','-5 month')
                      AND sel.created_at <= date('now','-4 month')
                      THEN req.location_id END) AS '-5Mo',
                COUNT(DISTINCT 
                      CASE
                      WHEN sel.created_at > date('now','-6 month')
                      AND sel.created_at <= date('now','-5 month')
                      THEN req.location_id END) AS '-6Mo'
                FROM requests req
                JOIN responses res ON res.request_id = req.id
                JOIN selections sel ON sel.response_id = res.id
                JOIN employees emp ON res.employee_id = emp.id
                GROUP BY emp.last_name
                ORDER BY emp.last_name;")
  end
end  
