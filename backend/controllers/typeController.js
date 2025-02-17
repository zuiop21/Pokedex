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
    data: newType.toJSON(),
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
    message: `Type with name ${name} deleted successfully` ,
  });
});

module.exports = { createType, deleteType };
