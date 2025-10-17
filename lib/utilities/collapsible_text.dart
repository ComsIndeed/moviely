import 'package:flutter/material.dart';

class CollapsibleText extends StatefulWidget {
  final String text;
  final int maxLines; // How many lines to show when collapsed

  const CollapsibleText({super.key, required this.text, this.maxLines = 3});

  @override
  State<CollapsibleText> createState() => _CollapsibleTextState();
}

class _CollapsibleTextState extends State<CollapsibleText> {
  bool _isExpanded = false;

  // This state is set in initState, used to check if truncation is even necessary
  bool _needsExpansion = false;

  @override
  void initState() {
    super.initState();
    // A quick way to estimate if the text is long enough to need a 'Show More' button
    // This is often handled better using a LayoutBuilder or GlobalKey,
    // but a simple character count is often enough for a simple utility:
    if (widget.text.length > 150) {
      _needsExpansion = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // --- 1. The Text Widget ---
        Text(
          widget.text,
          maxLines: _isExpanded ? 512 : widget.maxLines,
          overflow: TextOverflow.ellipsis,
        ),

        // --- 2. The Toggle Button (Only show if expansion is needed) ---
        if (_needsExpansion)
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? 'Show Less' : 'Show More',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
