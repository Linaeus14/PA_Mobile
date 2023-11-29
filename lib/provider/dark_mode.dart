part of './provider.dart';

class DarkMode with ChangeNotifier {
  static final List<ThemeMode> _modes = [
    ThemeMode.system,
    ThemeMode.light,
    ThemeMode.dark
  ];
  final List<bool> _isSelected = [true, false, false];
  UnmodifiableListView<bool> get isSelected =>
      UnmodifiableListView(_isSelected);

  static Future<ThemeMode> _get({required Shared shared}) async {
    final int? cachedData = shared.file.getInt("themeModeCache");
    if (cachedData != null) {
      return _modes[cachedData];
    }
    shared.file.setInt("themeModeCache", 0);
    return _modes[0];
  }

  Future<ThemeMode> themeMode({int page = 1}) async {
    final shared = Shared();
    await shared.open();
    return await _get(shared: shared);
  }

  void changeMode(int newIndex) async {
    for (int index = 0; index < _isSelected.length; index++) {
      if (index == newIndex) {
        _isSelected[index] = true;
        final shared = Shared();
        await shared.open();
        shared.file.setInt("themeModeCache", newIndex);
      } else {
        _isSelected[index] = false;
      }
    }
    notifyListeners();
  }
}
