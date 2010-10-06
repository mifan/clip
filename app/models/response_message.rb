require 'builder'

class ResponseMessage

  def initialize()
    @xml = Builder::XmlMarkup.new
    @xml.instruct!
    @xml.header
  end

  def to_xml
    @xml.to_s
  end

end
