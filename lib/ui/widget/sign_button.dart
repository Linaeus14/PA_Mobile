part of './widget.dart';

class SignButton extends StatefulWidget {
  const SignButton({
    super.key,
    this.signInButton = true,
    required this.onPressed,
    this.hideBottom = false,
  });

  final bool signInButton;
  final bool hideBottom;
  final VoidCallback onPressed;

  @override
  State<SignButton> createState() => _SignButtonState();
}

class _SignButtonState extends State<SignButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width,
              height: height / 20,
              child: ElevatedButton(
                onPressed: _isLoading ? null : () => _handlePressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: scheme.primary,
                  foregroundColor: scheme.onPrimary,
                  textStyle: textTheme.bodyLarge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          scheme.onPrimary,
                        ),
                      )
                    : Text(
                        widget.signInButton ? 'Sign In' : 'Sign Up',
                      ),
              ),
            ),
          ),
          widget.hideBottom
              ? const Padding(padding: EdgeInsets.all(8.0))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: widget.signInButton
                                ? "Don't have an account? "
                                : 'Have an Account? ',
                            style: textTheme.bodySmall),
                        TextSpan(
                          text: widget.signInButton ? 'Sign Up' : 'Sign In',
                          style: TextStyle(
                            color: scheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pop(context);
                              widget.signInButton
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignUp()))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignIn()));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Future<void> _handlePressed() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));
    widget.onPressed();
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      _isLoading = false;
    });
  }
}
