component extends="modules.socketbox.models.WebSocketCore" {

	function onConnect( required channel ) {
		// do not allow the connection if the user is not logged in
		// if ( !session.keyExists( "user" ) ){
		// 	channel.close();
		// }
		// else {
			// add the connection to our subscribers struct
			getSubscribers()[ arguments.channel.hashCode() ] = arguments.channel;
			// send connection success message to the client with their id
			sendMessage(
				serializeJSON( { event:"connected", id:channel.hashCode() } ),
				arguments.channel
			);
			// broadcast a message to all connected clients
			broadcastMessage(
				serializeJSON( {
					event       : "joined",
					data        : "User " & channel.hashCode() & " has joined the chat",
					publisherID : channel.hashCode()
				} )
			);
		// }
	}

	function onClose( required channel ) {
		// remove the connection from our subscribers struct
		getSubscribers().delete( arguments.channel.hashCode() );
		// broadcast a message to all connected clients
		broadcastMessage(
			serializeJSON( {
				event       : "left",
				data        : "User " & channel.hashCode() & " has left the chat",
				publisherID : channel.hashCode()
			} )
		);
	}

	function onMessage( required message, required channel ) {
		// always send the messsage as a JSON object
		if ( arguments.message == "Ping" ) {
			sendMessage(
				serializeJSON( { event:"pong" } ),
				arguments.channel
			 );
		}
		else {
			broadcastMessage(
				serializeJSON( {
					event       : "message",
					data        : isJSON( arguments.message ) ?
									deserializeJSON( arguments.message ) :
									arguments.message,
					publisherID : channel.hashCode()
				} )
			);
		}
	}

	function getSubscribers() {
		setup();
		return application.socketBoxSubscribers;
	}

	private function setup(){
		cflock( name="WebSocketAdvancedSetup", type="exclusive", timeout=10 ) {
			if ( !application.keyExists( "socketBoxSubscribers") )
				application.socketBoxSubscribers = {};
		}
	}

}