class RpcController < ApplicationController
  def quick_req
     #devid=000000000000000&user=superjj&pass=&email=dcc@mobile&mobile=1234567&sensor=1
    devid =  params[:devid]
    user =   params[:user]
    pass =   params[:pass]
    email =  params[:email]
    mobile = params[:mobile]
    sensor = params[:sensor]



    if user.blank? || devid.blank? 
      @rc = -1
      @message = 'System Error'
      return
    end

    if pass.blank?
      @rc = 101
      @message = 'Password Error'
      return
    end

    unless User.where( :login => user ).blank?
      @rc = 103
      @message = 'Nickname already existed'
      return
    end

    current_user = User.create!(:login => user, :password => pass, :password_confirmation => pass, :email => email, :mobile => mobile )
    current_user.devices.build(:devid => devid, :sensor => sensor, :mobile => mobile ).save!

    @rc = 0
    @message = 'OK'
  end

  def login
    #render :xml => ResponseMessage.new.to_xml
    #render :xml => User.new
    #render :content_type => 'application/xml', 
    #respond_to do |format| 
    #format.html # index.html.erb  
    # format.xml { render :layout => false } 
    #end 
  end

  def revise_coords
  end

  def route_ex
  end
end
