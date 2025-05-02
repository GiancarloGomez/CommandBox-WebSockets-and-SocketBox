const ws = new WebSocket(
    `${location.protocol.indexOf('https') !== -1 ? 'wss' : 'ws'}` +
    `://${location.host}/ws`
);

ws.onopen = function() {
    console.log( 'Connected to WebSocket server' );
};

ws.onmessage = event => {
    let data = event.data;
    try { data = JSON.parse( data ); }
    catch (e) {}
    console.log( data );
};

ws.onclose = event => {
    console.log( 'Socket is closed.', event );
};

ws.onerror = error => {
    console.error( 'Socket encountered error: ', error.message );
};

// executes the server side sender
document.getElementById( 'btn-send' ).addEventListener( 'click', async event => {
    event.preventDefault();

    let btn = event.currentTarget;
    let text = btn.innerHTML;

    btn.innerHTML = 'Sending Messages ...';
    btn.disabled = true;

    await fetch('./sender.cfm');

    btn.disabled = false;
    btn.innerHTML = text;
} );