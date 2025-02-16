const Type = require("../db/models/type");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

const createType = catchAsync(async (req, res, next) => {
  const body = req.body;

  const newType = await Type.create({
    name: body.name,
    description: body.description,
  });

  if (!newType) {
    return next(new AppError("Failed to create the type", 400));
  }

  return res.status(201).json({
    status: "Success",
    data: newType,
  });
});

//TODO lehet id kell name helyett
const updateType = catchAsync(async (req, res, next) => {
  const { name } = req.params;
  const body = req.body;

  const type = await Type.findOne({
    where: {
      name: name,
    },
  });

  if (!type) {
    return next(new AppError(`Type with name ${name} not found`, 404));
  }

  type.name = body.name;

  await type.save();

  return res.json({
    status: "Success",
    data: type,
  });
});

const deleteType = catchAsync(async (req, res, next) => {
  const { name } = req.params;
  const type = await Type.findOne({
    where: {
      name: name,
    },
  });

  if (!type) {
    return next(new AppError(`Type with name ${name} not found`, 404));
  }

  await type.destroy();

  return res.json({
    status: "Success",
    message: "Type deleted successfully",
  });
});

module.exports = { createType, updateType,deleteType };
