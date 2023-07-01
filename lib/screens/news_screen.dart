import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

//below is new impl
// import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';

// class NewsScreen extends StatefulWidget {
//   const NewsScreen({
//     super.key,
//     required this.url,
//   });
//   final String url;

//   @override
//   State<NewsScreen> createState() => _NewsScreenState();
// }

// class _NewsScreenState extends State<NewsScreen> {
//   late PlatformWebViewController _controller;
//   @override
//   void initState() {
//     _controller = PlatformWebViewController(
//       const PlatformWebViewControllerCreationParams(),
//     )..loadRequest(
//         LoadRequestParams(
//           uri: Uri.parse(widget.url),
//         ),
//       );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // _controller
//     //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
//     //   ..runJavaScript(
//     //     "document.getElementsByTagName('header')[0].style.display='none';",
//     //   )
//     //   ..runJavaScript(
//     //     "document.getElementsByTagName('ul')[0].style.display='none';",
//     //   )
//     //   ..runJavaScript(
//     //     "document.getElementsByTagName('nav')[0].style.display='none';",
//     //   )
//     //   ..runJavaScript(
//     //     "document.getElementsByTagName('footer')[0].style.display='none';",
//     //   );

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           Uri.parse(widget.url).authority,
//           style: Theme.of(context).textTheme.titleMedium,
//         ),
//       ),
//       body: PlatformWebViewWidget(
//         PlatformWebViewWidgetCreationParams(controller: _controller),
//       ).build(context),
//     );
//   }
// }
//above is new impl

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key, required this.url});
  final String url;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late WebViewController _controller;
  bool _onProgress = true;
  late final PlatformWebViewControllerCreationParams params;

  @override
  void initState() {
    const PlatformWebViewControllerCreationParams params =
        PlatformWebViewControllerCreationParams();
    WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(
              () {
                _onProgress = false;
              },
            );
          },
        ),
      );

    _controller = controller;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _controller
      ..runJavaScript(
        "document.getElementsByTagName('header')[0].style.display='none';",
      )
      ..runJavaScript(
        "document.getElementsByTagName('ul')[0].style.display='none';",
      )
      ..runJavaScript(
        "document.getElementsByTagName('nav')[0].style.display='none';",
      )
      ..runJavaScript(
        "document.getElementsByTagName('footer')[0].style.display='none';",
      );
    return Scaffold(
      appBar: _onProgress
          ? null
          : AppBar(
              title: Text(
                Uri.parse(widget.url).authority,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
      body: _onProgress
          ? const Center(child: CircularProgressIndicator())
          : WebViewWidget(controller: _controller),
    );
  }
}
