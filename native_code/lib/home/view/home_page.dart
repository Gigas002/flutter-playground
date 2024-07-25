import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;
  String _line = '';
  String _theme = '';

  static const platform = MethodChannel('example.com/channel');

  static const events = EventChannel('example.com/channel');

  @override
  void initState() {
    super.initState();
    events.receiveBroadcastStream().listen(_onEvent);
  }

  void _onEvent(Object? event) {
    setState(() {
      _theme = event == true ? 'dark' : 'light';
    });
  }

  Future<void> _generateRandomString() async {
    String random = '';
    try {
      var arguments = {
        'len': 3,
        'prefix': 'fl_',
      };
      random = await platform.invokeMethod('getRandomString', arguments);
      print(random.runtimeType);
    } on PlatformException {
      random = '';
    }

    setState(() {
      _line = random;
    });
  }

  Future<void> _generateRandomNumber() async {
    int random;
    try {
      random = await platform.invokeMethod('getRandomNumber');
    } on PlatformException {
      random = 0;
    }

    setState(() {
      _counter = random;
    });
  }

  Future<void> _findColorTheme() async {
    bool isDarkMode;

    try {
      isDarkMode = await platform.invokeMethod('isDarkMode');
    } on PlatformException catch (e) {
      isDarkMode = false;
      print('PlatformException: ${e.code} ${e.message}');
    }

    setState(() {
      _theme = isDarkMode ? 'dark' : 'light';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Random number:"),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: _generateRandomNumber,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Random str:"),
                Text(
                  _line,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: _generateRandomString,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Current theme:"),
                Text(
                  _theme,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  onPressed: _findColorTheme,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
