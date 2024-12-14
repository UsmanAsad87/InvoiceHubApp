import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OAuthPage extends StatelessWidget {

  final String clientId = 'ca_PUnpu5iIUzQZ1kp29F7safasfasfasfasfas';
  final String redirectUri = 'https://invoiceproducer.page.link/29hsdsdsdQ';
  final String responseType = 'code';
  final String scope = 'read_write'; // Adjust scopes as per your requirements

  String getAuthorizationUrl() {
    return 'https://connect.stripe.com/oauth/authorize?response_type=$responseType&client_id=$clientId&scope=$scope&redirect_uri=$redirectUri';
  }

  void launchAuthorizationUrl() async {
    final url = getAuthorizationUrl();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorize with Stripe'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            launchAuthorizationUrl();
          },
          child: Text('Connect with Stripe'),
        ),
      ),
    );
  }
}
