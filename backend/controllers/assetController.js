const multer = require("multer");
const path = require("path");
const fs = require("fs");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const folderName = req.path.split("/").pop();
    const uploadPath = path.join(__dirname, `../assets/${folderName}s`);

    if (!fs.existsSync(uploadPath)) {
      fs.mkdirSync(uploadPath, { recursive: true });
    }

    cb(null, uploadPath);
  },
  filename: (req, file, cb) => {
    const originalName = path.parse(file.originalname).name;
    cb(null, `${originalName}-${Date.now()}${path.extname(file.originalname)}`);
  },
});

const upload = multer({ storage: storage });

const uploadImage = (req, res, next) => {
  upload.single("image")(req, res, (err) => {
    if (err) {
      return next(new AppError(err.message, 400));
    }
    if (!req.file) {
      return next(new AppError("No image uploaded!", 400));
    }

    const fileUrl = `http://localhost:3000/assets/${req.file.destination
      .split("/")
      .pop()}/${req.file.filename}`;

    res.status(201).json({
      status: "Success",
      message: "Image uploaded successfully",
      file: req.file.filename,
      path: fileUrl,
    });
  });
};

// Upload Profile Picture
const uploadProfilePicture = catchAsync(async (req, res, next) => {
  upload.single("image")(req, res, async (err) => {
    const user = req.user;
    if (err) {
      return next(new AppError(err.message, 400));
    }

    if (!req.file) {
      return next(new AppError("No image uploaded!", 400));
    }

    // Generate image URL
    const fileUrl = `http://localhost:3000/assets/profiles/${req.file.filename}`;

    // Update user profile
    user.imgUrl = fileUrl;
    await user.save();

    res.status(201).json({
      status: "Success",
      data: user.toJSON(),
    });
  });
});

module.exports = { uploadImage, uploadProfilePicture };
