import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class Auth0Utils {
  static const String DOMAIN = "YOUR_AUTH0_DOMAIN";
  static const String API_AUDIENCE = "YOUR_API_IDENTIFIER";
  static const String CLIENT_ID = "YOUR_NATIVE_CLIENT_ID";
  static const String CALLBACK_URI =
      "demo://YOUR_AUTH0_DOMAIN/dev.idee.flutterauth0/callback";
  static const String SCOPES = "profile email";
  String _generatedCodeVerifier = '';

  Auth0Utils() {
    _generatedCodeVerifier = _createCodeVerifier();
  }

  String _createCodeVerifier() {
    var randomGenerator = Random.secure();
    var verifier = List<int>.generate(32, (i) => randomGenerator.nextInt(256));
    String encodedString = base64Url.encode(verifier);
    return encodedString.replaceAll("=", "");
  }

  String _createCodeChallenge(String verifier) {
    var enc = utf8.encode(verifier);
    var challenge = sha256.convert(enc).bytes;
    String encodedString = base64UrlEncode(challenge);
    return encodedString.replaceAll("=", "");
  }

  getAuthURL() {
    var codeChallenge = _createCodeChallenge(_generatedCodeVerifier);
    String authorizationUrl = "https://$DOMAIN/authorize" +
        "?scope=${Uri.encodeFull(SCOPES)}" +
        "&audience=$API_AUDIENCE" +
        "&response_type=code" +
        "&client_id=$CLIENT_ID" +
        "&code_challenge=$codeChallenge" +
        "&code_challenge_method=S256" +
        "&redirect_uri=$CALLBACK_URI";
    return authorizationUrl;
  }

  Future<String> exchangeAuthCodeForToken(String authCode) async {
    String url = "https://$DOMAIN/oauth/token";

    var headers = Map<String, String>();
    headers['Content-Type'] = 'application/json';

    var requestBody = json.encode({
      "grant_type": "authorization_code",
      "client_id": CLIENT_ID,
      "code_verifier": _generatedCodeVerifier,
      "code": authCode,
      "redirect_uri": CALLBACK_URI
    });

    var response = await http.post(url, body: requestBody, headers: headers);
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);
      return decodedJson['access_token'];
    } else {
      return null;
    }
  }
}
// https://stackoverflow.com/questions/4492426/remove-trailing-when-base64-encoding/4492448#4492448
