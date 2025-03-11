const express = require("express");
require("dotenv").config({ path: `${process.cwd()}/.env` });
const authRoute = require("./routes/authRoute");
const typeRoute = require("./routes/typeRoute");
const pokemonRoute = require("./routes/pokemonRoute");
const favouriteRoute = require("./routes/favouriteRoute");
const evolutionRoute = require("./routes/evolutionRoute");
const regionRoute = require("./routes/regionRoute");
const assetRoute = require("./routes/assetRoute");
const catchAsync = require("./utils/catchAsync");
const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
const { authentication, restricted } = require("./controllers/authController");
const path = require("path");
require("./db/models/associations");
require("./utils/catchAsync");

const app = express();

//Swagger dependencies
const swaggerUi = require("swagger-ui-express");
const swaggerJsdoc = require("swagger-jsdoc");

//Swagger documentation
const swaggerOptions = {
  definition: {
    openapi: "3.0.0",
    info: {
      title: "Pokedex API",
      version: "1.0.0",
      description: "API for the Pokedex application",
    },
    components: {
      securitySchemes: {
        bearerAuth: {
          type: "http",
          scheme: "bearer",
          bearerFormat: "JWT",
        },
      },
    },
  },
  apis: ["./routes/*.js"],
};

const swaggerDocument = swaggerJsdoc(swaggerOptions);
app.use("/swagger", swaggerUi.serve, swaggerUi.setup(swaggerDocument));

//JSON body parsing middleware
app.use(express.json());

//Port
const PORT = process.env.APP_PORT || 4000;

// Static routes
app.use("/assets/types", express.static(path.join(__dirname, "assets/types")));

app.use(
  "/assets/regions",
  express.static(path.join(__dirname, "assets/regions"))
);

app.use(
  "/assets/pokemons",
  express.static(path.join(__dirname, "assets/pokemons"))
);

//Routes
app.use(authRoute);
app.use(evolutionRoute);
app.use(pokemonRoute);
app.use(assetRoute);
app.use(regionRoute);
app.use(typeRoute);
app.use(authentication, favouriteRoute);

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
