// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter_babe/utils/dimension.dart';

class VR360WebView extends StatefulWidget {
  bool isTabSelected;

  VR360WebView({
    Key? key,
    this.isTabSelected = false,
  }) : super(key: key);

  @override
  State<VR360WebView> createState() => _VR360WebViewState();
}

class _VR360WebViewState extends State<VR360WebView> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl = 'https://www.babe360.kennatech.vn';

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Stop"),
          leading: IconButton(
            icon: Icon(Icons.pause),
            onPressed: () => _exitApp(context),
          ),
          //backgroundColor: AppColors.mainColor,
        ),
        body: Center(
          child: Container(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode
                      .unrestricted, // Nếu đang tải, cho phép JavaScript, nếu không thì vô hiệu hóa
                  initialUrl: selectedUrl,
                  gestureNavigationEnabled: true,
                  userAgent:
                      'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.future
                        .then((value) => controllerGlobal = value);
                    _controller.complete(webViewController);
                  },
                  onProgress: (int progress) {
                    print("WebView is loading (progress : $progress%)");
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                    if (widget.isTabSelected) {
                      setState(() {
                        _isLoading = true;
                      });
                    }
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    setState(() {
                      _isLoading = false;
                    });
                    widget.isTabSelected = false;
                    print("test tab selected: " +
                        widget.isTabSelected.toString());
                  },
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleTabExit() async {
    //await stopAudio();
    await controllerGlobal.loadUrl('https://www.babe360.kennatech.vn');
    setState(() {
      widget.isTabSelected = false;
    });
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      print("app exited");
      //await stopAudio();
      await _handleTabExit();
      return true;
    }
  }
}
