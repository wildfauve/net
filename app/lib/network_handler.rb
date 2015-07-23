class NetworkHandler
  
  def initialize(icp: nil)
    @net = icp
  end
  
  def find_or_create
    # Create a Network ICP
    icp = @net.icp_details[:icp_details_v1_result]
    net = Icp.where(icp_id: icp[:my_icp][:icp_id]).first
    if net
      net.update_me(icp: icp[:my_icp])
    else
      net = Icp.create_me(icp: icp[:my_icp])
    end
    
  end
  
end