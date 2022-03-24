import 'dart:io';
import './models/project.dart';

List<Project> PROJECTS = [
  Project(
    label: 'Workon',
    dockerized: false,
    open: (bool dcUp) async {
      // since dockerized was false dcUp will always be false
      print("Work on Workon");
      String workDir = "/home/logan/dev/workon-dart";
      Process.runSync('code', [workDir]);
    },
  ),
  Project(
    label: 'crewtracks-web',
    dockerized: true,
    open: (bool dcUp) async {
      // If the user chose to dcUp, this will also turn on the docker containers.
      print("Work on Crewtracks Web");
      String workDir = "/home/logan/dev/crewtracks-web";
      String frontendDir = "$workDir/app/AdminApp";
      if (dcUp) {
        var dcArgs = ['-f', '$workDir/docker-compose.yaml', 'up', '-d'];
        Process.runSync('docker-compose', dcArgs);
      }
      Process.runSync('code', [workDir]);

      // TODO: figure out how to open command line in vscode through script
      // Without waiting a little the frontend side can open before the server side,
      // some developers like to always keep the server side on one side predictably.
      await Future.delayed(const Duration(seconds: 1));
      Process.runSync('npm', ['--prefix', frontendDir, 'run', 'watch']);
    },
  ),
];
