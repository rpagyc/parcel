import 'package:flutter/material.dart';
import 'package:kazpost_tracker/features/tracking/presentation/pages/track_list_page.dart';
import 'package:kazpost_tracker/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Мои посылки';
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TrackListPage(),
    );
  }
}


