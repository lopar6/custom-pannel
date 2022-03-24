import 'dart:ffi';

import 'package:custom_panel/data/projects.dart';
import 'package:custom_panel/models/project.dart';
import 'package:flutter/material.dart';

class Workon extends StatelessWidget {
  List<int> testList = [0, 1, 2];
  late bool shouldUseDockerCompose;

  Workon(this.shouldUseDockerCompose, {Key? key}) : super(key: key);

//TODO figure out how to center
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          children: _getProjectListTiles()),
    );
  }

  List<ListTile> _getProjectListTiles() {
    List<ListTile> projectListTiles = [];
    for (var project in PROJECTS) {
      projectListTiles.add(ListTile(
        title: ElevatedButton(
            onPressed: () => project.open(shouldUseDockerCompose),
            child: Text(
              project.label,
              textAlign: TextAlign.center,
            )),
      ));
    }
    return projectListTiles;
  }
}
