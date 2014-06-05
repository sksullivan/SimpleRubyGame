require 'gosu'
require './bullet.rb'
require './enemy.rb'

class View < Gosu::Window
	def initialize
		@width = 900
		@height = 900
		super(@width,@height, false)
		self.caption = 'Hello pootis!!!'
		@x = 100
		@y = 100
		@speed = 3
		@turnspeed = 3
		@dir = 0
		@red = 0xff0000ff
		@yellow = Gosu::Color::YELLOW
		@bullets = []
		@enemies = []
		@count = 0
		@sin = 50
	end

	def outOfBounds?(x,y)
		return (x > @width or x < 0) 
	end

	def update
		if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
			@dir-=@turnspeed
		end
		if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
			@dir+=@turnspeed
		end
		if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
			move
		end
		if button_down? Gosu::KbSpace then
			fire
		end
		if button_down? Gosu::KbEscape then
			close
		end
		for b in @bullets
			b.move
		end
		for e in @enemies
			e.update
		end

		@count += 0.02
		@sin = Math.sin(@count)*100+50
		@yellow.alpha = @sin
	end

	def draw
		draw_quad(0, 0, @yellow, @width,0, @yellow, @width,@height, @yellow, 0,@height, @yellow, 0)
		x = @x
		y = @y
		rotate(@dir,@x,@y) {
			draw_quad(x - 10, y - 10, @red, x + 10, y - 10, @red, x + 10, y + 10, @red, x - 10, y + 10, @red, 1)
		}
		for b in @bullets
			b.draw
			if outOfBounds?(b.x,b.y) then
				@bullets.delete b
			end
		end
		for e in @enemies
			e.draw
		end
    end

	def button_down(id)
		if id == Gosu::KbEscape
			close
		end
	end

    def move
    	@x+=Math.cos(@dir/360.0*2*Math::PI)*@speed
    	@y+=Math.sin(@dir/360.0*2*Math::PI)*@speed
    end

    def fire
    	@bullets.push(Bullet.new(@x,@y,@dir,self))
    	@enemies.push(Enemy.new(self))
    end

end
f = View.new
f.show