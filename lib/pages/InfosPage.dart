import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../webservice/api_service.dart';

class InfosPage extends StatefulWidget {
  const InfosPage({super.key});

  @override
  State<InfosPage> createState() => _InfosPageState();
}

class _InfosPageState extends State<InfosPage> {
  String htmlContent = '';
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller!),
    );
  }

  Future<void> _initAsync() async {
    await _fetchHtmlContent();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(htmlContent);
  }

  Future<void> _fetchHtmlContent() async {
    String? content = await ActuApi.instance.fetchHtmlContent();
    if (content != null) {
      setState(() {
        htmlContent = content;
      });
    }
  }
}
