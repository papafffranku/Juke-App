const functions = require("firebase-functions");
const admin = require('firebase-admin');
const { document } = require("firebase-functions/v1/firestore");
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

exports.sendNotification = functions.region('asia-south1').
firestore.document("/chatroom/{chatroomId}/chats/{message}")
.onCreate(async(snapshot, context)=>{
    console.log("Message created", snapshot.data());

    const chatroomId = context.params.chatroomId;
    const messageId = context.params.message;


    const sentTo = snapshot.data().sentTo;
    const message = snapshot.data().message;
    const sentBy = snapshot.data().sentBy;

    const sender = admin.firestore().collection('users').doc(sentBy);
    const senderData = await sender.get();
    const senderUsername = senderData.data().username;
    console.log(senderUsername);

    const messageRef = admin.firestore().collection('chatroom').doc(chatroomId).collection('chats').doc(messageId);
    const querySnapshot = await messageRef.get();

    const user = admin.firestore().collection('users').doc(sentTo).collection('tokens');
    const tokenSnapshot = await user.get();
    const message_counter = 0;

    
        if(querySnapshot.exists){
            console.log('Inside loop');
            tokenSnapshot.forEach(tokenDoc=>{
                if(tokenDoc.exists){
                    console.log('inside token loop');
                    const token =tokenDoc.data().token;
                    const payload = { notification: {
                        title: `You have a message from ${senderUsername}`,
                        body: message,
                        badge: '1',
                        sound: 'default'
                      }
                    
                    }

                    admin.messaging().sendToDevice(token,payload).then(response=>{console.log('Message sent ${message_counter}', response)})
        .catch(error=>{console.log('Error: ', error)});
                }
                else{
                    console.log('token not found');
                }
            })
            
            //const token = doc.data().token;
            
        }
        else{
            console.log('chat does not exist');
        }
    



});
    

exports.onCreateFollower = functions.region('asia-south1').
firestore.document("/followers/{userId}/userFollowers/{followerId}")
.onCreate(async(snapshot, context)=>{
    console.log("Follower created", snapshot.data());
    const userId = context.params.userId;
    const followerId = context.params.followerId;

    const userRef = admin.firestore()
              .collection('users')
              .doc(userId).collection('tokens');

    const querySnapshot1 = await userRef.get();

    querySnapshot1.forEach(doc=>{
        if(doc.exists){
            const token = doc.data().token;
            const payload = {
                notification:{
                    title: 'a user started following you',
                    badge:'1',
                    sound:'default'
                }
            }
        admin.messaging().sendToDevice(token,payload).then(response=>{console.log('Message sent', response)})
        .catch(error=>{console.log('Error: ', error)});
        }

        else{
            console.log('not found token');
        }
    })

    // const payload = { notification: {
    //     title: `You have a message from "${userFrom.data().nickname}"`,
    //     body: contentMessage,
    //     badge: '1',
    //     sound: 'default'
    //   }}

    //Create followed users posts ref
    const followedUserRef = 
    admin.firestore().
    collection('tracks').
    doc(userId).
    collection('publicSong');

    //Create following user's timeline ref
    const timelinePostRef = 
    admin.firestore().
    collection('timeline').
    doc(followerId).
    collection('timelinePosts');

    //Get followed users posts
    const querySnapshot = await followedUserRef.get();

    //add user posts to timeline
    querySnapshot.forEach(doc=>{
        if(doc.exists){
            const postId = doc.id;
            const postData = doc.data();
            timelinePostRef.doc(postId).set(postData);
        }
    })
});

exports.onDeleteFollower = functions.region('asia-south1').
firestore.document("/followers/{userId}/userFollowers/{followerId}").onDelete(async(snapshot, context)=>{
    console.log('Follower delete', snapshot.id);
    const userId = context.params.userId;
    const followerId = context.params.followerId;

    const timelinePostRef = 
    admin.firestore().
    collection('timeline').
    doc(followerId).
    collection('timelinePosts').
    where("Artist","==",userId);

    const querySnapshot= await timelinePostRef.get();
    querySnapshot.forEach(doc=>{
        if(doc.exists){
            doc.ref.delete();
        }
    })
});


//new uploads are added to the timeline
exports.onUploadTrack = functions.region('asia-south1').
firestore.document("/tracks/{userId}/publicSong/{trackId}").onCreate(async(snapshot,context)=>{
    const trackUpload = snapshot.data();
    const userId = context.params.userId;
    const trackId = context.params.trackId;

    const userFollowersRef = admin.firestore().collection('followers').
    doc(userId).
    collection('userFollowers');

    const querySnapshot = await userFollowersRef.get();



    querySnapshot.forEach(doc=>{
        const followerId = doc.id;
        admin.firestore.collection('timeline').
        doc(followerId).
        collection('timelinePosts').
        doc(trackId).set(trackUpload);
    });

});

exports.onUpdateTrack = functions.region('asia-south1').
firestore.document("/tracks/{userId}/publicSong/{trackId}").onUpdate(async(change, context)=>{
    const trackUpdated = change.after.data();
    const userId = context.params.userId;
    const trackId = context.params.trackId;

    const userFollowersRef = admin.firestore().collection('followers').
    doc(userId).
    collection('userFollowers');

    const querySnapshot = await userFollowersRef.get();

    querySnapshot.forEach(doc=>{
        const followerId = doc.id;
        admin.firestore().collection('timeline').
        doc(followerId).
        collection('timelinePosts').
        doc(trackId).get().then(doc=>{
            if(doc.exists){
                doc.ref.update(trackUpdated);
            }
        });
    });
});

exports.onDeleteTrack = functions.region('asia-south1').
firestore.document("/tracks/{userId}/publicSong/{trackId}").onDelete(async(snapshot,context)=>{
    const userId = context.params.userId;
    const trackId = context.params.trackId;

    const userFollowersRef = admin.firestore().collection('followers').
    doc(userId).
    collection('userFollowers');

    const querySnapshot = await userFollowersRef.get();

    querySnapshot.forEach(doc=>{
        const followerId = doc.id;
        admin.firestore().collection('timeline').
        doc(followerId).
        collection('timelinePosts').
        doc(trackId).get().then(doc=>{
            if(doc.exists){
                doc.ref.delete();
            }
        });
    });
})
    