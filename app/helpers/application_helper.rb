module ApplicationHelper
	
	# Returns the full title on a per-page basis.
	def full_title(page_title = '')
		base_title = "The One Ring Tools"
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

	def link_icon(icon, text = '')
		("<span class='glyphicon glyphicon-#{icon}'></span> #{text}").html_safe
	end

	def bool_icon(value, print_text = false, options = { yes: "Sim", no: "Não" })
		icon = (value ? "ok" : "ban-circle");
		text = (print_text ? (value ? options[:yes] : options[:no]) : "")
		("<span class='glyphicon glyphicon-#{icon}'></span> #{text}").html_safe
	end

	def generate_tab(href, options = { active: false, inner: '', count: nil })
		tab = "<li role='presentation'" +
			(options[:active] ? " class='active' " : "") + ">" +
			"  <a href='#{href}' aria-controls='#{href}'role=tab data-toggle='tab'>" +
			"    #{options[:inner]} " + 
			(options[:count] ? "<span class='badge'>#{options[:count]}</span>" : "") +
			"  </a>"+
			"</li>"
		tab.html_safe
	end
end
