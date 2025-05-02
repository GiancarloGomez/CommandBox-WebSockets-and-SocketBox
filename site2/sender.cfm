<cfscript>
	function getJoke(){
		var joke = "";
		try {
			categories = [
				"animal",
				"career",
				"celebrity",
				"dev",
				// "explicit",
				"fashion",
				"food",
				"history",
				"money",
				"movie",
				"music",
				"political",
				"religion",
				"science",
				"sport",
				"travel"
			];
			cfhttp(
				url     = "https://api.chucknorris.io/jokes/random?category=" & categories[ randRange(1,categories.len()) ],
				timeout = 5,
				result  = "apiRequest"
			);
			joke = deserializeJSON( apiRequest.fileContent ).value
		}
		catch ( any e ){
			joke = "We could not fetch a funny joke so this is just the server responding";
		}

		return joke;
	}

	ws = new services.WebSocket();
	// send to all connections
	ws.broadcastMessage( serializeJSON({
		event       : "message",
		data        : "<b>A joke for all of you!</b><br>" & getJoke(),
		publisherID : 0
	}));

	// send to specific connection
	for ( connection in ws.getAllConnections() ){
		ws.sendMessage( serializeJSON({
				event       : "message",
				data        : "<b>This is a joke just for you #connection.hashCode()#!</b><br>" & getJoke(),
				publisherID : 0
			}),
			connection
		);
	}
</cfscript>