component extends="modules.socketbox.models.WebSocketCore" {

	// called for every new remote connection
	function onConnect( required channel ) { }

	// called every time a connection is closed
	function onClose( required channel ) { }

	// channel here represents the connected client
	function onMessage( required message, required channel ) {
		// send a message back to a specific client
		// in this case, we are sending a message back
		// to the client that sent the message
		if ( arguments.message == "Ping" ) {
			sendMessage( "Pong", arguments.channel );
		}
		// send the message to all connected clients
		else {
			broadcastMessage( arguments.message );
		}
	}

}