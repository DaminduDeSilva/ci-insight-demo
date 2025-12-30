const express = require("express");
const app = express();

app.use(express.json());

let logs = [];

app.post("/log", (req, res) => {
  logs.push(req.body);
  console.log("Received log:", req.body.command);
  res.send({ status: "ok" });
});

app.get("/logs", (req, res) => {
  res.json(logs);
});

app.listen(4000, () => {
  console.log("Backend running on http://localhost:4000");
});
