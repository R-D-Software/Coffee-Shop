import 'package:built_collection/built_collection.dart';
import 'package:coffee_shop/Business/Database/payment_DB.dart';
import 'package:coffee_shop/Business/Database/user_DB.dart';
import 'package:coffee_shop/Business/validator.dart';
import 'package:coffee_shop/Data/barion_api_service.dart';
import 'package:coffee_shop/Models/Barion/barion_item.dart';
import 'package:coffee_shop/Models/Barion/barion_payment.dart';
import 'package:coffee_shop/Models/Barion/barion_transaction.dart';
import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_text_field.dart';
import 'package:coffee_shop/UI/Screens/barion_webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DepositDialog {
  TextEditingController amountOfDepoistController = TextEditingController();

  DepositDialog.showDialog({@required BuildContext context, @required String title}) {
    Dialog dialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 50, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(LanguageModel.amountOfDeposit[LanguageModel.currentLanguage]),
                      Container(
                        width: 80,
                        child: RenaoTextField(
                          baseColor: Colors.grey,
                          borderColor: Colors.grey[400],
                          errorColor: Colors.red,
                          obscureText: false,
                          validator: Validator.validatePositiveNumber,
                          controller: amountOfDepoistController,
                          hint: '5000',
                          inputType: TextInputType.number,
                        ),
                      ),
                      RenaoFlatButton(
                        title: LanguageModel.deposit[LanguageModel.currentLanguage],
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                          makePayment(context);
                        },
                        splashColor: Colors.black12,
                        borderColor: Color.fromRGBO(59, 89, 152, 1.0),
                        borderWidth: 0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  )),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "$title",
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Align(
              alignment: Alignment(1.05, -1.05),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).accentColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(barrierDismissible: false, context: context, builder: (BuildContext context) => dialog);
  }

  void makePayment(BuildContext context) async {
    int total = 0;
    ListBuilder<BuiltBarionItem> builtItems = ListBuilder();
    final newItem = BuiltBarionItem((b) => b
      ..Name = 'Befizetés'
      ..Description = 'Befizetés'
      ..Quantity = 1
      ..Unit = LanguageModel.piece[LanguageModel.currentLanguage]
      ..UnitPrice = double.parse(amountOfDepoistController.text).round()
      ..ItemTotal = double.parse(amountOfDepoistController.text).round());

    builtItems.add(newItem);
    total = double.parse(amountOfDepoistController.text).round();

    final newTransaction = BuiltBarionTransaction((b) => b
      ..POSTransactionId = 'Elsobolt'
      ..Payee = 'robeszpierre@gmail.com'
      ..Total = total
      ..Items = builtItems);

    ListBuilder<String> fundingSources = ListBuilder();
    fundingSources.add("All");

    ListBuilder<BuiltBarionTransaction> transactions = ListBuilder();
    transactions.add(newTransaction);

    final newPayment = BuiltBarionPayment((b) => b
      ..POSKey = BuiltBarionPayment.renaoPOSKey
      ..PaymentType = 'Immediate'
      ..PaymentRequestId = Uuid().v4()
      ..FundingSources = fundingSources
      ..Currency = "HUF"
      ..RedirectUrl = "https://www.renao.com"
      ..GuestCheckOut = true
      ..CallbackUrl = "https://europe-west1-renao-7c69c.cloudfunctions.net/onDeposit"
      ..Locale = LanguageModel.getCurrentLanguageLocale()
      ..Transactions = transactions);

    await BarionApiService.create().postBarionPayment(newPayment).then((response) async {
      final id = response.body.PaymentId;
      Navigator.of(context).pushNamed(BarionWebview.route, arguments: {"paymentUrl": response.body.GatewayUrl});
      await _writePaymentDataToDatabase(id);
    });
  }

  Future _writePaymentDataToDatabase(String paymentId) async {
    final user = await UserDB.getCurrentUser();
    PaymentDB.writePaymentDataIntoDb(paymentId, user.userID);
  }
}
