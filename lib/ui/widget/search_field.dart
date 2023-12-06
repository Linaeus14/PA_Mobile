part of './widget.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.onSubmitted});

  final void Function(String)? onSubmitted;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        // Add padding around the search bar
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        // Use a Material design search bar
        child: TextField(
          controller: _searchController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              filled: true,
              fillColor: scheme.surfaceVariant,
              hintText: 'Search Plant...',
              // Add a clear button to the search bar
              suffixIcon: _searchController.value.text.isEmpty
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () =>
                            setState(() => _searchController.clear()),
                      ),
                    ),
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(
                      color: scheme.primary, style: BorderStyle.solid))),
          onChanged: (text) => setState(() => _searchController),
          onSubmitted: widget.onSubmitted,
        ),
      ),
    );
  }
}
