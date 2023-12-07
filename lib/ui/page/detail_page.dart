part of './page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.plant});

  final PlantClass? plant;

  @override
  Widget build(BuildContext context) {
    List<String> datas = [
      plant!.nama!,
      plant!.sNama?.join(", ") ?? "None",
      plant!.sinonim?.join(", ") ?? "None",
      plant!.sunlight?.join(", ") ?? "None",
      plant!.watering ?? "none"
    ];
    List<String> labels = [
      "Other(s) name(s)",
      "Sunlight(s)",
      "Watering",
    ];
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height / 2.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: _tryImageUrl(plant!.image),
                    fit: _imageUrlInvalid(plant!.image)
                        ? BoxFit.fitHeight
                        : BoxFit.cover)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(9.0),
                margin: const EdgeInsets.only(top: 40, bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  color: scheme.surfaceVariant.withOpacity(0.6),
                ),
                child: Text(
                  plant!.nama!,
                  style: textTheme.titleLarge,
                ),
              ),
              Container(
                constraints: BoxConstraints(minHeight: height / 1.6),
                width: width,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: scheme.surfaceVariant,
                ),
                child: Column(
                  children: [
                    Container(
                      width: width / 4,
                      height: height / 20,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          border:
                              Border.all(color: scheme.primary, width: 1.25)),
                      child: Center(
                          child: Text("Detail", style: textTheme.titleMedium)),
                    ),
                    Container(
                      width: width / 1.2,
                      height: height / 2.5,
                      padding: const EdgeInsets.all(8.0),
                      margin: const EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(24)),
                          border:
                              Border.all(color: scheme.primary, width: 1.25)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            labels.length,
                            (index) => SizedBox(
                                  width: width / 1.5,
                                  height: height / 8,
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              color: scheme.primaryContainer),
                                          width: width / 4,
                                          child: Text(
                                            labels[index],
                                            style: textTheme.titleSmall,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Container(
                                          height: 1.5,
                                          width: width / 4.5,
                                          color: scheme.primary,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            datas[index + 2],
                                            style: textTheme.bodyMedium,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(top: 10, left: 14, right: 14),
                      padding: const EdgeInsets.all(8.0),
                      width: width,
                      height: height / 14,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: scheme.primary,
                          foregroundColor: scheme.onPrimary,
                          disabledBackgroundColor: Colors.transparent,
                          textStyle: textTheme.bodyLarge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: const Text("Back"),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
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
