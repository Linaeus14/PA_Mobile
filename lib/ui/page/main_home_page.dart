part of './page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
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
  late AnimationController _dragController;

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
    _dragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    _dragController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
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
                              Container(
                                margin: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                                padding: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: scheme.primary, width: 0.01),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15.0)),
                                    color: scheme.background),
                                child: Text(
                                  "Searched : $searchKey",
                                  style: textTheme.titleSmall,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    _clearSearch();
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Plants",
                      style: textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    width: width,
                    height: isSearching ? height / 1.7 : height / 1.52,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        // Handle the horizontal drag update
                        if (details.primaryDelta != null) {
                          double sensitivity = 8.0;
                          if (details.primaryDelta! > sensitivity) {
                            _draggedRight();
                          } else if (details.primaryDelta! < -sensitivity) {
                            _draggedLeft();
                          }
                        }
                      },
                      child:
                          _buildSlideTransition(), // Use the SlideTransition here
                    ),
                  ),
                ],
              )
            ]));
  }

  Tween<Offset> _buildTweenAnimation() {
    return Tween(begin: Offset.zero, end: const Offset(1.0, 0.0));
  }

  SlideTransition _buildSlideTransition() {
    double width = MediaQuery.of(context).size.width;
    TextTheme textTheme = Theme.of(context).textTheme;
    UserData userData = Provider.of<UserData>(context, listen: false);

    return SlideTransition(
      position: _buildTweenAnimation().animate(_dragController),
      child: RefreshIndicator(
        onRefresh: _refreshData,
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
                            style: textTheme.bodySmall,
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
                  isFavorite =
                      userData.data!.favorite.contains(plant.id.toString());
                }
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 4.0),
                  child: PlantTile(
                    plant: plant,
                    isOn: isFavorite,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPage(plant: plant)));
                    },
                    onFavPressed: () async {
                      if (userData.id != null) {
                        setState(() {
                          if (!isFavorite) {
                            userData.data!.favorite.add(plant.id.toString());
                          } else {
                            userData.data!.favorite.remove(plant.id.toString());
                          }
                        });
                        Shared cache = Shared();
                        await cache.open();
                        cache.file.remove('favorites');
                        await userData.updateField(
                            'favorite', userData.data!.favorite);
                      }
                    },
                  ),
                );
              }
            }),
      ),
    );
  }

  // Handle dragging to the right
  void _draggedRight() {
    if (_toogleIndex == 2) {
      _togglefilter(1);
    } else if (_toogleIndex == 1) {
      _togglefilter(0);
    }
  }

  // Handle dragging to the left
  void _draggedLeft() {
    if (_toogleIndex == 0) {
      _togglefilter(1);
    } else if (_toogleIndex == 1) {
      _togglefilter(2);
    }
  }

  void _clearSearch() {
    setState(() {
      currentPage = 1;
      _searchController.clear();
      _scrollController.jumpTo(0.0);
      isSearching = false;
      limitreached = false;
      noMoreData = false;
      allPlants.clear();
      _load();
    });
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
      _clearSearch();
    });
    _loadData();
  }

  Future<void> _refreshData() async {
    try {
      Shared cache = Shared();
      await cache.file.clear();
      setState(() {
        allPlants.clear();
        currentPage = 1;
        limitreached = false;
        noMoreData = false;
      });
      await _loadData();
    } catch (e) {
      debugPrint('Error refreshing data: $e');
    }
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
