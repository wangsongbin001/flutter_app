import 'package:shared_preferences/shared_preferences.dart';

class AppManager{
  static String userName;
  static const String KEY_USERNAME = "key_username";

  static SharedPreferences prefs = initApp();

  static initApp() async {
    prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(KEY_USERNAME);
  }

  static setUserName(String value) async{
    userName = value;
    await prefs.setString(KEY_USERNAME, userName);
  }

  static void clearUserInfo(){
    setUserName("");
  }

}

class UserMode{
  String userName;
  String userPwd;
  String token;
}