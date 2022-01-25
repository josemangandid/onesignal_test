import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:onesignal_test/push_notifications_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    listener();
  }

  listener(){
    PushNotificationService.messageStream.listen(( OSNotification notification ) {
      if(notification.additionalData!["type"] == "navigatoToSecondPage"){
        Navigator.push(context, MaterialPageRoute(builder: (_) => const SecondPage()));
      }
      if(notification.additionalData!["type"] == "backToFirstPage"){
        Navigator.pop(context);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FirstScreen"),),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.yellow,
      ),
    );
  }
}


class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SecondScreen"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.pink,
      ),
    );
  }
}
