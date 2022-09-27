import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String emptyText;
  const EmptyWidget(this.emptyText, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(emptyText),
    );
  }
}
