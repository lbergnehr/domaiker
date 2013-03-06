Meteor.startup ->
	console.log "domaiker server started."

	insertDefaultDomains() if Domains.find().count() == 0

insertDefaultDomains = () ->
	console.log "Inserting default domain names."

	# http://data.iana.org/TLD/tlds-alpha-by-domain.txt
	res = Meteor.http.get "http://data.iana.org/TLD/tlds-alpha-by-domain.txt"
	return if !res?

	data = res.content
	domains = data.split "\n"
	domains.forEach (domain) ->
		if domain.indexOf("#") != 0 and domain != ""
			console.log "Inserting '#{domain}'"
			Domains.insert {name : domain}
