const template = (options) => {
  const tmp = `<!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <title>Static Template</title>
      </head>
      <body>
        <div style="width: 100%;">
          <div
            style="
              width: 100%;
              display: flex;
              justify-content: center;
              background: white;
            "
          >
            <img style="height: 50px;" src="cid:img" />
          </div>
          <div
            style="
              background: #0573c0;
              padding: 5px;
              text-align: center;
              border-top-left-radius: 13px;
              color: white;
              border-top-right-radius: 13px;
              border-bottom: 1px solid rgba(255, 255, 255, 0.512);
            "
          >
            <h4>Reset Password Link</h4>
          </div>
          <div
            style="
              color: white;
              padding: 10px;
              background: #0573c0;
              border-bottom-right-radius: 13px;
              border-bottom-left-radius: 13px;
            "
          >
            <h6>
              Here is your reset password link, <br />
              Click on the button bellow to access it, <br />
              <span style="color: red;"
                >Note: The link is only available for 1 hour.</span
              >
              <a
                href="${options.link}"
                style="
                  text-decoration: none;
                  width: 100%;
                  display: flex;
                  justify-content: center;
                  margin-top: 10px;
                "
              >
                <button
                  style="
                    padding: 10px;
                    border-radius: 13px;
                    border: none;
                    cursor: pointer;
                  "
                >
                  Reset password
                </button>
              </a>
            </h6>
          </div>
        </div>
      </body>
    </html>
    `;

  return tmp;
};

module.exports = template;
