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
  String searchKey = "";
  bool limitreached = false;
  bool noMoreData = false;
  bool isSearching = false;

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _load();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !noMoreData) {
        // User reached the bottom, load more data
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    UserData userData = Provider.of<UserData>(context, listen: false);
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
                SearchField(
                  controller: _searchController,
                  onSubmitted: (value) {
                    if (_searchController.text.isNotEmpty) {
                      setState(() {
                        currentPage = 1;
                        isSearching = true;
                        allPlants.clear();
                        searchKey = _searchController.text;
                        _loadMore();
                      });
                    }
                  },
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
                Visibility(
                    visible: isSearching,
                    child: Container(
                      width: width / 1.15,
                      height: height / 18,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                          color: scheme.surfaceVariant),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Searched : $searchKey",
                              style: textTheme.bodySmall,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  currentPage = 1;
                                  _searchController.clear();
                                  isSearching = false;
                                  allPlants.clear();
                                  _load();
                                });
                              },
                              icon: const Icon(Icons.cancel))
                        ],
                      ),
                    ))
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
                height: height / 1.6,
                child: RefreshIndicator(
                  onRefresh: () async {
                    Shared cache = Shared();
                    await cache.file.clear();
                    setState(() {
                      allPlants.clear();
                      _load();
                    });
                  },
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: allPlants.length + 1, // +1 for loading indicator
                    itemBuilder: (BuildContext context, int index) {
                      if (index == allPlants.length && !limitreached) {
                        return Center(
                          child: noMoreData
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'No More Data.',
                                    style:
                                        textTheme.bodySmall,
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      width / 2 - 40, 8, width / 2 - 40, 8),
                                  child: const CircularProgressIndicator(),
                                ),
                        );
                      } else if (limitreached) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'API RateLimit Surpassed, try again after 24 hours passed',
                              style: textTheme.bodySmall,
                            ),
                          ),
                        );
                      } else {
                        PlantClass plant = allPlants[index];
                        bool isFavorite = false;
                        if (userData.id != null) {
                          isFavorite = userData.data!.favorite
                              .contains(plant.id.toString());
                        }

                        return Padding(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 4.0),
                          child: PlantTile(
                            plant: plant,
                            isOn: isFavorite,
                            onPressed: () async {
                              if (userData.id != null) {
                                setState(() {
                                  if (!isFavorite) {
                                    userData.data!.favorite
                                        .add(plant.id.toString());
                                  } else {
                                    userData.data!.favorite
                                        .remove(plant.id.toString());
                                  }
                                });
                                await userData.updateField(
                                    'favorite', userData.data!.favorite);
                              }
                            },
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
      noMoreData = false;
      currentPage = 1;
      _scrollController.jumpTo(0.0);
      allPlants.clear();
    });
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
        allPlants.clear();
      });
    }
  }

  Future<void> _loadMoreData() async {
    try {
      List<PlantClass> newPlants =
          await Api.futureData(page: currentPage, index: _toogleIndex);
      setState(() {
        allPlants.addAll(newPlants);
        currentPage++;
      });
    } catch (e) {
      // Handle the error (e.g., show an error message)
      debugPrint('Error loading more data: $e');
      setState(() {
        noMoreData = true;
      });
    }
  }

  Future<void> _loadSearchData() async {
    try {
      List<PlantClass> plants = await Api.searchdata(
          page: currentPage,
          index: _toogleIndex,
          searchKey: _searchController.text);
      setState(() {
        allPlants.addAll(plants);
        currentPage++;
      });
    } catch (e) {
      debugPrint('Error loading data: $e');
      setState(() {
        limitreached = true;
        allPlants.clear();
      });
    }
  }

  Future<void> _loadMoreSearchData() async {
    try {
      List<PlantClass> newPlants = await Api.searchdata(
          page: currentPage,
          index: _toogleIndex,
          searchKey: _searchController.text);
      setState(() {
        allPlants.addAll(newPlants);
        currentPage++;
      });
    } catch (e) {
      // Handle the error (e.g., show an error message)
      debugPrint('Error loading more data: $e');
      setState(() {
        noMoreData = true;
      });
    }
  }

  void _load() {
    if (isSearching) {
      _loadSearchData();
    } else {
      _loadData();
    }
  }

  void _loadMore() {
    if (isSearching) {
      _loadMoreSearchData();
    } else {
      _loadMoreData();
    }
  }
}
