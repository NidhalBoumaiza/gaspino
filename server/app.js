const cors = require("cors");
const express = require("express");
const morgan = require("morgan");
const rateLimit = require("express-rate-limit");
const AppError = require("./utils/appError");
const globalErrorHandler = require("./controllers/errorController");
const xss = require("xss-clean");
const mongoSanitize = require("express-mongo-sanitize");
const helmet = require("helmet");
const app = express();
const bodyParser = require("body-parser");
const cronTasks = require("./utils/cronTasks");
const path = require("path");
//------------ROUTES----------------
const userRouter = require("./routes/userRouter");
const productRouter = require("./routes/productRouter");
const commandeRouter = require("./routes/commandeRouter");
//------------------------------
app.use(cors());
app.use(xss());
app.use(mongoSanitize());
app.use(helmet());
app.use(morgan("dev"));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// 1) MIDDLEWARES
const limiter = rateLimit({
  max: 100,
  windowMs: 60 * 60 * 1000,
  message: "Too many requests from this IP , please try again in an hour !",
});
app.use("/api", limiter);

if (process.env.NODE_ENV === "development") {
  app.use(morgan("dev"));
}
app.use(express.json());
app.use((req, res, next) => {
  req.requestTime = new Date().toISOString();
  next();
});

// 2) CRON JOBS
cronTasks.updateProductStatus();

// 3) ROUTES
app.use("/images", express.static(path.join(__dirname, "./images")));

app.use("/api/v1/users", userRouter);
app.use("/api/v1/products", productRouter);
app.use("/api/v1/commandes", commandeRouter);
app.all("*", (req, res, next) => {
  next(new AppError(`Can't find ${req.originalUrl} on this server!`, 404));
});

app.use(globalErrorHandler);

module.exports = app;
