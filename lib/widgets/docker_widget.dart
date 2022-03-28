import 'package:custom_panel/models/docker_container.dart';
import 'package:custom_panel/services/docker_service.dart';
import 'package:flutter/material.dart';

class DockerWidget extends StatefulWidget {
  const DockerWidget({Key? key}) : super(key: key);

  @override
  State<DockerWidget> createState() => _DockerWidgetState();
}

class _DockerWidgetState extends State<DockerWidget> {
  DockerService dockerService = DockerService();
  DockerState dockerLoadingState = DockerState.checking;
  List<Row> runningContainers = [];

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    await _setDockerContainerWidgets();
    dockerLoadingState = DockerState.upToDate;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Running Docker Containers:",
            textScaleFactor: 2,
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(
          child: const Text("reload containers"),
          onPressed: () async {
            dockerLoadingState = DockerState.checking;
            setState(() {});
            await _setDockerContainerWidgets();
            dockerLoadingState = DockerState.upToDate;
            setState(() {});
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
              shrinkWrap: true,
              children: dockerLoadingState == DockerState.checking
                  ? [
                      const Text(
                        "Loading...",
                        textAlign: TextAlign.center,
                      )
                    ]
                  : runningContainers == []
                      ? [
                          const Text(
                            "No Docker Containers Running",
                            textAlign: TextAlign.center,
                          )
                        ]
                      : runningContainers),
        ),
      ],
    );
  }

  Future<void> _setDockerContainerWidgets() async {
    try {
      for (DockerContainer dockerContainer
          in await dockerService.getRunningDockerContainers()) {
        runningContainers.add(Row(children: [
          Text(dockerContainer.name),
          Text(dockerContainer.status),
        ]));
      }
    } catch (e) {
      runningContainers = [];
      // ignore: avoid_print
      print(e);
    }
  }
}
