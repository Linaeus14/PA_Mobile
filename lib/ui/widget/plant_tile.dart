part of './widget.dart';

class PlantTile extends StatelessWidget {
  final PlantClass plant;
  final bool isOn;
  final VoidCallback onFavPressed;
  final VoidCallback onTap;

  const PlantTile(
      {super.key,
      required this.plant,
      required this.isOn,
      required this.onFavPressed,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return InkWell(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(15.0),
        ),
        child: Material(
          elevation: 5,
          shadowColor: colorScheme.onBackground,
          color: colorScheme.background,
          child: ListTile(
              onTap: () {
                onTap();
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0.01, color: colorScheme.primary),
                  borderRadius: const BorderRadius.all(Radius.circular(15))),
              contentPadding: const EdgeInsets.all(8.0),
              leading: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: width / 5.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                          image: _tryImageUrl(plant.image),
                          fit: _imageUrlInvalid(plant.image)
                              ? BoxFit.fitHeight
                              : BoxFit.cover)),
                ),
              ),
              title: Text(
                plant.nama!,
                style: textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    plant.sNama!.join(", "),
                    style: textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    plant.cycle!,
                    style: textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
              trailing: Provider.of<UserData>(context).id == null
                  ? null
                  : IconButton(
                      icon: Icon(
                        isOn
                            ? CupertinoIcons.heart_fill
                            : CupertinoIcons.heart_solid,
                        color: isOn ? Colors.red : null,
                      ),
                      onPressed: () => onFavPressed())),
        ),
      ),
    );
  }

  ImageProvider<Object> _tryImageUrl(String? url) {
    if (url != null && url.isNotEmpty) {
      try {
        return NetworkImage("https://images.weserv.nl/?url=$url");
      } catch (e) {
        // In case of an error, return a placeholder image
        return const AssetImage("assets/null_image.png");
      }
    } else {
      // If the URL is null or empty, return a placeholder image
      return const AssetImage("assets/null_image.png");
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
