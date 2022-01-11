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

exports.sendNotification = functions.firestore.document("/chatroom/{chatroomId}/chats/{message}")
.onCreate(async(snapshot, context)=>{
    console.log('----------------start function--------------------');
    const doc = snapshot.data();
    console.log(doc);
    
    const sentBy = doc.sentBy;
    const sentTo = doc.sentTo;
    const message = doc.message;

    admin.firestore().
    collection('users').
    where('id','==',sentTo).
    collection('tokens')
    get().then(querySnapshot =>{querySnapshot.forEach(userTo=>{console.log('Found user')
    if(userTo.data().token){
        admin.firestore.collection('users')
        .where('id', '==', sentBy)
        .get().then(querySnapshot2=>{querySnapshot2.forEach(userFrom=>{console.log('Found user :${userFrom.data().username}')

        const payload = { notification: {
            title: `You have a message from "${userFrom.data().username}"`,
            body: message,
            badge: '1',
            sound: 'default'
          }
        
        }

        admin.messaging().sendToDevice(userTo.data().token, payload).then(response =>{console.log('Successfully sent message:',response)})
        .catch(error=>{console.log('Error: ',error)
            })
    
        })
    })

    }

    else{
        console.log('Cannot find pushToken')
    }
})
})

return null
})

exports.onCreateFollower = functions.region('asia-south1').
firestore.document("/followers/{userId}/userFollowers/{followerId}")
.onCreate(async(snapshot, context)=>{
    console.log("Follower created", snapshot.data());
    const userId = context.params.userId;
    const followerId = context.params.followerId;

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
    