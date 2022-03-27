import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../exports/core.dart';

class IntegratedWebView extends StatefulWidget {
  final String link;
  final String title;
  const IntegratedWebView({Key? key, required this.link, required this.title}) : super(key: key);

  @override
  _IntegratedWebViewState createState() => _IntegratedWebViewState();
}

class _IntegratedWebViewState extends State<IntegratedWebView> {
  bool loading = true;
  double progress = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebView(
              initialUrl: widget.link,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: false,
              onPageStarted: (_) => setState(() => loading = false),
              onProgress: (value) => log('progress: $value'),
              // onWebViewCreated: (WebViewController v) async => webViewController = v,
            ),
            Visibility(
              visible: loading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
