import 'package:flutter/material.dart';

class UrlInputWidget extends StatefulWidget {
  final String url;
  final ValueChanged<String> onUrlChanged;
  final VoidCallback onImport;
  final bool isLoading;
  final String? error;

  const UrlInputWidget({
    super.key,
    required this.url,
    required this.onUrlChanged,
    required this.onImport,
    required this.isLoading,
    required this.error,
  });

  @override
  State<UrlInputWidget> createState() => _UrlInputWidgetState();
}

class _UrlInputWidgetState extends State<UrlInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Chess.com URL',
            hintText: 'https://www.chess.com/live/...',
            prefixIcon: const Icon(Icons.link),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            errorText: widget.error,
          ),
          onChanged: widget.onUrlChanged,
          controller: TextEditingController(text: widget.url),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: widget.isLoading ? null : widget.onImport,
          icon: widget.isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
              : const Icon(Icons.download),
          label: Text(widget.isLoading ? 'Fetching...' : 'Import Game'),
        ),
      ],
    );
  }
}
