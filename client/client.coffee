
Template.domain.results = () ->
	Session.get "results"

Template.domain.events
	"input #domain-name-input" : (event) ->
		value = event.target.value

		domains = Domains.find().fetch().map (x) -> x.name
		console.log "Fetched #{domains.length} domains"

		matches = domains.filter ((d) -> value.length >= d.length and value.endsWith(d.toLowerCase()))
		matches = matches.map (m) -> (value.slice(0, value.length - m.length) + ".#{m}").toLowerCase()
		Session.set "results", matches

	"focus #domain-name-input" : (event) ->
		@placeholder = event.target.placeholder
		event.target.placeholder = ""
	"blur #domain-name-input" : (event) ->
		event.target.placeholder = @placeholder