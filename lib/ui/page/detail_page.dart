part of './page.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Container(
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.primary,
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.all(24),
                  child: Text(
                    'Plant Name',
                    style: textTheme.headlineLarge,
                  ),
                ))
              ]),
              const SizedBox(height: 20),
              Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/logo.png"),
                  fit: BoxFit.cover,
                )),
              ),
              const SizedBox(height: 20),
              Container(
                constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 347),
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)),
                  color: scheme.primary,
                ),
                child: Text("DESKRIPSI",
                    textAlign: TextAlign.center, style: textTheme.bodyMedium),
              )
            ],
          ),
        ),
      ),
    );
  }
}
