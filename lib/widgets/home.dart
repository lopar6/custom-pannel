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
      body: Container(
        padding: const EdgeInsets.all(20),
        width: 800,
        height: 800,
        child: GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      vpnConnectionStatus.name.toString(),
                    ),
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 15),
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
