'use strict';

const express = require('express');
const os = require('os')

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

const getAddress = () => {
    const interfaces = os.networkInterfaces();
    const addresses = [];

    for (const name of Object.keys(interfaces)) {
        for (const net of interfaces[name]) {
            if (name.includes("eth0") && net.family === 'IPv4' && !net.internal) {
                addresses.push(net.address);
            }
        }
    }
    return addresses
}

// App
const app = express();
app.get('/', (req, res) => {
    res.header('Cache-Control', 'private, no-cache, no-store, must-revalidate');
    res.header('Expires', '-1');
    res.header('Pragma', 'no-cache');
    res.send(`Hello World! Pod IP is ${getAddress()[0]} and Pod ID is ${os.hostname()}`);
});

app.listen(PORT, HOST);