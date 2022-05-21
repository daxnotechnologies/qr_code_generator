import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_generator/models/signin_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:qr_code_generator/apis/base_url.dart';

import '../theme.dart';
import '../widgets.dart';

class AppAPIs {
  Future signUp(var context,
      firstName, lastName, email, password, gender, dob, contact) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/signup'));
    request.body = json.encode({
      "firstName": firstName, // "Mukhtar",
      "lastName": lastName, // "Abbas",
      "email": email, // "muktarabbas4445@gmail.com",
      "password": password, // "mukhtar1234",
      "gender": gender, // "Male",
      "dob": dob, // "12-12-1999",
      "contact": contact, // "03331751075"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if ( response.statusCode ==200) {
      var res = await response.stream.bytesToString();
      var jsons=json.decode(res);
      print(res);
      if(jsons['message']==true){
      print(res);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: QRTheme.mainColor,
          content: socialButton(
            context,
            'Signup Successfull',
            QRTheme.mainColor,
                () {},
          ),
        ),
      );
      return true;}else if(jsons['error']=='User already exists.'){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: QRTheme.googleColor,
            content: socialButton(
              context,
              'User Already Exist',
              QRTheme.googleColor,
                  () {},
            ),
          ),
        );
        return false;
      }
      else{return false;}
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future signIn(email, password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/login'));
    request.body = json.encode({
      "email": email,
      "password": password,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 201) {
      // response.statusCode == 200 ||
      var res = await response.stream.bytesToString();
      var jsons=json.decode(res);
      if(jsons['message']==true){
      print(res);
      sp.setString('userDetails', res);
      sp.setBool('isSignedIn', true);
      return true;
      }
      // SignInResponse signInResponse = SignInResponse.fromJson(jsonDecode(res));
      return false;
    } else {
      var res = await response.stream.bytesToString();
      print(res);
      print(response.statusCode);
      print(response.reasonPhrase);
      return false;
    }
  }

  Future forgotPassword(email, password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/forgotPass'));
    request.body = json.encode({
      "email": email, // "muktarabbas4445@gmail.com",
      "password": password, // "mukhtar1234",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var res = await response.stream.bytesToString();
      var jsons = json.decode(res);
      print(res);
      return jsons;
    } else {
      print(response.reasonPhrase);
    }
  }


  Future reset(email, password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/reset'));
    request.body = json.encode({
      "email": email, // "muktarabbas4445@gmail.com",
      "pass": password, // "mukhtar1234",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print(res);
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future editUser(firstName, lastName, dob, contact, email, password, gender) async {
    var uid;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString('userDetails') != null) {
      var user = sp.getString('userDetails');
      SignInResponse signInResponse =
          SignInResponse.fromJson(jsonDecode(user!));
      uid = signInResponse.user!.sId;
    }
  

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/editUser'));
    request.body = json.encode({
      "user": uid,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password" : password,
      "gender" : gender,
      "contact": contact,
      "dob": dob,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future deleteUser(uid) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('DELETE', Uri.parse('$baseUrl/user/deleteUser'));
    request.body = json.encode({
      "uid": uid, // "62139d0ff3fa02001655f906",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future createMenu(resturantName, address, city, contact, name, items,
      headerImg, backgroundImg, uid) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/createMenu'));
    request.body = json.encode({
      "resturantName": resturantName,
      "address": address,
      "city": city,
      "contact": contact,
      "name": name,
      "items": items,
      "headerImg": headerImg,
      "backgroundImg": backgroundImg,
      "uid": uid,
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 201) {
      var res = await response.stream.bytesToString();
      Map values = jsonDecode(res);
      print("API Response");
      print(values);

      return values;
    } else {
      print(response.reasonPhrase);
      Map values = {
        "message" : false
      };
      return values;
    }
  }

  Future editMenu(resturantName, address, city, contact, name, items, headerImg,
      backgroundImg, mid) async {
    var uid = '62139d0ff3fa02001655f906';
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/editMenu'));
    request.body = json.encode({
      "resturantName": resturantName, // "Chaghi",
      "address": address, // "Jail Road FSD",
      "city": city, // "Faisalabad",
      "contact": contact, //"090078601",
      "name": name, // "Mukhtar",
      "items": items, //[],
      "headerImg": headerImg,
      "backgroundImg": backgroundImg,
      "uid": uid, // "62139d0ff3fa02001655f906"
      "mid": mid, // "62139d0ff3fa02001655f906"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteMenu(mid) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('DELETE', Uri.parse('$baseUrl/user/deleteMenu'));
    request.body = json.encode({
      "mid": mid, // "62139d0ff3fa02001655f906"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getUserMenus() async {
    var uid;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString('userDetails') != null) {
      var user = sp.getString('userDetails');
      SignInResponse signInResponse =
          SignInResponse.fromJson(jsonDecode(user!));
      uid = signInResponse.user!.sId;
    }
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/userMenus'));
    request.body = json.encode({
      "uid": uid, // "62139d0ff3fa02001655f906",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getMenu(mid) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/getMenu'));
    request.body = json.encode({"mid": mid});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var res = await response.stream.bytesToString();
      print(res);
      // Menu menu = Menu.fromJson(jsonDecode(res));
      return res; //jsonDecode(res);
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future createSurvey(name, address, city, description, image, user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/createSurvey'));
    request.body = json.encode({
      "name": name, // "Chaghi",
      "address": address, // "Jail Road FSD",
      "city": city, // "Faisalabad",
      "description": description, //"Chaghi is the best restaurant",
      "image": image,
      // "https://lh3.googleusercontent.com/a-/AOh14GjEvLkj-QYx0Ecjhpxi7UDVyrybCk3hRxpkI4JU=s64",
      "user": user, // "62139d0ff3fa02001655f906"
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var res = await response.stream.bytesToString();
      print(res);
      return true;
    } else {
      print(response.reasonPhrase);
      return false;
    }
  }

  Future editSurvey(sid, name, address, city, description, image, user) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/editSurvey'));
    request.body = json.encode({
      "sid": sid, // "62139d0ff3fa02001655f906",
      "name": name, // "Chaghi",
      "address": address, // "Jail Road FSD",
      "city": city, // "Faisalabad",
      "description": description, //"Chaghi is the best restaurant",
      "image": image,
      // "https://lh3.googleusercontent.com/a-/AOh14GjEvLkj-QYx0Ecjhpxi7UDVyrybCk3hRxpkI4JU=s64",
      "user": user, // "62139d0ff3fa02001655f906"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future deleteSurvey(sid) async {
    var headers = {'Content-Type': 'application/json'};
    var request =
        http.Request('DELETE', Uri.parse('$baseUrl/user/deleteSurvey'));
    request.body = json.encode({
      "sid": sid, // "62139d0ff3fa02001655f906",
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getUserSurveys() async {
    var uid;
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.getString('userDetails') != null) {
      var user = sp.getString('userDetails');
      SignInResponse signInResponse =
          SignInResponse.fromJson(jsonDecode(user!));
      uid = signInResponse.user!.sId;
    }
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/userSurveys'));
    request.body = json.encode({
      "uid": uid,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 201) {
      var res = await response.stream.bytesToString();
      print(res);
      return res;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

  Future getSurvey(sid) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse('$baseUrl/user/getSurvey'));
    request.body = json.encode({
      "sid": sid,
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var res = await response.stream.bytesToString();
      print(res);
      return res;
    } else {
      print(response.reasonPhrase);
      return null;
    }
  }

// ////

  Future login(email, password) async {
    print('in login body');
    final response = await http.post(
      Uri.parse('$baseUrl/user/login'),
      body: {
        "email": email, // "muktarabbas4445@gmail.com",
        "password": password, // "mukhtar1234",
      },
    );
    if (response.statusCode == 200) {
      print(response.body);
      print(response.statusCode);
      return true;
    } else {
      print(response.body);
      print(response.statusCode);
      return false;
    }
  }
}
