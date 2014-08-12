class InitialPopulateRequestSkill < ActiveRecord::Migration
  def up
  end

  def down
  end

  RequestSkill.create :skill_id => 1
  RequestSkill.create :skill_id => 2
  RequestSkill.create :skill_id => 3
  RequestSkill.create :skill_id => 4
  RequestSkill.create :skill_id => 5
  RequestSkill.create :skill_id => 6
  RequestSkill.create :skill_id => 7

end

