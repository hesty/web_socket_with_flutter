const express = require("express");
const socket = require("socket.io");
const app = express();
const PORT = process.env.PORT || 3000 ;

const server = app.listen(PORT);

const io = socket(server);

io.on("connection", (socket) => {
  console.log('client connect...', socket.id);

  socket.on("number", (data) => {
    
  for (var i = 0; i <= 1000000; i++) {
    socket.emit("number", {
       i
    });
  }

  });

});
