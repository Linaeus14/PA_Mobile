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

class PlantTile extends StatelessWidget {
  final PlantClass plant;
  final bool isOn;
  final VoidCallback onPressed;

  const PlantTile(
      {super.key,
      required this.plant,
      required this.isOn,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Material(
      elevation: 5,
      shadowColor: Colors.black45,
      child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Container(
            width: width / 4,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                    image: plant.image == null
                        ? const AssetImage("null_image.png")
                            as ImageProvider<Object>
                        : NetworkImage(
                            "https://images.weserv.nl/?url=${plant.image}"),
                    fit: plant.image == null ? BoxFit.fitHeight : BoxFit.cover)),
          ),
          title: Text(plant.nama!),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(plant.sNama!.join(", ")),
              Text(
                plant.cycle!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
          trailing: IconButton(
              icon: Icon(
                isOn ? CupertinoIcons.heart_fill : CupertinoIcons.heart_solid,
                color: isOn ? Colors.red : null,
              ),
              onPressed: () => onPressed)),
    );
  }
}
