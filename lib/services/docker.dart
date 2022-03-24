import 'dart:io';

import 'package:custom_panel/env.dart';
import 'package:custom_panel/models/project.dart';

class Docker {
  Future<List<Project>> getDockerContainers() async {
    ProcessResult result;
    try {
      result = Process.runSync('docker', ['ps']);
      print(result);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return [];

    // return result;
  }
}
