import 'dart:io';

import 'package:custom_panel/models/docker_container.dart';

class DockerService {
  Future<List<DockerContainer>> getRunningDockerContainers() async {
    ProcessResult result;
    result = Process.runSync(
        'docker', ['ps', '--format', '"{{.Names}}: {{.Status}}"']);

    String resultStr = result.stdout;
    List<String> resultLines = resultStr.trim().split("\n");
    List<DockerContainer> dockerContainers = [];
    for (String line in resultLines) {
      List<String> containerValues = line.split(": ");
      dockerContainers.add(DockerContainer(
          name: containerValues[0], status: containerValues[1]));
    }

    return dockerContainers;
  }
}
