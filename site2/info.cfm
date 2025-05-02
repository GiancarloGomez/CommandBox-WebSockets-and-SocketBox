<cfscript>
	writeDump( new services.WebSocket().getAllConnections() );
	writeDump( new services.WebSocket().getSubscribers() );
</cfscript>