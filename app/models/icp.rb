class Icp
  
  include Wisper::Publisher
  
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  field :icp_id, type: String
  field :switch_state, type: Symbol
  field :meter_switch_state, type: Symbol
  
  has_one :location
  
  def self.create_me(icp: nil)
    icp = self.new.update_attrs(icp: icp)
  end
  
  def update_attrs(icp: nil)
    self.icp_id = icp[:icp_id]
    self.switch_state = determine_state(icp[:switch_in_progress])
    self.meter_switch_state = determine_state(icp[:switch_in_progres_mep])
    raise
    self.save!
  end
  
  def determine_state(switch)
    switch ? :switch_in_progress : :no_switch
  end
  
  
  
  
end