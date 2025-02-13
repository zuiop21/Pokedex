const express = require("express");
require("dotenv").config({path: `${process.cwd()}/.env`});
const authRoute = require("./routes/authRoute")

const app = express();
app.use(express.json()); //JSON body parsing middleware
const PORT = process.env.APP_PORT || 4000

//Routes
app.use(authRoute);


//Route in case the original route was not found
app.get("*", (req, res, next) => {
    res.status(404).json({
      status: "fail",
      message: "Route not found",
    });
  });

app.listen(PORT, () => {
  console.log("Server UP on port ", PORT);
});
