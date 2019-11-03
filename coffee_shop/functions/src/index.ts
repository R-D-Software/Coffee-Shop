import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// tslint:disable-next-line: no-implicit-dependencies
import { DocumentSnapshot } from '@google-cloud/firestore';

admin.initializeApp();

const db = admin.firestore();
//const fcm = admin.messaging();

export const onOrderReady = functions.firestore.document("orders/{orderID}").onUpdate(async (change, context) => 
{
	const userID : string = change.after.get("userID");
	const box : string = change.after.get("box");

	const userSnapshot : DocumentSnapshot = await db.collection("users").doc(userID).get();
	const boxSnapshot : DocumentSnapshot = await db.collection("boxes").doc(box).get();

	const boxNumber : string = boxSnapshot.get("number");
	const deviceToken : string = userSnapshot.get("deviceToken"); 
	
	if(box !== "-1")
	{
		const message = 
		{
			notification: {title: 'Your order is ready', body: 'Order has been placed in the box: ' + boxNumber},
			token: deviceToken
		};
		admin.messaging().send(message)
		.then((response) => {			
			console.log('Successfully sent message:', response);
		})
		.catch((error) => {
			console.log('Error sending message:', error);
		});

		return db.doc("boxes/" + box).update({"empty": false, "ownerUserID": userID});
	}

	return change.after.ref;
});