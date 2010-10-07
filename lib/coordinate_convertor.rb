require "bigdecimal"
require "bigdecimal/math"

include BigMath

module CoordinateConvertor
  
  MIN_LATITUDE = BigDecimal.new('-85.05112878')
  MAX_LATITUDE = BigDecimal.new('85.05112878')
  MIN_LONGITUDE = BigDecimal.new('-180')
  MAX_LONGITUDE = BigDecimal.new('180')
  PI_15 = PI(15)



  def safe_val(val,min_val,max_val)
    [[val,min_val].max,max_val].min
  end

  def map_size(level_of_detail)
    256 << level_of_detail
  end

  def latlng_to_pixel_xy(latitude,longitude,level_of_detail)
    latitude = safe_val(BigDecimal.new(latitude.to_s),MIN_LATITUDE,MAX_LATITUDE)
    longitude = safe_val(BigDecimal.new(longitude.to_s),MIN_LONGITUDE,MAX_LONGITUDE)

    x = (longitude +  180 ) /  360 
    sin_latitude = sin( latitude * PI_15 / 180 )
    y = 0.5 - log(1 + sin_latitude ) / (1 - sin_latitude ) / 4 * PI_15

    map_size_level = map_size(level_of_detail) 
    pixel_x = safe_val(x * map_size_level + 0.5, 0, map_size_level - 1 )
    pixel_y = safe_val(y * map_size_level + 0.5, 0, map_size_level - 1 )

    [pixel_x,pixel_y]
  end

  def pixel_xy_to_latlng
  end

end
