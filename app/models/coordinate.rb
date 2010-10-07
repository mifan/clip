class Coordinate < ActiveRecord::Base
  belongs_to :user
  belongs_to :device

  before_create :update_lat_lng


  private
  def update_lat_lng
    self.latitude = self.lat
    self.longitude = self.lng
  end
end
