import 'package:flutter/material.dart';
import 'package:flutter_auth0/flutter_auth0.dart';
import 'package:flutterauth0/job_list_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool isError = false;
  bool isLoading = false;
  Auth0 auth0;
  static const _AUTH0_DOMAIN = "YOUR_AUTH0_DOMAIN";

  @override
  void initState() {
    auth0 = Auth0(
        baseUrl: 'https://$_AUTH0_DOMAIN/', clientId: 'YOUR_NATIVE_CLIENT_ID');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                strokeWidth: 2,
              )
            : isError
                ? Text(
                    'Could not log in user',
                    style: TextStyle(fontSize: 16),
                  )
                : RaisedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
      ),
    );
  }

  void login() async {
    try {
      setState(() {
        isLoading = true;
      });
      var response = await auth0.webAuth.authorize({
        'audience': 'https://$_AUTH0_DOMAIN/userinfo',
        'scope': 'openid email offline_access',
      });

      if (response['access_token'] != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => JobListPage()),
            (Route<dynamic> route) => false);
      } else {
        setState(() {
          isError = true;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        isError = true;
      });
    }
  }
}
