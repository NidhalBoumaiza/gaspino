const multer = require("multer");
const path = require("path");

const multerStorage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, path.join(__dirname, "../images"));
  },
  filename: (req, file, cb) => {
    const ext = file.mimetype.split("/")[1];
    cb(
      null,
      `${new Date().toISOString().replace(/:/g, "-")}${file.originalname}.${ext}`
    );
  },
});

const multerFilter = (req, file, cb) => {
  if (file.mimetype.startsWith("image")) {
    cb(null, true);
  } else {
    cb(
      new Error(
        "C'est ne pas une image . sil vous plais uploder une image",
        400
      ),
      false
    );
  }
};

const upload = multer({ storage: multerStorage, fileFilter: multerFilter });

exports.uploadPicture = upload.single("image");

exports.uploadMultiplePicture = upload.array("images", 5);
