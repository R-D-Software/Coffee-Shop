import 'package:coffee_shop/Models/language.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'order_page_screen.dart';

class BarionWebview extends StatefulWidget {
  static const String route = '/barionWebview';
  BarionWebview({Key key}) : super(key: key);

  @override
  _BarionWebviewState createState() => _BarionWebviewState();
}

class _BarionWebviewState extends State<BarionWebview> {
  String paymentUrl;
  @override
  Widget build(BuildContext context) {
    _initializeData(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageModel.pay[LanguageModel.currentLanguage]),
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: paymentUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (navigationRequest) {
            print(navigationRequest.url);
            if (navigationRequest.url.contains("renao.com")) {
              OrderPageScreen.isRedirectedFromBarion = true;
              Navigator.of(context).pop();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        );
      }),
    );
  }

  void _initializeData(BuildContext context) {
    final Map<String, dynamic> routeArgs = ModalRoute.of(context).settings.arguments;
    paymentUrl = routeArgs['paymentUrl'];
  }
}
