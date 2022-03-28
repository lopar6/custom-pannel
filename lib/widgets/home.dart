import 'package:custom_panel/widgets/docker_widget.dart';
import 'package:custom_panel/widgets/vpn_widget.dart';
import 'package:flutter/material.dart';

import 'workon.dart';

enum ScreenSize { wide, narrow }

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 1000) {
            return _mainPanel(ScreenSize.wide);
          } else {
            return _mainPanel(ScreenSize.narrow);
          }
        },
      ),
    );
  }

  Widget _mainPanel(ScreenSize screenSize) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: screenSize == ScreenSize.wide ? 3 : 1,
          mainAxisExtent: 300,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        children: [
          _homeDecorationBox(const Workon()),
          _homeDecorationBox(const VpnWidget()),
          _homeDecorationBox(const DockerWidget()),
        ],
      ),
    );
  }

  Widget _homeDecorationBox(Widget child) {
    return DecoratedBox(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black45, width: 5)),
      child: SizedBox(
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
