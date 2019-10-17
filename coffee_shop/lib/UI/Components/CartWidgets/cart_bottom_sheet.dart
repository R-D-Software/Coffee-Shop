import 'package:coffee_shop/Models/language.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class CartBottomSheet extends StatelessWidget 
{
    DateTime orderDate;
    CartBottomSheet(@required this.orderDate);

    @override
    Widget build(BuildContext context) 
    {
        return Container
        (
            child: Wrap
            (
                children: <Widget>
                [
                    _getDateWidget(),
                    _getTimeWidget(context),
                    _getPlaceWidget(),
                    _getOrderButton(context),
                ],
            ),
        );
    }

    Widget _getDateWidget()
    {
        return Padding
        (
            padding: EdgeInsets.all(10),
            child: Row
            (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [
                    Text
                    (
                        LanguageModel.date[LanguageModel.currentLanguage],
                        style: TextStyle
                        (
                            fontSize: 20,
                        ),
                    ),
                    GestureDetector
                    (
                        child: Text(orderDate.year.toString() + "." +  _toDateFormatNumber(orderDate.month) + "." + _toDateFormatNumber(orderDate.day)),
                        onTap: ()
                        {
                            print("Tapics");
                        },
                    ),
                ],
            ),
        );
    }

    Widget _getTimeWidget(BuildContext context)
    {
        return Padding
        (
            padding: EdgeInsets.all(10),
            child: Row
            (
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>
                [
                    RenaoNumberPicker
                    (
                        numbers: [1,3,6,7,8],
                        initialValue: 8,
                    ),
                    Text(":"),
                    RenaoNumberPicker
                    (
                        initialValue: 0,
                        numbers: [0,1,3,6,7,8,45]
                    ),
                ],
            ),
        );
    }

    Widget _getPlaceWidget()
    {
        return Padding
        (
            padding: EdgeInsets.all(10),
            child: Row
            (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>
                [
                    Text
                    (
                        LanguageModel.selectedPlace[LanguageModel.currentLanguage],
                        style: TextStyle
                        (
                            fontSize: 20,
                        ),
                    ),
                    GestureDetector
                    (
                        child: Text("BDFCKP"),
                        onTap: ()
                        {
                            print("TABB");
                        },
                    ),
                ],
            ),
        );
    }

    Widget _getOrderButton(BuildContext context)
    {
        return Container(
            alignment: Alignment.bottomCenter,
            child: ButtonTheme(
                buttonColor: Color.fromRGBO(231, 82, 100, 1),
                minWidth: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height * 0.065,
                child: RaisedButton(
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                elevation: 0,
                onPressed:()
                {
                            
                },
                child: Text(
                    LanguageModel.order[LanguageModel.currentLanguage],
                    style: TextStyle(fontSize: 25, color: Colors.white),
                ),
                ),
            ),
        );
        return Padding
        (
            padding: EdgeInsets.all(25),
            child: Center
            (
                child: RenaoFlatButton
                (
                    title: LanguageModel.order[LanguageModel.currentLanguage],
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () 
                    {
                        
                    },
                    splashColor: Colors.black12,
                    borderColor: Colors.white,
                    borderWidth: 2,
                    color: Theme.of(context).accentColor,
                )
            ),
        );
    }

    String _toDateFormatNumber(int number)
    {
        String retval = number.toString();

        if(number<10)
            retval = "0" + number.toString();

        return retval;
    }
}