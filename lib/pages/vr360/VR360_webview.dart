import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_babe/controller/setting_controller.dart';
import 'package:flutter_babe/models/setting_model.dart';
import 'package:flutter_babe/utils/colors.dart';
import 'package:flutter_babe/widgets/custom_loader.dart';
import 'package:get/get.dart';

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
  final SettingController settingController = Get.find<SettingController>();
  SettingModel? settingModel;

  String? selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }

    // Load VR360 link initially
    _loadVR360Link();
  }

  // Method to load VR360 link
  Future<void> _loadVR360Link() async {
    settingController.getSetting().then((response) {
      if (response.isSuccess) {
        setState(() {
          selectedUrl = settingController.settingModel?.linkIframe ?? '';
          _isLoading = false;
        });
      } else {
        // Handle failure scenario if needed
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("stop".tr),
          backgroundColor: AppColors.colorAppBar,
          leading: IconButton(
            icon: Icon(Icons.pause),
            onPressed: () => _handleTabExit(),
          ),
        ),
        body: selectedUrl != null &&
                selectedUrl!.isNotEmpty // Check for null and empty
            ? Center(
                child: Container(
                  width: Dimensions.screenWidth,
                  child: Stack(
                    children: [
                      WebView(
                        javascriptMode: JavascriptMode.unrestricted,
                        initialUrl: selectedUrl!,
                        gestureNavigationEnabled: true,
                        userAgent:
                            'Mozilla/5.0 (iPhone; CPU iPhone OS 9_3 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13E233 Safari/601.1',
                        onWebViewCreated:
                            (WebViewController webViewController) {
                          _controller.future
                              .then((value) => controllerGlobal = value);
                          _controller.complete(webViewController);
                        },
                        onProgress: (int progress) {
                          print("uri is loading: " + selectedUrl!);
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
              )
            : Center(child: CustomLoader()),
      ),
    );
  }

  Future<void> _handleTabExit() async {
    await controllerGlobal.loadUrl(selectedUrl!);
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
      await _handleTabExit();
      return true;
    }
  }
}
