import 'dart:io';

import 'package:custom_panel/enums.dart';
import 'package:custom_panel/env.dart';

class Vpn {
  Future<bool> isConnected(
      [VpnCheckStrategy strategy = VpnCheckStrategy.immediate]) async {
    switch (strategy) {
      case VpnCheckStrategy.immediate:
        return await _isConnected();
      case VpnCheckStrategy.waitForConnect:
        for (int i = 0; i < 10; i++) {
          if (await _isConnected()) {
            return true;
          }
          await Future.delayed(const Duration(seconds: 1));
        }
        return false;
      case VpnCheckStrategy.waitForDisconnect:
        for (int i = 0; i < 10; i++) {
          if (!await _isConnected()) {
            return false;
          }
          await Future.delayed(const Duration(seconds: 1));
        }
        return true;
    }
  }

  Future<bool> _isConnected() async {
    var officeConnections = [
      for (var con in await _getConnections())
        if (con['Session name'] == Env.VPN_SESSION_NAME) con
    ];

    for (var con in officeConnections) {
      if (con['Status']!.startsWith('Connection')) {
        return true;
      }
    }
    return false;
  }

  Future<void> connect() async {
    var result = await Process.run(
        'openvpn3', ['session-start', '--config', Env.PATH_TO_OVPN]);
    stderr.write(result.stderr);
    if (result.stderr != '') {
      throw Exception('Not able to disconnect');
    }
  }

  Future<void> disconnect() async {
    var cons = await _getConnections();
    // print(cons);
    for (var con in cons) {
      String path = con['Path']!;
      String sessionName = con['Session name']!;
      if (sessionName == 'office.gurutechnologies.net') {
        var result = await Process.run('openvpn3',
            ['session-manage', '--session-path', path, '--disconnect']);
        stderr.write(result.stderr);
        if (result.stderr != '') {
          throw Exception('Not able to disconnect');
        }
      }
    }
  }

  // FIXME get keys/values from lines with multiple keys/values
  Future<List<Map<String, String>>> _getConnections() async {
    List<Map<String, String>> maps = [];

    var result = await Process.run('openvpn3', ['sessions-list']);
    // stdout.write(result.stdout);
    stderr.write(result.stderr);

    String resultStr = result.stdout;
    List<String> resultChunks = resultStr.split("\n\n");
    for (var result in resultChunks) {
      List<String> resultSegemnts = result.split("\n");
      Map<String, String> currentMap = {};
      for (String segment in resultSegemnts) {
        if (segment.startsWith('---------------------')) {
          continue;
        }
        segment = segment.trim();
        int colonIndex = segment.indexOf(': ');
        if (colonIndex == -1) {
          continue;
        }
        String key = segment.substring(0, colonIndex);
        String value = segment.substring(colonIndex + 2, segment.length);
        currentMap[key] = value;
      }
      maps.add(currentMap);
    }

    return maps;
  }
}
