import 'package:custom_panel/data/projects.dart';
import 'package:flutter/material.dart';

class Workon extends StatefulWidget {
  const Workon({Key? key}) : super(key: key);

  @override
  State<Workon> createState() => _Workon();
}

class _Workon extends State<Workon> {
  bool useDockerCompose = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text("Open A Project:", textScaleFactor: 2),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Also Start Docker Containers?",
              textScaleFactor: .8,
            ),
            Checkbox(
              value: useDockerCompose,
              onChanged: (useDC) {
                useDockerCompose = !useDockerCompose;
                setState(() {});
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._getProjectListTiles(),
      ],
    );
  }

  List<Widget> _getProjectListTiles() {
    List<Widget> projectListTiles = [];
    for (var project in PROJECTS) {
      projectListTiles.add(Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: ElevatedButton(
            onPressed: () => project.open(useDockerCompose),
            child: Text(
              project.label,
              textAlign: TextAlign.center,
            )),
      ));
    }
    return projectListTiles;
  }
}
