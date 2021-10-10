import 'package:shared_preferences/shared_preferences.dart';

class LocalData {
  Future<void> savePassword(String password) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('password', password);
  }

  Future<String?> getPassword() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('password');
  }

  Future<bool?> isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('isLogin');
  }

  Future<void> setIsLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('isLogin', true);
  }

  Future<void> saveEmail(String email) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('email', email);
  }

  Future<String?> getEmail() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('email');
  }

  Future<void> saveImage(String image) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('image', image);
  }

  Future<String?> getImage() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('image');
  }

  Future<void> saveFirstName(String firstname) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('firstname', firstname);
  }

  Future<String?> getFirstName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('firstname');
  }

  Future<void> saveLastName(String lastname) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('lastname', lastname);
  }

  Future<String?> getLastName() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('lastname');
  }

  Future<void> saveToken(String token) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('token');
  }

  Future<void> savePhone(String phone) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('phone', phone);
  }

  Future<String?> getPhone() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('phone');
  }

  Future<void> saveGender(String gender) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('gender', gender);
  }

  Future<String?> getGender() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString('gender');
  }


  Future<void> logOut() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}