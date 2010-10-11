require "bigdecimal"
require "bigdecimal/math"

include BigMath

module CoordinateConvertor
  
  MIN_LATITUDE = BigDecimal.new('-85.05112878')
  MAX_LATITUDE = BigDecimal.new('85.05112878')
  MIN_LONGITUDE = BigDecimal.new('-180')
  MAX_LONGITUDE = BigDecimal.new('180')
  DECIMAL_PREC = 10
  PI_PREC = PI(DECIMAL_PREC)




  def safe_val(val,min_val,max_val)
    [([val,min_val].max),max_val].min
  end

  def map_size(level_of_detail)
    256 << level_of_detail
  end

  #NOTES : lat / lng are BigDecimal
  def latlng_to_pixel_xy(lat,lng,level_of_detail)

    latitude = safe_val(lat,MIN_LATITUDE,MAX_LATITUDE)
    longitude = safe_val(lng,MIN_LONGITUDE,MAX_LONGITUDE)

    x = (longitude +  180 ) /  360 
    sin_latitude = sin( latitude * PI_PREC / 180, DECIMAL_PREC)
    y = 0.5 - log(1 + sin_latitude, DECIMAL_PREC) / (1 - sin_latitude ) / 4 * PI_PREC

    map_size_level = map_size(level_of_detail) 
    pixel_x = safe_val(x * map_size_level + 0.5, 0, map_size_level - 1 )
    pixel_y = safe_val(y * map_size_level + 0.5, 0, map_size_level - 1 )

    [pixel_x,pixel_y]
  end

  def pixel_xy_to_latlng(pixel_x, pixel_y, level_of_detail)
      map_size_level = map_size(level_of_detail)

      x = BigDecimal.new( (safe_val(pixel_x, 0, map_size_level - 1) / map_size_level - 0.5).to_s )
      y = BigDecimal.new( (0.5 - safe_val(pixel_y, 0, map_size_level - 1) / map_size_level).to_s )

      latitude = 90 - 360 * atan(exp( -y * 2 * PI_PREC ,DECIMAL_PREC), DECIMAL_PREC) / PI_PREC
      longitude = 360 * x
      [latitude,longitude]
  end

end

