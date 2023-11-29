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
