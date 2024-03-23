import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InfosPage extends StatefulWidget {
  const InfosPage({super.key});

  @override
  State<InfosPage> createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  WebViewController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://test-pgt-dev.apnl.ws/html'), headers: {
        'Accept': 'text/html',
        'X-AP-Key': 'uD4Muli8nO6nzkSlsNM3d1Pm',
        'X-AP-DeviceUID': 'Documentation',
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Infos")),
        body: WebViewWidget(
          controller: _controller!,
        ));
  }
}
