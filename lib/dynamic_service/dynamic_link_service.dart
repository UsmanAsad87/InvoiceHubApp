import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../commons/common_widgets/show_toast.dart';
import '../routes/route_manager.dart';

class DynamicLinkService {

  static Future<String> buildDynamicLinkForVideo(bool short, ) async {
    String? _uriPrefix;
    String? _packageName;
    String? _bundleId;
    _uriPrefix = "https://invoiceproducer.page.link";
    _packageName = "com.fast.quick.invoice.maker";
    _bundleId = "com.mumazzad.invoiceProducer";


    String _linkMessage;
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("$_uriPrefix"),
      uriPrefix: _uriPrefix,
      androidParameters: AndroidParameters(
        packageName: _packageName,
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        bundleId: _bundleId,
        appStoreId: "6462510078",
        minimumVersion: "0.0.1",
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        source: "twitter",
        medium: "social",
        campaign: "example-promo",
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: 'OAuth',
      ),
    );

    Uri url;
    final FirebaseDynamicLinks firebaseDynamicLinks =
        FirebaseDynamicLinks.instance;
    if (short) {
      final ShortDynamicLink shortLink =
      await firebaseDynamicLinks.buildShortLink(dynamicLinkParams);
      url = shortLink.shortUrl;
    } else {
      url = await firebaseDynamicLinks.buildLink(dynamicLinkParams);
    }

    _linkMessage = url.toString();
    return _linkMessage;
  }




  static initDynamicLink(BuildContext context,WidgetRef ref) async {
// if app is running
    FirebaseDynamicLinks.instance.onLink.listen((event) async {
      Navigator.pushNamed(context, AppRoutes.dashboardScreen );
    }).onError((error) {
      showToast(msg: "Error opening link");
    });



    //if app is not running
    FirebaseDynamicLinks.instance;
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    if (data != null) {
      Navigator.pushNamed(context, AppRoutes.dashboardScreen );
    }
  }
}
