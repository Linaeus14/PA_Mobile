part of './widget.dart';

class ButtonPrimary extends StatelessWidget {
  final void Function() _onPressed;
  final String _text;
  final double _width;
  final double _height;
  const ButtonPrimary(
      {super.key,
      required String text,
      required double mediaQueryWidth,
      required double mediaQueryHeight,
      required void Function() onPressed})
      : _onPressed = onPressed,
        _text = text,
        _width = mediaQueryWidth,
        _height = mediaQueryHeight;

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: scheme.primary,
            foregroundColor: scheme.onPrimary,
            shadowColor: scheme.surfaceVariant,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            minimumSize: Size(8 * _width / 10, _height / 10), //////// HERE
          ),
          onPressed: _onPressed,
          child: Text(
            _text,
          )),
    );
  }
}
