import 'package:flutter/material.dart';

/// A custom search bar widget.
///
/// This widget displays a search bar with a text field for input and a microphone icon for voice search.
class CustomSearchBar extends StatelessWidget {
  /// A controller for the text field in the search bar.
  final TextEditingController _controller = TextEditingController();

  /// Constructor for the CustomSearchBar widget.
  CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(23),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.search, color: Colors.grey, size: 32),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search your latest news...',
                  ),
                  style: const TextStyle(
                    color: Color(0xff08022B),
                  ),
                  onTap: () => _controller.clear(),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color(0xff08022B),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.mic,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: () {
                    // Handle voice search action
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
