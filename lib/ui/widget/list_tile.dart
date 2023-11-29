part of './widget.dart';

class PlantTile extends StatelessWidget {
  const PlantTile(
      {super.key,
      required double width,
      required double height,
      required this.favorite,
      required this.index,
      required this.onPressed})
      : _width = width,
        _height = height;

  final double _width;
  final double _height;
  final List<bool> favorite;
  final int index;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
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
              onPressed: () => onPressed)),
    );
  }
}
