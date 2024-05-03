/*
*
*
* import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class Altibbi extends StatefulWidget {
  const Altibbi({super.key});

  @override
  State<Altibbi> createState() => _AltibbiState();
}

class _AltibbiState extends State<Altibbi> {
  @override
  Widget build(BuildContext context) {
    var params = const PlatformWebViewControllerCreationParams();
 var controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {
            showDialog(
              context: context,
              builder: (context) => const AlertDialog(
                content: Text('جصل خطأ اثناء تحميل الصفحة'),
              ),
            );
          },
        ),
      )
      ..loadRequest(Uri.parse(altibbiURL));

    return Scaffold(
      appBar: AppBar(title: const Text('الطبي')),
     // body: WebViewWidget(controller: controller),
    );
  }
}

*
*
* */
