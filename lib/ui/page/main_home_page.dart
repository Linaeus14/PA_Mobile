part of './page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    PlantData plantData = Provider.of<PlantData>(context);
    ColorScheme scheme = Theme.of(context).colorScheme;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SearchField(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("categories"),
              Container(
                width: width,
                height: height / 10,
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: plantData.categoriesLength,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ToggleButtons(
                        renderBorder: true,
                        color: scheme.primary,
                        borderColor: scheme.primary,
                        borderWidth: 1,
                        borderRadius: BorderRadius.circular(10),
                        fillColor: scheme.primary,
                        selectedColor: scheme.background,
                        isSelected: [plantData.selection[index]],
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                                plantData.categoriesMap[plantData
                                    .categoriesMap.keys
                                    .elementAt(index)]!,
                                style: const TextStyle(fontSize: 12)),
                          )
                        ],
                        onPressed: (pressIndex) {
                          () => plantData.togglefilter(pressIndex);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("Plants"),
              Container(
                width: width,
                height: height / 2 - 4,
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PlantTile(
                          width: width,
                          height: height,
                          favorite: plantData.favorite,
                          index: index,
                          onPressed: () => plantData.toggle(index),
                        ))),
              )
            ],
          ),
        )
      ],
    );
  }
}
