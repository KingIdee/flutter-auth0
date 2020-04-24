import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutterauth0/auth0_utils.dart';
import 'package:flutterauth0/job_list_page.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool isError = false;
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

      if (uri.queryParameters.keys.contains('code')) {
        String authCode = uri.queryParameters['code'];
        _auth0utils.exchangeAuthCodeForToken(authCode).then((token) {
          closeWebView();
          if (token != null) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => JobListPage()),
                    (Route<dynamic> route) => false);
          } else {
            setState(() {
              isError = true;
            });
          }
        });
      } else {
        setState(() {
          isError = true;
        });
      }
    }, onError: (err) {
      // Handle exception by warning the user their action did not succeed
      print(err);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isError
            ? Text(
                'Could not log in user',
                style: TextStyle(fontSize: 16),
              )
            : RaisedButton(
                onPressed: () {
                  launch(_auth0utils.getAuthURL());
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 16),
                ),
              ),
      ),
    );
  }
}
