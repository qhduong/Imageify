class Annotate < ActiveResource::Base

	def self.process(image, message, font_family = "Helvetica", font_size = 30, color = "#333", x_coord = 0, y_coord = 10)
		magick_image = Magick::ImageList.new(image)
		text = Magick::Draw.new
		text.annotate(magick_image, 0, 0, x_coord, y_coord, message) {
	  		self.font_family = font_family
		    self.gravity = Magick::SouthGravity
		    self.pointsize = font_size
		    self.fill = color
		    }
		magick_image.write('public/images/annotate.jpg')
	end
end