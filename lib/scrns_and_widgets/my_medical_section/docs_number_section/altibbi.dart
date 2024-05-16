import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organize_me/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Altibbi extends StatefulWidget {
  const Altibbi({super.key});

  @override
  State<Altibbi> createState() => _AltibbiState();
}

class _AltibbiState extends State<Altibbi> {
  Widget? body;
  String altibbiURL =
      '''https://altibbi.com/%D8%A7%D9%84%D8%AF%D9%84%D9%8A%D9%84-%D8%A7%D9%84%D8%B7%D8%A8%D9%8A/%D8%B3%D9%88%D8%B1%D9%8A%D8%A7''';

  @override
  Widget build(BuildContext context) {
    var params = const PlatformWebViewControllerCreationParams();
    var controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (value) {
            setState(() {
              body = null;
            });
          },
          onProgress: (request) {
            setState(() {
              body = Center(
                  child: CircularProgressIndicator(
                color: appColorTheme,
              ));
            });
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              body = Center(
                child: Text(
                  'تحقق من اتصالك بالانترنت',
                  style: TextStyle(fontSize: 18),
                ),
              );
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(altibbiURL));
    return Scaffold(
      appBar: AppBar(title: const Text('الطبي')),
      body: body ?? WebViewWidget(controller: controller),
    );
  }
}

