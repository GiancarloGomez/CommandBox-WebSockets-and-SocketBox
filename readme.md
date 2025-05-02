# Into The Box 2025<br>CommandBox WebSockets and SocketBox
This repo contains all the examples used in my presentation. Simply clone
this repo, install [SocketBox](https://github.com/coldbox-modules/SocketBox) and
start the CommandBox server.

```bash
box install socketbox
box server start
```

## Multiple Site 
These examples are setup in a multi-site setup and are bound to `site1.local`, 
`site2.local`, and `site3.local`. They should automatically work for you, but if they 
don't, simple add the following records to your hosts file.

```
127.0.0.1 site1.local site2.local site3.local
::1       site1.local site2.local site3.local
```

# Other Examples
[Brad Wood](https://github.com/bdw429s), the creator of the [SocketBox](https://github.com/coldbox-modules/SocketBox) Module and the one who made this possible for us also
created other samples you can play with, which are as follow:

**REPOS**
* https://github.com/bdw429s/socketbox-demo  
See it working @ https://socketbox-demo.onrender.com/
* https://github.com/bdw429s/socketbox-stomp-demo  
See it working @ https://socketbox-stomp-demo.onrender.com/
