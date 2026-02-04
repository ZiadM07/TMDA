import '../../../../core/constants/exports.dart';
import 'package:webview_flutter/webview_flutter.dart';

@RoutePage()
class AuthWebViewScreen extends StatefulWidget {
  const AuthWebViewScreen({
    super.key,
    required this.initialUrl,
    required this.onSuccessRoute,
    required this.successUrlKeywords,
  });

  final String initialUrl;
  final PageRouteInfo onSuccessRoute;
  final List<String> successUrlKeywords;

  @override
  State<AuthWebViewScreen> createState() => _AuthWebViewScreenState();
}

class _AuthWebViewScreenState extends State<AuthWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(
        'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 '
        'Chrome/120.0.0.0 Mobile Safari/537.36',
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onNavigationRequest: (request) {
            if (_isSuccess(request.url)) {
              context.replaceRoute(widget.onSuccessRoute);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  bool _isSuccess(String url) {
    return widget.successUrlKeywords.any(url.contains);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading) const LinearProgressIndicator(minHeight: 2),
          ],
        ),
      ),
    );
  }
}
