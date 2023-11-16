part of './page.dart';

class FavoritePage extends StatelessWidget {
  final double _width;
  final double _height;
  const FavoritePage(
      {super.key,
      required double mediaQueryWidth,
      required double mediaQueryHeight})
      : _width = mediaQueryWidth,
        _height = mediaQueryHeight;

  @override
  Widget build(BuildContext context) {
    PlantData plantData = Provider.of<PlantData>(context);
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SearchField(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: _width,
            height: _height -218,
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PlantTile(
                      width: _width,
                      height: _height,
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
