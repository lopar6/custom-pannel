import 'package:custom_panel/services/vpn.dart';
import 'package:custom_panel/widgets/docker_widget.dart';
import 'package:custom_panel/widgets/vpn_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'workon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool useDockerCompose = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Panel"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: 800,
        height: 800,
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          children: [
            const VpnWidget(),
            Column(
              children: [
                const Text("Select A Project:", textScaleFactor: 2),
                const SizedBox(height: 50),
                const Text("Also Start Docker Containers?"),
                Checkbox(
                  value: useDockerCompose,
                  onChanged: (useDC) {
                    useDockerCompose = !useDockerCompose;
                    setState(() {});
                  },
                ),
                const SizedBox(height: 10),
                Workon(useDockerCompose),
              ],
            ),
            DockerWidget(),
          ],
        ),
      ),
    );
  }
}
