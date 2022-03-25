import 'package:custom_panel/data/projects.dart';
import 'package:flutter/material.dart';

class Workon extends StatelessWidget {
  final bool shouldUseDockerCompose;
  const Workon(this.shouldUseDockerCompose, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: _getProjectListTiles(), mainAxisSize: MainAxisSize.min);
  }

  List<Widget> _getProjectListTiles() {
    List<Widget> projectListTiles = [];
    for (var project in PROJECTS) {
      projectListTiles.add(Column(children: [
        ElevatedButton(
            onPressed: () => project.open(shouldUseDockerCompose),
            child: Text(
              project.label,
              textAlign: TextAlign.center,
            )),
        const SizedBox(
          height: 10,
        )
      ]));
    }
    return projectListTiles;
  }
}
