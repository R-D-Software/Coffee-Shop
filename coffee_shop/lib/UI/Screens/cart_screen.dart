import 'package:coffee_shop/Business/Cart/cart_bloc.dart';
import 'package:coffee_shop/UI/Components/CartWidgets/cart_body.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CartBloc>(
        builder: (context) => CartBloc(),
        child: Container(
          child: RenaoScaffold(
            appBarTitle: "Cart",
            scaffoldBody: CartBody(),
          ),
          decoration: RenaoBoxDecoration.builder(context),
        ),
      ),
    );
  }
}
