module ApplicationHelper
	
	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
		base_title = "TOR - Tools"
		if page_title.empty?
			base_title
		else
			page_title + " | " + base_title
		end
	end

	# Returns the Gravatar for the given user.
	def gravatar_for(user, options = { size: 80, classes: "" })
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		size = options[:size]
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
		image_tag(gravatar_url, alt: user.name, 
															class: "gravatar #{options[:classes]}")
	end
end
