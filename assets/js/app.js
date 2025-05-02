const SimpleChat = {
    id        : null,
    ws        : null,
    view      : {},
    init      : function() {
        this.ws = new WebSocket(
            `${location.protocol.indexOf('https') !== -1 ? 'wss' : 'ws'}` +
            `://${location.host}/ws`
        );
        this.ws.onopen    = this.onOpen.bind( this );
        this.ws.onmessage = this.onMessage.bind( this );
        this.ws.onclose   = this.onClose.bind( this );
        this.ws.onerror   = this.onError.bind( this );

        this.view = {
            form      : document.getElementById('form'),
            message   : document.getElementById('message'),
            messages  : document.getElementById('messages'),
            clearBtn  : document.getElementById('clear-log'),
            sendBtn   : document.getElementById('btn-send'),
            submitBtn : document.querySelector('form button')
        };
        this.view.form.addEventListener('submit', event => {
            event.preventDefault();
            this.sendMessage();
        });
        this.view.clearBtn.addEventListener('click', event => {
            event.preventDefault();
            this.clearLog();
        });
        this.view.sendBtn.addEventListener('click', async event => {
            event.preventDefault();

            let btn = event.currentTarget;
            let text = btn.innerHTML;

            btn.innerHTML = 'Sending Messages ...';
            btn.disabled = true;

            await fetch('./sender.cfm');

            btn.disabled = false;
            btn.innerHTML = text;
        });
    },
    chatStatus : function( enabled = true ) {
       this.view.submitBtn.disabled = !enabled;
       this.view.message.disabled   = !enabled;
       this.view.clearBtn.disabled  = !enabled;
       this.view.sendBtn.disabled  = !enabled;
    },
    clearLog  : function() {
        this.view.messages.innerHTML = '';
    },
    onOpen    : function() {
        console.log( 'Connected to WebSocket server' );
        this.chatStatus( true );
    },
    onClose   : function( event ) {
        console.log( 'Socket is closed.', event );
        this.chatStatus( false );
    },
    onError   : function( error ) {
        console.error( 'Socket encountered error: ', error.message );
        this.chatStatus( false );
    },
    onMessage : function( event ) {
        let data = event.data;
        try { data = JSON.parse( data ); }
        catch (e) {}
        switch( data.event || '' ){
            case 'connected':
                this.id = data.id;
                break;
            case 'joined':
            case 'left':
                this.writeLine(
                    data.data,
                    data.publisherID,
                    data.event
                );
                break;
            case 'message':
                this.writeLine(
                    data.data,
                    data.publisherID,
                    data.publisherID === this.id ?
                        'sent' :
                        'received'
                );
                break;
        }
    },
    sendMessage : function() {
        const message = this.view.message.value.trim();
        if ( message ) {
            this.ws.send( message );
            this.view.message.value = '';
        }
    },
    writeLine : function( message, id, type ) {
        // do not write my joined message
        if ( type === 'joined' && this.id === id ) return;

        let identifier = type === 'joined' || type === 'left' ?
                         'SERVER' :
                         this.id === id ?
                         `Me : ${id}` :
                         `User : ${id}`;

        if ( id === 0 )
            identifier = type = 'server';

        const li = document.createElement('li');
        li.classList.add('rounded-2');
        switch ( type ){
            case 'server':
                li.classList.add('text-end','bg-info','text-white');
                break;
            case 'sent':
                li.classList.add('text-end','bg-primary','text-white');
                break;
            case 'joined':
                li.classList.add('text-center','bg-success-subtle','text-white');
                break;
            case 'left':
                li.classList.add('text-center','bg-danger-subtle','text-white');
                break;
            default:
                li.classList.add('bg-secondary-subtle','text-body-emphasis');
        }

        li.innerHTML = `<small class="py-1 px-2">${identifier}</small>
                        <div class="py-1 px-2">${message}</div>`;
        this.view.messages.appendChild(li);
        this.view.messages.scrollTo({
            top      : this.view.messages.scrollHeight,
            behavior : 'smooth'
        });
    },
};

SimpleChat.init();
