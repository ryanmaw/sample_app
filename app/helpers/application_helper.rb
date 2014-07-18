module ApplicationHelper
	# Create a helper that returns the full title on a per-page basis
	#def a helper

	# Helper method called with parameter page_title
	# if that's empty use the base
	# else use it but add it to the base

	def full_title(page_title)
		#add a base for convention
		base_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
end
