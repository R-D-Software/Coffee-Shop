import 'package:coffee_shop/Business/Cart/cart.dart';
import 'package:coffee_shop/Business/Cart/cart_bloc.dart';
import 'package:coffee_shop/Models/coffee_Item.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_box_decoration.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_flat_button.dart';
import 'package:coffee_shop/UI/Components/CustomWidgets/renao_waiting_ring.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../stroked_text.dart';
import 'cart_list_item.dart';

class CartBody extends StatefulWidget {
  @override
  _CartBodyState createState() => _CartBodyState();

  double bottomBarHeight = 50;
  double bottomNavBarHeight = 112;
}

class _CartBodyState extends State<CartBody> {
  @override
  void initState() {
    super.initState();
//    getCoffees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CartBloc>(
        builder: (context) => CartBloc(),
        child: Container(
          decoration: RenaoBoxDecoration.builder(context),
          child: BlocListener(
            bloc: BlocProvider.of<CartBloc>(context),
            listener: (BuildContext context, CartState state) {},
            child: BlocBuilder(
              bloc: BlocProvider.of<CartBloc>(context),
              builder: (BuildContext context, CartState state) {
                if (state is CartInitial) {
                  getCoffees();
                  return Container();
                } else if (state is CartLoading) {
                  return _buildLoading();
                } else if (state is CartLoaded) {
                  return buildScreen(state.cart);
                } else {
                  return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _getCoffeeList(List<CoffeeItem> items, Cart cart) {
    return ListView(
      children: items.map((f) {
        return Container(
          margin: f == items.first
              ? EdgeInsets.only(top: 30)
              : EdgeInsets.only(top: 0),
          child: CartListItem(getCoffees, item: f),
        );
      }).toList(),
    );
  }

  Widget _buildLoading() {
    return RenaoWaitingRing();
  }

  Widget _getEmptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[],
    );
  }

  void getCoffees() {
    final cartBloc = BlocProvider.of<CartBloc>(context);
    cartBloc.dispatch(GetCoffeeItems());
  }

  Widget buildScreen(Cart cart) {
    return Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height -
              widget.bottomNavBarHeight -
              widget.bottomBarHeight,
          child: cart.shopItems.isNotEmpty
              ? _getCoffeeList(cart.shopItems, cart)
              : _getEmptyList(),
        ),
        Container(
          height: widget.bottomBarHeight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              StrokedText(
                text: "Végösszeg: ${cart.sum}",
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              RenaoFlatButton(
                title: "Időpont",
                fontSize: 16,
                fontWeight: FontWeight.w700,
                textColor: Theme.of(context).primaryColor,
                onPressed: () {
                  print("időpont");
                },
                borderColor: Colors.black12,
                borderWidth: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
