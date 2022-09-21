import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  RxBool isLightTheme = true.obs;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();


  @override
  void onInit() {
    super.onInit();
    getTheme();
  }

  getTheme()async{
    SharedPreferences pref = await _prefs;
    isLightTheme.value = (pref.getBool("theme"))!;
  }

  lightTheme(){
    isLightTheme.value = !isLightTheme.value;
  }

  saveThemeStatus() async {
    SharedPreferences pref = await _prefs;
    pref.setBool('theme', isLightTheme.value);
  }
}
