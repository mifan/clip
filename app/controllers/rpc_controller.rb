require "coordinate_convertor"
class RpcController < ApplicationController

#include CoordinateConvertor
  include CoordinateConvertor

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
    login =   params[:user]
    password =   params[:pass]

    if login.blank? || password.blank? 
      @rc = -1
      @message = 'System Error'
      return
    end

    session = UserSession.new(:login => login, :password => password , :remember_me => true)
    if session.save
      @rc = 0
      @message = 'OK' #session.inspect
      @userid = User.where(:login => login).first.id
    else
      @rc = -1
      @message = 'System Error'
    end
  end

#next=ShowMap&lng=23.855000&lat=61.448083
  def revise_coords
    lng = params[:lng]
    lat = params[:lat]
    
    if lng.blank? || lng.blank? 
      @rc = -1
      @message = 'System Error'
      return
    end

    lat = BigDecimal.new(lat)
    lng = BigDecimal.new(lng)

    x,y = latlng_to_pixel_xy(lat,lng,18)

    x += 0
    y += 0


    @lat,@lng = pixel_xy_to_latlng(x,y,18)
    @next_step = params[:next]
    @rc = 0
    @message = 'OK'
  end





  def route_ex
    user_id =   params[:userid]
    devid =   params[:devid]
    sensor =   params[:sensor]
    lng = params[:lng]
    lat = params[:lat]

    if user_id.blank? || devid.blank? || devid.blank? || sensor.blank? || lat.blank? 
      @rc = -1
      @message = 'System Error'
      return
    end

    device_id = Device.where( :devid => devid ).first.id
    Coordinate.create!(:user_id => user_id, :device_id => device_id, :sensor => sensor, :lng => lng, :lat => lat )
    @rc = 0
    @message = 'OK'

  end


end
