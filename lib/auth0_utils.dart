import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class Utils {
  static const String DOMAIN = "idee.auth0.com";
  static const String API_AUDIENCE = "https://backend-api-url.com/";
  static const String CLIENT_ID = "qX74qk34T8yHevmg8J3rOU6JuulIZ5Si";
  static const String CALLBACK_URI =
      "demo://idee.auth0.com/dev.idee.flutterauth0/callback";
  static const String SCOPES = "profile email";
  String generatedCodeVerifier = '';

  Utils() {
    generatedCodeVerifier = _createCodeVerifier();
  }

  String _createCodeVerifier() {
    var randomGenerator = Random.secure();
    var verifier = List<int>.generate(32, (i) => randomGenerator.nextInt(256));
    String encodedString = base64Url.encode(verifier);
    return encodedString.replaceAll("=", "");
  }

  String createCodeChallenge(String verifier) {
    var enc = utf8.encode(verifier);
    var challenge = sha256.convert(enc).bytes;
    String encodedString = base64UrlEncode(challenge);
    return encodedString.replaceAll("=", "");
  }

  getAuthURL() {
    var codeVerifier = generatedCodeVerifier;
    var codeChallenge = createCodeChallenge(codeVerifier);

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

  exchangeAuthCodeForToken(String authCode) async {
    String url = "https://$DOMAIN/oauth/token";

    var headers = Map<String, String>();
    headers["Content-Type"] = "application/x-www-form-urlencoded";
//    headers['Content-Type'] = 'application/json';

    var requestBody = json.encode({
      "grant_type": "authorization_code",
      "client_id": CLIENT_ID,
      "code_verifier": generatedCodeVerifier,
      "code": authCode,
      "redirect_uri": CALLBACK_URI
    });

    var response = await http.post(url, body: requestBody, headers: headers);
    return response;
  }
}
// https://stackoverflow.com/questions/4492426/remove-trailing-when-base64-encoding/4492448#4492448
