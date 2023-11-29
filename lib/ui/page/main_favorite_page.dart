part of './page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    PlantData plantData = Provider.of<PlantData>(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SearchField(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
          child: Container(
            width: width,
            height: height - 218,
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
          ),
        )
      ],
    );
  }
}
