<cfoutput><!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>WebSocket Site 1</title>
	<link rel="icon" href="/assets/img/favicon.png" type="image/png">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>
<body class="p-3 m-0 bg-light">
	<h1 class="h2">
		WebSocket Core Demo
	</h1>
	<div>
		<a href="./info.cfm" class="btn btn-primary" target="_blank">
			View Connections
		</a>
		<button class="btn btn-secondary" id="btn-send">
			Execute Server Messages
		</button>
	</div>
	<div class="bg-white p-3 mt-3 border rounded shadow-sm">
		<p>Open your browser console to send and view messages.</p>
		<p>
			Interacting with the WebSocket server is possible via <code>ws</code> object.
		</p>
		<p class="m-0">
			Example: <code>ws.send( 'Hello from Site 1' )</code>
		</p>
	</div>
	<script src="/assets/js/socket.core.js"></script>
</body>
</html></cfoutput>