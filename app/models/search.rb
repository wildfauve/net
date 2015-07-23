class Search
  include Wisper::Publisher
  
  include Mongoid::Document
  include Mongoid::Timestamps  
  
  field :icp, :type => String

  def perform(params)
    begin
      icp = IcpPort.new.get_icp_details(icp_id: params[:icp])  
      NetworkHandler.new(icp: icp).find_or_create
    rescue SoapPort::Port::Error => e
      raise
    end
    
  end
  
end