 import * as functions from "firebase-functions";
 import * as Mailchimp from "mailchimp-api-v3";

 var cors = require('cors');
 const corsHandler = cors({origin : true});
 const mailChimpId ="720acc5a9f";
 const apiId = "18ef466435054f14048b119736092";
 let mailchimp : Mailchimp;
 try{
 mailchimp = Mailchimp(apiId);

 }
 catch(err){
 console.log(err);
 }

  exports.mailChimp = functions.https.onRequest((request, response) => {
    corsHandler(request, response,async () =>{
    const email = request.body.email;

    try{
    console.log("adding additional user");
    await mailchimp.post(
    'lists/$mailChimpId/members',
    {
    email_address :email
    status: "pending"
    }
    );
    console.log("jaya");
    response.status(200).send('successfully added')
     }
     catch(err){
     console.log("failed added");
     }

    }
  });



