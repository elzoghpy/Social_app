// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String? url;

  WebViewScreen(article, {this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
