import 'package:flutter/material.dart';

class EmptySpace extends StatelessWidget {
  const EmptySpace({
    super.key,
    required this.space,
  });
  final double space;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: space,
    );
  }
}
