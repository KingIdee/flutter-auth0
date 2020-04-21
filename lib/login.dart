import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterauth0/auth0_utils.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool loading = false;
  StreamSubscription _streamSubscription;
  Auth0Utils _auth0utils = Auth0Utils();

  @override
  void initState() {
    super.initState();
    initUniLinks();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }

  void initUniLinks() async {
    _streamSubscription = getLinksStream().listen((String link) {
      Uri uri = Uri.parse(link);

      print(uri.path);
      if (uri.queryParameters.keys.contains('code')) {
        String authCode = uri.queryParameters['code'];
        _auth0utils.exchangeAuthCodeForToken(authCode).then((token) {
          if (token != null) {

          } else {
            // error
          }
        });
      } else {
//        value = uri.queryParameters['error'];
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      print(err);
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
        onPressed: () {
          setState(() {
            loading = true;
          });
          launch(_auth0utils.getAuthURL());
        },
        child: Text('Login'),
      ),
    );
  }
}
