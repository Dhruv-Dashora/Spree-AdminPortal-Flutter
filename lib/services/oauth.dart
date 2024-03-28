import 'package:googleapis_auth/googleapis_auth.dart' as auth;
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/fcm/v1.dart' as fcm;

import 'package:http/http.dart' as http;

class OAuth {
  static final SCOPES = [fcm.FirebaseCloudMessagingApi.firebaseMessagingScope];
  static Future<String> refreshToken() async {
    final Map<String, dynamic> serviceAccountJson = {
      "type": "service_account",
      "project_id": "spree-bpgc",
      "private_key_id": "b9d31de3d008d173c25b7539a430ef68853418b9",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC4UkC0CjHLMEq/\nB3yMMm4eyQS9d7DVYJqnBYeTuhFSsm+eV5KLmLst296jzSj5HYz+owsqm68tAgXO\nMJvCsvB0kIP+e00tUwZ7dr8KSlLK3mbAO5zXJ3GqQu0pldHNJIEZF4WxjRd8UNFX\nvrkXr+2WVNk28gccM/JTwxqwQ3FAf3QzxBWFHNvowj1nrkFTe0z0dQDdYn8gkl33\nbk/ooEt8pZM6YVzKFz0Ff96E7CDMsbGNN0HDFCMUdkqHTCMNk+K1Rkkyfhe5YBf1\nTyEDkmmTE4kv3rECMhDxNEiqq+LVd9+Usj8SGe8vVyr00D8NnQ8N3EgQQ3G4S+Xl\nHTp1s1xNAgMBAAECggEAKrnKTNGWJELv+KMMIFVqSFGRezfc8kE/6Bp0iG5XqKM7\nE2m6Swiezu0KCU87wa8zaS0zH+/Rpe2zmc2TtYiUC3kaV6mORMTbmk/2zbRXx7XQ\n/Jt06jy28OAtqHeVl+dv03ir4XHSsVrsg9nufsqlmLTXWxC0TDnQYNE3hQdFH81m\ntc+qRu8caX2UrXY2kSF4d6D/okn9XuUfzBgnEcCh8Gg5NxWzD8AmyOKPX+mWpA+t\n0xOddnr2KyNOTyrRrWihu4+Voct+OrabD6Su8pLflSCGWa8AoiylR4xGs6ejzyf5\n4VE2xFfGEdpuYV7txWMF6kpvGKdsu4UoV8gPwBvS4wKBgQDkUpANvrilMBn7SLAG\n/TocXjkyRsTbM1uUGpxiM2SR1IN2EACCNmG7LY0CzMc1yJFL8TEC8qJ3kJDD840N\nJ8J3JKcEroFi9259RqKOWmZlqR+ukLZmrSw55sz/WL564eJDTkS3WixhzCHT1c/d\nWoB/OgeB+3gUfeTe9ueSzYNd9wKBgQDOqjgDpzFXcf2Q+iHX1X3R56TYuD2tNrhw\n4gCyfB68w+S2nEEE0PGiAzNjB3TgrNjbDUjXibx8/rGw97Ug/8F560/NDp9fnJyq\n+2L2wSvpWxmvoUQsnrFn/F190E7eE2MJ1JPMbfuVKZFUMTihMN6cStSsrzrY7X5x\nz/Zz5QdW2wKBgQCTYpxs0v2cXFWZOQ2wJUyavVQMmVQ/74IhM6BZX7V+0YDe+Gtr\norEpw7iv4wKBPGxWamZp8bhgmChq5U/a+xx0DmvmAMOy3+gp5CvQ2pgY7bhu1il4\nVDclVVBlUKL87c1CB0ciWIonwz7e4LliuSYTeqEYDf0wtSfFqfpIcHNpdwKBgQCo\nUCuklgNyg40PCRiNDvwU+0LfmlXo/3sBvJ7yvnHOLQDV1LaDdKSG3XJ5gbYn0b4f\n0Vb06+GOL2SKi4OCJ6nsYMAycmlMVmGmQ2zbKIJZ4G8wAfhjGq/Dz95YvFGvPjzX\n4cCpqx1N43fQCPJlHUcAJVXGekRELlBf4w6GXw42JwKBgQCKPOLjlcyQlG9X4pX/\neplNtqeBs2JNK05GeI70tpZsH4lP5ouWNpVj4soQXDfntwYuCBUkJU9tU1xfmBG8\nEaJ7YEC8nUsHtyA9iA0rEjn9LkynU8MNE+Cqgat36O6aRhg1lTjl/jJDUii1KQ9/\nieBg2aTNtuRuPn0FMrT0vaeeOA==\n-----END PRIVATE KEY-----\n",
      "client_email":
          "firebase-adminsdk-4af3u@spree-bpgc.iam.gserviceaccount.com",
      "client_id": "105438423972917864141",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-4af3u%40spree-bpgc.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };

    final credentials = await obtainAccessCredentialsViaServiceAccount(
        auth.ServiceAccountCredentials.fromJson(serviceAccountJson),
        SCOPES,
        http.Client());

    final client = authenticatedClient(http.Client(), credentials);

    final response = await client.get(
      Uri.parse(
          'https://www.googleapis.com/oauth2/v1/tokeninfo?access_token=${credentials.accessToken.data}'),
    );

    if (response.statusCode == 200) {
      return credentials.accessToken.data;
    }
    return 'FCM service account error';
  }
}
