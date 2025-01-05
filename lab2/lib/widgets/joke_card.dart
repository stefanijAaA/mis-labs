import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String type;

  JokeCard({
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(type),
        onTap: () {
          Navigator.pushNamed(context, '/jokes', arguments: type);
        },
      ),
    );
  }
}