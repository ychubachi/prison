require "prison/version"

module Prison
	class Factory
		def create
			puts "create: dummy message."
		end
	end

	class Guard
		def list
			jls = `jls -ds`
			puts "#{jls}"
		end
	end

end
