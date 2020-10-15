import 'package:flutter/material.dart';

class ValueListenPage extends StatefulWidget {
  final String title;

  const ValueListenPage({Key key, this.title}) : super(key: key);
  @override
  _ValueListenPageState createState() => _ValueListenPageState();
}

class _ValueListenPageState extends State<ValueListenPage> {
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);
  final Widget goodJob = const Text('good Job');
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
            Text('you have pushed the button this many times:'),
            ValueListenableBuilder(
                valueListenable: _counter,
                child: goodJob,
                builder: (BuildContext, int value, Widget child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('$value'),
                      child,
                    ],
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _counter.value ++,
      ),
    );
  }
}
