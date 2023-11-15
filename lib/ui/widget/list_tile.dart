part of './widget.dart';

class PlantList extends StatefulWidget {
  final double _width;
  final double _height;
  const PlantList(
      {super.key,
      required double mediaQueryWidth,
      required double mediaQueryHeight})
      : _width = mediaQueryWidth,
        _height = mediaQueryHeight;

  @override
  State<PlantList> createState() => _PlantListState();
}

class _PlantListState extends State<PlantList> {
  List<bool> favorite = List.generate(10, (index) => false);
  double get _width => widget._width;
  double get _height => widget._height;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Material(
                    elevation: 5,
                    shadowColor: Colors.black45,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      leading: Container(
                        width: 5 * _width / 20,
                        height: 2 * _height / 10,
                        alignment: Alignment.center,
                        child: const Icon(Icons.image_outlined),
                      ),
                      title: const Text("Title"),
                      subtitle: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Category1, Category2"),
                          Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          favorite[index]
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart_solid,
                          color: favorite[index] ? Colors.red : null,
                        ),
                        onPressed: () => setState(() => favorite[index]
                            ? favorite[index] = false
                            : favorite[index] = true),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
