import 'package:flutter/material.dart';

class ScreenTile extends StatelessWidget {
  const ScreenTile({Key? key, required this.title, required this.where})
      : super(key: key);
  final String title;
  final Widget where;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => where)),
      child: Container(
        padding: const EdgeInsets.only(left: 10, top: 10, bottom: 5, right: 5),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline4,
        ),
      ),
    );
  }
}