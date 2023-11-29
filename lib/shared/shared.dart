import 'package:shared_preferences/shared_preferences.dart';

class Shared {
  late SharedPreferences file;

  Future<void> open() async {
    file = await SharedPreferences.getInstance();
  }
}
