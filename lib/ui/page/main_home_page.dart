part of './page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static final Map<String, String> _categoriesMap = {
    "all": "All",
    "perennials": "Perennials",
    "annuals": "Annuals",
  };
  final List<bool> _selection =
      List.generate(_categoriesMap.length, (index) => index == 0);
  List<PlantClass> allPlants = [];

  int _toogleIndex = 0;
  int currentPage = 1;
  bool isLoading = false;
  bool limitreached = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // User reached the bottom, load more data
        _loadMoreData();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ColorScheme scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SearchField(),
                ),
                SizedBox(
                  width: width,
                  height: height / 20,
                  child: Center(
                    child: ToggleButtons(
                      color: scheme.primary,
                      borderColor: scheme.primary,
                      borderWidth: 0.5,
                      constraints: BoxConstraints(
                          minWidth: width / 3.5, minHeight: height / 20),
                      borderRadius: BorderRadius.circular(8.0),
                      fillColor: scheme.primary,
                      selectedColor: scheme.background,
                      isSelected: _selection,
                      children: _getTooglebuttons(_categoriesMap),
                      onPressed: (pressIndex) => _togglefilter(pressIndex),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Plants"),
              ),
              SizedBox(
                width: width,
                height: height / 1.5,
                child: RefreshIndicator(
                  onRefresh: () async {
                    currentPage = 1;
                    allPlants.clear();
                    await _loadData();
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: allPlants.length + 1, // +1 for loading indicator
                    itemBuilder: (BuildContext context, int index) {
                      if (index == allPlants.length && !limitreached) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                width / 2 - 40, 8, width / 2 - 40, 8),
                            child: const CircularProgressIndicator(),
                          ),
                        );
                      } else if (limitreached) {
                        return Center(
                          child: Text(
                            'API RateLimit Surpassed, try again after 24hours passed',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        );
                      } else {
                        PlantClass plant = allPlants[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PlantTile(
                            plant: plant,
                            isOn: false,
                            onPressed: () {},
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _getTooglebuttons(Map<String, String> categoriesMap) {
    List<Widget> widgets = [];
    for (int i = 0; i < categoriesMap.length; i++) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(_categoriesMap[_categoriesMap.keys.elementAt(i)]!),
      ));
    }
    return widgets;
  }

  void _togglefilter(int index) {
    setState(() {
      for (var i = 0; i < _categoriesMap.length; i++) {
        _selection[i] = (i == index);
      }
      _toogleIndex = index;
      limitreached = false;
    });
    allPlants.clear();
    currentPage = 1;
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      List<PlantClass> plants =
          await Api.futureData(page: currentPage, index: _toogleIndex);
      setState(() {
        allPlants.addAll(plants);
        currentPage++;
      });
    } catch (e) {
      debugPrint('Error loading data: $e');
      setState(() {
        limitreached = true;
      });
      allPlants.clear();
    }
  }

  Future<void> _loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        List<PlantClass> newPlants =
            await Api.futureData(page: currentPage, index: _toogleIndex);
        setState(() {
          allPlants.addAll(newPlants);
          currentPage++;
          isLoading = false;
        });
      } catch (e) {
        // Handle the error (e.g., show an error message)
        debugPrint('Error loading more data: $e');
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
