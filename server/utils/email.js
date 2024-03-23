const nodemailer = require("nodemailer");

const sendEmail = async (options) => {
  // 1) Create a transporter :
  var transport = nodemailer.createTransport({
    host: process.env.EmailMailer,
    port: process.env.PORTMAILER,
    auth: {
      user: process.env.USERMAILER,
      pass: process.env.PASSWORDMAILER,
    },
  });
  // 2) Define the email options :
  const mailOptions = {
    from: "Nidhal Boumaiza <Nidhalbmz123@gmail.com>",
    to: options.email,
    subject: options.subject,
    text: options.message,
    attachments: options.attachments,
  };
  await transport.sendMail(mailOptions);
};

module.exports = sendEmail;
