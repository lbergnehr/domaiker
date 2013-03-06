
Domains = new Meteor.Collection "domains"

String::endsWith = (str) -> if @match(new RegExp "#{str}$") then true else false