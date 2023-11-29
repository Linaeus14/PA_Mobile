part of './widget.dart';

class PlantList extends StatefulWidget {
  const PlantList({
    Key? key,
  }) : super(key: key);

  @override
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  List<PlantClass> allPlants = [];
  int currentPage = 1;
  bool isLoading = false;

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
    return RefreshIndicator(
      onRefresh: () async {
        currentPage = 1;
        allPlants.clear();
        await _loadData();
      },
      child: ListView.builder(
        controller: _scrollController,
        itemCount: allPlants.length + (isLoading ? 1 : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index == allPlants.length) {
            // Loading indicator
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: width / 10, child: const CircularProgressIndicator()),
            );
          }
          PlantClass plant = allPlants[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlantTile(
              plant: plant,
              isOn: false,
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }

  Future<void> _loadData() async {
    try {
      List<PlantClass> plants = await Api.futureData(page: currentPage);
      setState(() {
        allPlants.addAll(plants);
        currentPage++;
      });
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
  }

  Future<void> _loadMoreData() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      try {
        List<PlantClass> newPlants = await Api.futureData(page: currentPage);
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
