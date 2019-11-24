import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// tslint:disable-next-line: no-implicit-dependencies
import { DocumentSnapshot } from '@google-cloud/firestore';

admin.initializeApp();

const db = admin.firestore();
//const fcm = admin.messaging();

export const onOrderReady = functions.region("europe-west1").
firestore.document("orders/{orderID}").onUpdate(async (change, context) =>
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

		return db.doc("boxes/" + box).update({"empty": false, "ownerUserID": userID, "itemsRetrieved": false, "currentOrderID": change.after.id});
	}

	return change.after.ref;
});

export const onItemsRetreivedFromBox = functions.region("europe-west1").firestore.document("boxes/{boxID}").onUpdate(async (change, context) =>
{
	const itemsRetrieved : boolean = change.after.get("itemsRetrieved");

	if(itemsRetrieved === true)
	{
		return db.doc("boxes/" + change.after.id).update({"ownerUserID": "-1", "currentOrderID": "-1", "itemsRetrieved": false});
	}

	return change.after.ref;
});

exports.onSuccessfulPayment = functions.region("europe-west1").https.onRequest( async (req, res) => {
	// const getPaymentDocumentref = await db.collection("/payment").doc(req.body["PaymentId"]);
	// const paymentDocument : DocumentSnapshot = await getPaymentDocumentref.get();
	// let count : number= paymentDocument.get("serverModifiedCount");
	// const newCount : number = ++count;
	// await getPaymentDocumentref.update({"serverModifiedCount": newCount});
	res.status(200).send(req.body["ok"]);
});


