module ApplicationHelper
	def javascript(*files)
		content_for(:head) { javascript_include_tag(*files) }
	end

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

	# Confirms an admin user.
	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end

	def link_icon(icon, text = '')
		("<span class='glyphicon glyphicon-#{icon}'></span> #{text}").html_safe
	end

	def slice_text(text = '', size = 30)
		text.length > size ? "#{text.slice(0, size)}..." : text
	end

	def bool_icon(value, print_text = false, 
			options={ yes_icon: "ok", no_icon: "ban-circle", yes: "Sim", no: "Não" })
		icon = (value ? "#{options[:yes_icon]}" : "#{options[:no_icon]}");
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
