import 'package:flutter/material.dart';
import 'package:live_stream_test_app/pages/host_page.dart';
import 'package:live_stream_test_app/pages/viewer_page.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Live Test'),
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(padding: EdgeInsets.only(top: 100)),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'Agora Live Demo',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
            MaterialButton(
              onPressed: () {
                onJoin().whenComplete(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HostPage(),
                    ),
                  );
                });
              },
              height: 40,
              color: Colors.blueAccent,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Stream Live', style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 30)),
            MaterialButton(
              onPressed: () {
                onJoin().whenComplete(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ViewerPage(),
                    ),
                  );
                });
              },
              height: 40,
              color: Colors.blueAccent,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Join Live', style: TextStyle(color: Colors.white)),
                  Icon(Icons.arrow_forward, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    await [
      Permission.camera,
      Permission.microphone,
    ].request();
  }
}
