
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  RxBool _isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode.value;

  void _loadTheme() {
    _isDarkMode.value = _storage.read('isDarkMode') ?? false;
  }

  void toggleTheme() {
    _isDarkMode.value = !_isDarkMode.value;
    _storage.write('isDarkMode', _isDarkMode.value);
  }
}
