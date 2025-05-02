client.subscriptions.jokes = client.subscribe( 'jokes', onMessage );

client.publish({destination: 'jokes', body: 'Why did the chicken cross the road?'});

client.publish({
	destination: 'jokes',
	body: JSON.stringify({joke:'Why did the chicken cross the road?'})
});

client.publish({
	destination: 'jokes',
	body: JSON.stringify({joke:'Why did the chicken cross the road?'}),
	headers: {'content-type': 'application/json'}
});