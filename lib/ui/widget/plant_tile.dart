part of './widget.dart';

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
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Material(
      elevation: 5,
      shadowColor: colorScheme.onBackground,
      child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: Container(
            width: width / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                image: DecorationImage(
                    image: _tryImageUrl(plant.image),
                    fit: _imageUrlInvalid(plant.image)
                        ? BoxFit.fitHeight
                        : BoxFit.cover)),
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

  ImageProvider<Object> _tryImageUrl(String? url) {
    if (url != null && url.isNotEmpty) {
      try {
        return NetworkImage("https://images.weserv.nl/?url=$url");
      } catch (e) {
        // In case of an error, return a placeholder image
        return const AssetImage("null_image.png");
      }
    } else {
      // If the URL is null or empty, return a placeholder image
      return const AssetImage("null_image.png");
    }
  }

  bool _imageUrlInvalid(String? url) {
    if (url != null && url.isNotEmpty) {
      try {
        NetworkImage("https://images.weserv.nl/?url=$url");
        return false;
      } catch (e) {
        return true;
      }
    } else {
      return true;
    }
  }
}
