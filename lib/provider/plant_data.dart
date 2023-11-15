part of './provider.dart';

class PlantData extends ChangeNotifier {
  static final Map<String, String> _categoriesMap = {
    "bryophyta": "Bryophyta",
    "hepatophyta": "Hepatophyta",
    "anthocerotophyta": "Anthocerotophyta",
    "equisetophyta": "Equisetophyta",
    "pteridophyta": "Pteridophyta",
    "coniferophyta": "Coniferophyta",
    "ginkgophyta": "Ginkgophyta",
    "angiosperms": "Angiosperms",
  };
  String _selectedCategory = _categoriesMap.keys.first;
  final List<bool> _caegoriesSelection =
      List.generate(_categoriesMap.length, (index) => false);
  final List<bool> _favorite = List.generate(10, (index) => false);

  Map<String, String> get categoriesMap => _categoriesMap;
  List<bool> get favorite => _favorite;
  List<bool> get selection => _caegoriesSelection;
  String get selectedCategory => _selectedCategory;
  int get categoriesLength => _categoriesMap.length;

  void toggle(int index) {
    _favorite[index] ? favorite[index] = false : favorite[index] = true;
    notifyListeners();
  }

  void onSelected(String typeKey) {
    _selectedCategory = typeKey;
    notifyListeners();
  }

  void togglefilter(int index) {
    for (var i = 0; i < categoriesLength; i++) {
      i == index ? selection[index] = true : selection[index] = true;
    }
    notifyListeners();
  }
}
