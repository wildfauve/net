class IcpPort < SoapPort::Port
  
  attr_accessor :icp_details
  
  def self.load_wsdl
    @registry = Savon.client(:wsdl => Setting.reg(:wsdl) )
  end
  
  def self.end_point
    @registry
  end
  
  def initialize
    @reg.nil? ? @reg = IcpPort.load_wsdl : @reg = IcpPort.end_point
    @user_name = Setting.reg(:user_name)
    @password = Setting.reg(:password)
    self
  end
  
  def get_icp_details(icp_id: nil)
    raise if icp_id.nil?
    circuit(:get_icp_details_interface, icp_id)
    self
  end

  def get_icp_details_interface(icp_id)
    msg = { userName: @user_name, password: @password, icpId: icp_id}
    self.send_to_port(pattern: :sync, message: msg, connection: {object: @reg, method: :icp_details_v1}, response_into: {inst_var: "@icp_details", soap_root: :icp_details_v1_response})
  end
  
end