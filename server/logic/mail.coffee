###############################################################################
Email = require('meteor/email').Email

###############################################################################
@send_message_mail = (user, subject, body) ->
	msg = "@send_message_mail trying to send mail message"
	log_event msg, event_mail, event_info

	to = get_user_mail(user)
	profile = get_profile user

	if not profile
		send_mail to, subject, body
		return

	#cycle = profile.notification_cycle
	#last = profile.last_notification
	#now = new Date()
	#dif = now - last

	#if cycle > dif
	#	return

	if profile.mail_notifications == "yes"
		send_mail to, subject, body


###############################################################################
@send_mail = (to, subject, text) ->
	from = "vgopaluni@unomaha.edu"

	Meteor.defer () ->
		log_event "Sending mail", event_mail, event_info #TODO: stack trace
		try
			#process.env.MAIL_URL="smtp://vgopaluni%40unomaha.edu:Janaki1973#@smtp.unomaha.edu";
			#smtp://postmaster@sandbox3b807b33422f47a5919558e8d7048470.mailgun.org:c8ad58f41de1eb66dbe6a2152a7a4eea-7fba8a4e-08755c8f@smtp.mailgun.org:587;
			process.env.MAIL_URL = "smtp://postmaster@sandbox3b807b33422f47a5919558e8d7048470.mailgun.org:c8ad58f41de1eb66dbe6a2152a7a4eea-7fba8a4e-08755c8f@smtp.mailgun.org:587";

			Email.send {to, from, subject, text}
			msg = "Mail send to (" + to + ") : " + subject
			log_event msg, event_mail, event_info #TODO: stack trace

		catch error
			log_event error, event_mail, event_err #TODO: stack trace



