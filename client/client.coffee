
Template.domain.results = ->
	Session.get "results"

Template.domain.hasNoResults = ->
	value = Session.get "value"
	results = Session.get "results"
	value? and value != "" and not results.length

Meteor.subscribe "domains", ->
	console.log "done loading"

Template.domain.events
	"input #domain-name-input" : (event) ->
		value = event.target.value
		Session.set "value", value

		domains = Domains.find().fetch().map (x) -> x.name

		matches = domains.filter ((d) -> value.length >= (d.length + 2) and value.toLowerCase().endsWith(d.toLowerCase()))
		matches = matches.map (m) -> (value.slice(0, value.length - m.length) + ".#{m}").toLowerCase()
		Session.set "results", matches

	"focus #domain-name-input" : (event) ->
		@placeholder = event.target.placeholder
		event.target.placeholder = ""
	"blur #domain-name-input" : (event) ->
		event.target.placeholder = @placeholder