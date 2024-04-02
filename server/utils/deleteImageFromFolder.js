const fs = require("fs");
const path = require("path");

exports.deleteImageProductFromFolder = (imagesTodelete) => {
  imagesTodelete.forEach((imageName) => {
    let imagePath = path.join(__dirname, "../images", imageName);

    if (fs.existsSync(imagePath)) {
      fs.unlink(imagePath, (err) => {
        if (err) {
          console.error(err);
        }
      });
    } else {
      console.log(`File does not exist: ${imagePath}`);
    }
  });
};
