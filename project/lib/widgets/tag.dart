import 'package:flutter/material.dart';

enum Size { small, large }

/// Represents a tag which descibes a task.
class Tag extends StatelessWidget {
  /// The [size] of the tag og type .
  final Size size;

  /// The [color] of the tag.
  final Color color;

  /// [tagText] is the text in the tag.
  final String tagText;

  /// Creates an instance of [Tag].
  const Tag({
    super.key,
    required this.size,
    required this.color,
    required this.tagText,
  });

  @override
  Widget build(BuildContext context) {
    return size == Size.small
        ? ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 3.0,
                vertical: 1.5,
              ),
              decoration: BoxDecoration(
                color: color,
              ),
              child: Text(
                tagText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9.5,
                ),
              ),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 3.5,
              ),
              decoration: BoxDecoration(
                color: color,
              ),
              child: Text(
                tagText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          );
  }
}
