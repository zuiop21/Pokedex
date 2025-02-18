const express = require("express");
require("dotenv").config({ path: `${process.cwd()}/.env` });
const authRoute = require("./routes/authRoute");
const typeRoute = require("./routes/typeRoute");
const pokemonRoute = require("./routes/pokemonRoute");
const favouriteRoute = require("./routes/favouriteRoute");
const evolutionRoute = require("./routes/evolutionRoute");
const catchAsync = require("./utils/catchAsync");
const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
require("./db/models/associations");
require("./utils/catchAsync");

const app = express();

//JSON body parsing middleware
app.use(express.json());

//Port
const PORT = process.env.APP_PORT || 4000;

//Routes
app.use(authRoute);
app.use(typeRoute);
app.use(pokemonRoute);
app.use(favouriteRoute);
app.use(evolutionRoute);

//Route not found
app.use(
  "*",
  catchAsync(async (req, res, next) => {
    throw new AppError(`Can't find ${req.originalUrl} on this server`, 404);
  })
);

//Global error handler
app.use(globalErrorHandler);

app.listen(PORT, () => {
  console.log("Server UP on port ", PORT);
});
