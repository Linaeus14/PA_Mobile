part of './widget.dart';

class ButtonSecondary extends StatelessWidget {
  final String _text;
  final double _width;
  final double _height;
  final void Function() _onPressed;
  const ButtonSecondary(
      {super.key,
      required String text,
      required double mediaQueryWidth,
      required double mediaQueryHeight,
      required onPressed})
      : _onPressed = onPressed,
        _text = text,
        _width = mediaQueryWidth,
        _height = mediaQueryHeight;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            side: BorderSide(width: 1.5, color: scheme.primary),
            minimumSize: Size(8 * _width / 10, _height / 10), //////// HERE
          ),
          onPressed: _onPressed,
          child: Text(
            _text,
          )),
    );
  }
}
