import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isConnected = false;

  bool _checkVpnConnect() {
    return false;
  }

  void _vpnConnect() {
    setState(() {});
  }

  void _vpnDisconnect() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: _vpnConnect, child: const Text("Connect")),
            ElevatedButton(
                onPressed: _vpnDisconnect, child: const Text("Disconnect")),
          ],
        ),
      ),
    );
  }
}
