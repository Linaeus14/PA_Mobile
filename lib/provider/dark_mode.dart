part of './provider.dart';

class DarkMode with ChangeNotifier {
  static final List<ThemeMode> _modes = [ThemeMode.light, ThemeMode.dark];
  static bool _isDark = true;
  ThemeMode _active = ThemeMode.system;

  static Future<ThemeMode> _get({required Shared shared}) async {
    final int? cachedData = shared.file.getInt("themeModeCache");
    if (cachedData != null) {
      cachedData == 0 ? _isDark = false : _isDark = true;
      return _modes[cachedData];
    }
    shared.file.setInt("themeModeCache", 1);
    return _modes[1];
  }

  Future<void> getThemeMode() async {
    final shared = Shared();
    await shared.open();
    _active = await _get(shared: shared);
    notifyListeners();
  }

  void changeMode(int newIndex) async {
    final shared = Shared();
    await shared.open();
    shared.file.setInt("themeModeCache", newIndex);

    _active = _modes[newIndex];
    notifyListeners();
  }

  ThemeMode get active => _active;
  bool get isDark => _isDark;
}
