import 'package:flutter/material.dart';

class Workon extends StatelessWidget {
  List<int> testList = [0, 1, 2];

  Workon({Key? key}) : super(key: key);

//TODO figure out how to center
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: getProjectListTiles()),
    );
  }
}

List<ListTile> getProjectListTiles() {
  List<ListTile> projectListTiles = [];
  List<int> intList = [3, 2, 1, 0];
  for (var i in intList) {
    projectListTiles.add(ListTile(
        title: Text(
      i.toString(),
      textAlign: TextAlign.center,
    )));
  }
  return projectListTiles;
}
