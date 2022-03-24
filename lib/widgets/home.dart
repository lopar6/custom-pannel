import 'package:custom_panel/services/vpn.dart';
import 'package:custom_panel/widgets/docker_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'workon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Vpn vpn = Vpn();
  VpnConnectionStatus vpnConnectionStatus = VpnConnectionStatus.changing;
  bool useDockerCompose = true;

  @override
  void initState() {
    super.initState();
    _initAsync();
  }

  Future<void> _initAsync() async {
    try {
      if (await vpn.isConnected()) {
        vpnConnectionStatus = VpnConnectionStatus.connected;
      } else {
        vpnConnectionStatus = VpnConnectionStatus.disconnected;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Panel"),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Text(vpnConnectionStatus.toString()),
                Column(
                  children: [
                    ElevatedButton(
                      child: const Text("Connect"),
                      onPressed: vpnConnectionStatus ==
                              VpnConnectionStatus.disconnected
                          ? () async {
                              vpnConnectionStatus =
                                  VpnConnectionStatus.changing;
                              setState(() {});
                              await vpn.connect();
                              await vpn
                                  .isConnected(VpnCheckStrategy.waitForConnect);
                              vpnConnectionStatus =
                                  VpnConnectionStatus.connected;
                              setState(() {});
                            }
                          : null,
                    ),
                    ElevatedButton(
                      child: const Text("Disconnect"),
                      onPressed:
                          vpnConnectionStatus == VpnConnectionStatus.connected
                              ? () async {
                                  vpnConnectionStatus =
                                      VpnConnectionStatus.changing;
                                  setState(() {});
                                  await vpn.disconnect();
                                  await vpn.isConnected(
                                      VpnCheckStrategy.waitForDisconnect);
                                  vpnConnectionStatus =
                                      VpnConnectionStatus.disconnected;
                                  setState(() {});
                                }
                              : null,
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                const Text("Also Start Docker Containers?"),
                Checkbox(
                  value: useDockerCompose,
                  onChanged: (useDC) {
                    useDockerCompose = !useDockerCompose;
                    setState(() {});
                  },
                ),
              ],
            ),
            Workon(useDockerCompose),
            DockerWidget(),
          ],
        ),
      ),
    );
  }
}
