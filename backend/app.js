const express = require("express");
require("dotenv").config({ path: `${process.cwd()}/.env` });
const authRoute = require("./routes/authRoute");
const typeRoute = require("./routes/typeRoute");
const catchAsync = require("./utils/catchAsync");
const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
require("./db/models/associations");
require("./utils/catchAsync");

const app = express();
app.use(express.json()); //JSON body parsing middleware
const PORT = process.env.APP_PORT || 4000;

//Routes
app.use(authRoute);
app.use(typeRoute);

//Route in case the original route was not found
app.use(
  "*",
  catchAsync(async (req, res, next) => {
    throw new AppError(`Can't find ${req.originalUrl} on this server`, 404);
  })
);

app.use(globalErrorHandler);

app.listen(PORT, () => {
  console.log("Server UP on port ", PORT);
});
