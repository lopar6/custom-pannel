import 'package:custom_panel/widgets/docker_widget.dart';
import 'package:custom_panel/widgets/vpn_widget.dart';
import 'package:flutter/material.dart';

import 'workon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool useDockerCompose = true;
  static const double mainBoxWidth = 1000;
  static const double mainBoxHeight = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Panel"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        width: mainBoxWidth,
        height: mainBoxWidth,
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          children: [
            _homeDecorationBox(const VpnWidget()),
            _homeDecorationBox(
              Column(
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
                  Workon(useDockerCompose),
                ],
              ),
            ),
            _homeDecorationBox(const DockerWidget()),
          ],
        ),
      ),
    );
  }

  Widget _homeDecorationBox(Widget child) {
    return DecoratedBox(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black45, width: 5)),
      child: SizedBox(
          width: mainBoxWidth,
          height: mainBoxHeight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),
                child,
              ],
            ),
          )),
    );
  }
}
