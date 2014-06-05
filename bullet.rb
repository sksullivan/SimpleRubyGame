class Bullet
	attr_accessor :x,:y
	def initialize(x,y,dir,window)
		@x=x
		@y=y
		@dir = dir
		@yellow = 0xffff00ff
		puts @x,@y,@dir
		@speed = 5
		@window = window
	end

	def draw
		x = @x
		y = @y
		@window.rotate(@dir,@x,@y) {
			@window.draw_quad(x - 2, y - 2, @yellow, x + 2, y - 2, @yellow, x + 2, y + 2, @yellow, x - 2, y + 2, @yellow, 01)
		}
    end

	def move
    	@x+=Math.cos(@dir/360.0*2*Math::PI)*@speed
    	@y+=Math.sin(@dir/360.0*2*Math::PI)*@speed
    end
end