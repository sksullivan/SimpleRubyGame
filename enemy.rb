class Enemy
	def initialize(window)
		@x=300
		@y=300
		@dir = 0
		@yellow = 0xff00ffff
		@window = window
		puts @x,@y,@dir
		@speed = 1
		@count = 0
	end

	def update
		if @count > rand*50
			@dir += (rand * 180) - 90
			puts (rand * 20)
			@count = 0
		else
			@count+=1
		end
		move
	end

	def draw
		x = @x
		y = @y
		@window.rotate(@dir,@x,@y) {
			@window.draw_quad(x - 2, y - 2, @yellow, x + 2, y - 2, @yellow, x + 2, y + 2, @yellow, x - 2, y + 2, @yellow, 1)
		}
    end

	def move
    	@x+=Math.cos(@dir/360.0*2*Math::PI)*@speed
    	@y+=Math.sin(@dir/360.0*2*Math::PI)*@speed
    end
end