const multer = require("multer");
const path = require("path");
const fs = require("fs");
const AppError = require("../utils/appError");
const catchAsync = require("../utils/catchAsync");

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const folderName = req.path.split("/").pop();
    const uploadPath = path.join(
      __dirname,
      folderName.endsWith("s")
        ? `../assets/${folderName}`
        : `../assets/${folderName}s`
    );

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
const uploadTypeImages = catchAsync(async (req, res, next) => {
  const uploadFields = upload.fields([
    { name: "image", maxCount: 1 },
    { name: "imageUrlOutline", maxCount: 1 },
  ]);

  uploadFields(req, res, async (err) => {
    if (err) {
      return next(new AppError(err.message, 400));
    }

    if (!req.files || !req.files.image || !req.files.imageUrlOutline) {
      return next(new AppError("Both images are required!", 400));
    }

    req.imgUrl = `http://localhost:3000/assets/types/${req.files.image[0].filename}`;
    req.imgUrlOutline = `http://localhost:3000/assets/types/${req.files.imageUrlOutline[0].filename}`;

    next();
  });
});

const uploadRegionPicture = catchAsync(async (req, res, next) => {
  upload.single("image")(req, res, async (err) => {
    if (err) {
      return next(new AppError(err.message, 400));
    }

    if (!req.file) {
      return next(new AppError("No image uploaded!", 400));
    }

    // Generate image URL
    const fileUrl = `http://localhost:3000/assets/regions/${req.file.filename}`;

    req.imgUrl = fileUrl;

    return next();
  });
});

const uploadPokemonPicture = catchAsync(async (req, res, next) => {
  upload.single("image")(req, res, async (err) => {
    if (err) {
      return next(new AppError(err.message, 400));
    }

    if (!req.file) {
      return next(new AppError("No image uploaded!", 400));
    }

    // Generate image URL
    const fileUrl = `http://localhost:3000/assets/pokemons/${req.file.filename}`;

    req.imgUrl = fileUrl;

    return next();
  });
});

module.exports = {
  uploadImage,
  uploadProfilePicture,
  uploadPokemonPicture,
  uploadRegionPicture,
  uploadTypeImages,
};
