<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>WebSockets Demo</title>
	<link rel="icon" href="/assets/img/favicon.png" type="image/png">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<link href="/assets/css/app.css" rel="stylesheet">
</head>
<body>
	<main class="container-xxl">
		<div class="d-flex py-2 border-bottom justify-content-between align-items-center bg-body-tertiary">
			<h1 class="h5 m-0">
				WebSockets Demo
			</h1>
			<div>
				<button type="button" class="btn btn-sm btn-secondary" id="btn-send" disabled>
					Execute Server Messages
				</button>
				<button type="button" class="btn btn-sm btn-secondary" id="clear-log" disabled>
					Clear Log
				</button>
			</div>
		</div>
		<section class="d-flex flex-column">
			<ul id="messages" class="list-unstyled d-flex flex-column gap-2 py-2 overflow-y-scroll m-0"></ul>
			<form class="p-3 border-top bg-body-tertiary" id="form">
				<div class="input-group">
					<input type="text" class="form-control" id="message" placeholder="Type a message" autocomplete="off" disabled>
					<button type="submit" class="btn btn-primary" disabled>Send</button>
				</div>
			</form>
		</section>
	</main>
	<script src="/assets/js/app.js"></script>
</body>
</html>