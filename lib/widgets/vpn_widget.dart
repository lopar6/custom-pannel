import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../services/vpn.dart';

class VpnWidget extends StatefulWidget {
  const VpnWidget({Key? key}) : super(key: key);

  @override
  State<VpnWidget> createState() => _VpnWidgetState();
}

class _VpnWidgetState extends State<VpnWidget> {
  Vpn vpn = Vpn();
  VpnConnectionStatus vpnConnectionStatus = VpnConnectionStatus.changing;

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
    return Column(
      children: [
        const Text("VPN Connection:", textScaleFactor: 2),
        Text(
          vpnConnectionStatus.name.toString(),
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          child: const Text("Connect"),
          onPressed: vpnConnectionStatus == VpnConnectionStatus.disconnected
              ? () async {
                  vpnConnectionStatus = VpnConnectionStatus.changing;
                  setState(() {});
                  await vpn.connect();
                  await vpn.isConnected(VpnCheckStrategy.waitForConnect);
                  vpnConnectionStatus = VpnConnectionStatus.connected;
                  setState(() {});
                }
              : null,
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          child: const Text("Disconnect"),
          onPressed: vpnConnectionStatus == VpnConnectionStatus.connected
              ? () async {
                  vpnConnectionStatus = VpnConnectionStatus.changing;
                  setState(() {});
                  await vpn.disconnect();
                  await vpn.isConnected(VpnCheckStrategy.waitForDisconnect);
                  vpnConnectionStatus = VpnConnectionStatus.disconnected;
                  setState(() {});
                }
              : null,
        ),
      ],
    );
  }
}
