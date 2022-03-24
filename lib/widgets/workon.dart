import 'package:custom_panel/data/projects.dart';
import 'package:flutter/material.dart';

class Workon extends StatelessWidget {
  final bool shouldUseDockerCompose;
  const Workon(this.shouldUseDockerCompose, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        children: _getProjectListTiles());
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
