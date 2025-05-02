import { Client } from 'https://cdn.jsdelivr.net/npm/@stomp/stompjs@7.1.1/+esm';

const client = new Client({
    brokerURL : `${location.protocol.indexOf('https') !== -1 ? 'wss' : 'ws'}://${location.host}/ws`,
    reconnectDelay : 5000,
    heartbeatIncoming : 10000,
    heartbeatOutgoing : 10000,
    connectHeaders : {
        login    : '',
        passcode : '',
        host     : location.hostname
    },
    debug: function ( str ) {
        console.log( str );
    },
    onConnect: function ( frame ) {
        // set the id of the session
        this.id = parseInt( frame.headers.session );
        // use to track my subscriptions and easily unsubscribe
        this.subscriptions = {};

        this.subscriptions.global = this.subscribe( 'global', onMessage );

        this.publish({
            destination : 'global',
            body : JSON.stringify( { notify: `Client ${this.id} has arrived` })
        });
    },
    onStompError: function ( frame ) {
        console.error( `Broker reported error: ${frame.headers.message}` );
        console.error( `Additional details: ${frame.body}` );
    },
    onWebSocketClose: function ( event ) {
        console.log( 'WebSocket closed', event );
    },
    onWebSocketError: function ( event ) {
        console.error( 'WebSocket error', event );
    },
});

const onMessage = ( message ) => {
    let body = message.body;
    try { body = JSON.parse( message.body ); }
    catch (e) {}
    console.log( message.headers, body );
}

client.activate();

// executes the server side sender
document.getElementById( 'btn-send' ).addEventListener( 'click', async event => {
    event.preventDefault();

    let btn = event.currentTarget;
    let text = btn.innerHTML;

    btn.innerHTML = 'Sending Messages ...';
    btn.disabled = true;

    await fetch('./sender.bxs');

    btn.disabled = false;
    btn.innerHTML = text;
} );

// make client available globally for working with it in the console
globalThis.client = client;
globalThis.onMessage = onMessage;