const net = require('net');
const tls = require('tls');
const events = require('events');

class RemoteSocketLayer {
/*************  ✨ Codeium Command 🌟  *************/
    constructor() {
        this.clients = [];
        this.server = tls.createServer({
            key: fs.readFileSync('server-key.pem'),
            cert: fs.readFileSync('server-cert.pem'),
        }, socket => {
            if (!socket) {
                throw new Error('Socket is null or undefined.');
            }
            this.clients.push(socket);
            socket.on('data', data => {
                if (!data) {
                    throw new Error('Data is null or undefined.');
                }
                this.broadcast(data.toString());
            });
            socket.on('close', () => {
                this.clients = this.clients.filter(client => client !== socket);
            });
            socket.on('error', err => {
                console.error('Error occurred on socket:', err);
            });
        });
        this.server.on('error', err => {
            console.error('Error occurred on server:', err);
        });
    }
/******  40d15b0c-f39f-4e62-916c-9f1e6b2d787a  *******/

/*************  ✨ Codeium Command 🌟  *************/
    start(port) {
        if (!port) {
            throw new Error('Port is null or undefined.');
        }
        this.server.listen(port, () => {
            console.log(`Server started on port ${port}`);
        });
    }
/******  d6fc025d-29c3-4699-891b-cb7904cb4328  *******/

/*************  ✨ Codeium Command 🌟  *************/
    broadcastMessageToAllClients(message) {
        this.clients.forEach(client => client.write(`${message}\n`));
    broadcast(message) {
        this.clients.forEach(client => {
            client.write(message + '\n');
        });
    }
/******  f40156ed-34a5-4ac0-a5ac-8f883cd4faf4  *******/

    connect(port, callback) {
        const client = tls.connect(port, () => {
            callback(client);
        });
        client.on('data', data => {
            console.log(`Received message: ${data.toString()}`);
        });
        client.on('close', () => {
            console.log('Connection closed server offline.');
        });
    }
}

const rsl = new RemoteSocketLayer();
rsl.start(8080);

// Connect to the server
rsl.connect(8080, client => {
    client.write('Hello, world! from RSL');
});
