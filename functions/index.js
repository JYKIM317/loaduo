/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */


// const {onRequest} = require("firebase-functions/v2/https");
// const logger = require("firebase-functions/logger");

const admin = require("firebase-admin");
const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");

admin.initializeApp(functions.config().firebase);

const db = admin.firestore();
const rtdb = admin.database();

const app = express();
app.use(cors({origin: true}));

exports.createAnonymousChat = functions.region("asia-northeast3").https.onRequest((data, response) => {
  // 대기중인 유저 불러오기
  db.collection("MatchMakingStandBy").orderBy("registeredTime").get().then((standByUserList) => {
    let firstStandbyUser = null;
    let secondStandbyUser = null;
    let firstUID;
    let secondUID;
    let info;
    if (standByUserList.docs.length >= 2) {
      for (const standByUser of standByUserList.docs) {
        if (firstStandbyUser === null) {
          db.collection("MatchMakingStandBy").doc(standByUser.id).delete();
          firstStandbyUser = standByUser.data();
        } else if (secondStandbyUser === null) {
          db.collection("MatchMakingStandBy").doc(standByUser.id).delete();
          secondStandbyUser = standByUser.data();
        } else {
          break;
        }
      }
      if (firstStandbyUser !== null && secondStandbyUser !== null) {
        delete firstStandbyUser["registeredTime"];
        firstUID = firstStandbyUser.uid;
        delete secondStandbyUser["registeredTime"];
        secondUID = secondStandbyUser.uid;
        info = {
          [firstUID]: firstStandbyUser,
          [secondUID]: secondStandbyUser,
        };
        const chatAddress = `Chatting/Anonymous/${firstUID}_${secondUID}`;
        const chatData = {
          "info": info,
          "lastMessageTime": data.body.time,
        };
        rtdb.ref(chatAddress).set(chatData).then(() => {
          db.collection("Users").doc(firstUID).collection("AnonymousChat").doc("address").set({"chatAddress": chatAddress});
          db.collection("Users").doc(secondUID).collection("AnonymousChat").doc("address").set({"chatAddress": chatAddress});
        });
      }
    }
  });
});

exports.pushFcm = functions.region("asia-northeast3").https.onRequest(app);

app.post("/request", (data, res) => {
    var sendUID = data.body.call;
    if (sendUID!=null && sendUID!="" &&
    sendUID!=undefined) {
      console.log(sendUID);
      db.collection("Users").doc(sendUID).get()
          .then((snapshot) => {
            var fcmToken = snapshot.data().fcmToken;
            if (fcmToken!=null && fcmToken!="" &&
              fcmToken!=undefined) {
              var payload = {
                token: fcmToken,
                notification: {
                  title: "로아핸즈",
                  body: "파티 모집에 새로운 신청이 있습니다.",
                },
                apns: {
                  payload: {
                    aps: {
                      "category": "Message Category",
                      "content-available": 1,
                    },
                  },
                },
              };
              admin.messaging().send(payload)
                  .then((response) => {
                    res.status(200).send("ok");
                    console.log(response);
                    console.log("request fcm sucess");
                  }).catch((e) => {
                    res.status(500).send(e);
                  });
            }
          })
          .catch((err) => {
            console.log(err);
            console.log("request fcm fail");
          });
    }
});

app.post("/leave", (data, res) => {
  var sendUID = data.body.call;
  if (sendUID!=null && sendUID!="" &&
  sendUID!=undefined) {
    console.log(sendUID);
    db.collection("Users").doc(sendUID).get()
        .then((snapshot) => {
          var fcmToken = snapshot.data().fcmToken;
          if (fcmToken!=null && fcmToken!="" &&
            fcmToken!=undefined) {
            var payload = {
              token: fcmToken,
              notification: {
                title: "로아핸즈",
                body: "누군가 모집에서 탈퇴하였습니다.",
              },
              apns: {
                payload: {
                  aps: {
                    "category": "Message Category",
                    "content-available": 1,
                  },
                },
              },
            };
            admin.messaging().send(payload)
                  .then((response) => {
                    res.status(200).send("ok");
                    console.log(response);
                    console.log("leave fcm sucess");
                  }).catch((e) => {
                    res.status(500).send(e);
                  });
            }
          })
          .catch((err) => {
            console.log(err);
            console.log("leave fcm fail");
          });
  }
});

app.post("/accept", (data, res) => {
  var sendUID = data.body.call;
  if (sendUID!=null && sendUID!="" &&
  sendUID!=undefined) {
    console.log(sendUID);
    db.collection("Users").doc(sendUID).get()
        .then((snapshot) => {
          var fcmToken = snapshot.data().fcmToken;
          if (fcmToken!=null && fcmToken!="" &&
            fcmToken!=undefined) {
            var payload = {
              token: fcmToken,
              notification: {
                title: "로아핸즈",
                body: "신청하신 모집에 가입되셨습니다.",
              },
              apns: {
                payload: {
                  aps: {
                    "category": "Message Category",
                    "content-available": 1,
                  },
                },
              },
            };
            admin.messaging().send(payload)
                  .then((response) => {
                    res.status(200).send("ok");
                    console.log(response);
                    console.log("accept fcm sucess");
                  }).catch((e) => {
                    res.status(500).send(e);
                  });
            }
          })
          .catch((err) => {
            console.log(err);
            console.log("accept fcm fail");
          });
  }
});

app.post("/denied", (data, res) => {
  var sendUID = data.body.call;
  if (sendUID!=null && sendUID!="" &&
  sendUID!=undefined) {
    console.log(sendUID);
    db.collection("Users").doc(sendUID).get()
        .then((snapshot) => {
          var fcmToken = snapshot.data().fcmToken;
          if (fcmToken!=null && fcmToken!="" &&
            fcmToken!=undefined) {
            var payload = {
              token: fcmToken,
              notification: {
                title: "로아핸즈",
                body: "신청하신 모집에 거절되셨습니다.",
              },
              apns: {
                payload: {
                  aps: {
                    "category": "Message Category",
                    "content-available": 1,
                  },
                },
              },
            };
            admin.messaging().send(payload)
                  .then((response) => {
                    res.status(200).send("ok");
                    console.log(response);
                    console.log("denied fcm sucess");
                  }).catch((e) => {
                    res.status(500).send(e);
                  });
            }
          })
          .catch((err) => {
            console.log(err);
            console.log("denied fcm fail");
          });
  }
});

app.post("/leader", (data, res) => {
  var sendUID = data.body.call;
  if (sendUID!=null && sendUID!="" &&
  sendUID!=undefined) {
    console.log(sendUID);
    db.collection("Users").doc(sendUID).get()
        .then((snapshot) => {
          var fcmToken = snapshot.data().fcmToken;
          if (fcmToken!=null && fcmToken!="" &&
            fcmToken!=undefined) {
            var payload = {
              token: fcmToken,
              notification: {
                title: "로아핸즈",
                body: "파티장이 모집에서 탈퇴해 파티장을 위임받으셨습니다.",
              },
              apns: {
                payload: {
                  aps: {
                    "category": "Message Category",
                    "content-available": 1,
                  },
                },
              },
            };
            admin.messaging().send(payload)
                  .then((response) => {
                    res.status(200).send("ok");
                    console.log(response);
                    console.log("leader fcm sucess");
                  }).catch((e) => {
                    res.status(500).send(e);
                  });
            }
          })
          .catch((err) => {
            console.log(err);
            console.log("leader fcm fail");
          });
  }
});

app.post("/message", (data, res) => {
  var sendUID = data.body.call;
  if (sendUID!=null && sendUID!="" &&
  sendUID!=undefined) {
    console.log(sendUID);
    db.collection("Users").doc(sendUID).get()
        .then((snapshot) => {
          var fcmToken = snapshot.data().fcmToken;
          if (fcmToken!=null && fcmToken!="" &&
            fcmToken!=undefined) {
            var payload = {
              token: fcmToken,
              notification: {
                title: data.body.name,
                body: data.body.text,
              },
              apns: {
                payload: {
                  aps: {
                    "category": "Message Category",
                    "content-available": 1,
                  },
                },
              },
            };
            admin.messaging().send(payload)
                  .then((response) => {
                    res.status(200).send("ok");
                    console.log(response);
                    console.log("message fcm fail");
                  }).catch((e) => {
                    res.status(500).send(e);
                  });
            }
          })
          .catch((err) => {
            console.log(err);
            console.log("message fcm fail");
          });
  }
});

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
