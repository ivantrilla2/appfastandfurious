// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:io';
import 'dart:async';

class FastAndFuriousCharacter {
  final String name;
  String? apiName;
  String? imageUrl;
  String? fullname;
  String? actorRealName;
  String? description;
  String? birth;
  String? gender;
  String? imageCarUrl;
  String? descriptionCar;
  String? imageLogoUrl;

  int rating = 10;

  FastAndFuriousCharacter(this.name);

  Future getImageUrl() async {
    if (imageUrl != null) {
      return;
    }

    HttpClient http = HttpClient();
    try {
      apiName = name;

      var uri = Uri.https('654a8ecc1f197d51e4926822.mockapi.io', '/api/fastandfurious/fast/$apiName');
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      Map<String, dynamic> data = json.decode(responseBody);
      fullname = data["name"];
      actorRealName = data["realName"];
      description = data["description"];
      imageUrl = data["icon"];
      birth = data["dateOfBirth"];
      gender = data["gender"];
      imageCarUrl = data["carIcon"];
      descriptionCar = data["descriptionCar"];
      imageLogoUrl = data["logo"];

      //print(description);
    } catch (exception) {
      //print(exception);
    }
  }
}