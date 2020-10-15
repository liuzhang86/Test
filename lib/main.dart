import 'dart:async';

import 'package:flutter/material.dart';
import 'bloc_demo1.dart';
import 'value_listenable_builder.dart';
import 'package:flutter_hello_plugin/flutter_hello_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  StreamController<int> _streamController;

  @override
  void initState() {
    // TODO: implement initState
    _streamController = StreamController<int>();
    //_streamController.sink.add(0);
    //FlutterHelloPlugin helloPlugin = FlutterHelloPlugin();
    platformVersion();
    super.initState();
  }

  Future<void> platformVersion () async{
    String vers =  await FlutterHelloPlugin.platformVersion;
    print(vers);
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _streamController.close();
    super.dispose();
  }

  void _incrementCounter() {
    _streamController.sink.add(++_counter);
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
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
                stream: _streamController.stream,
                initialData: _counter,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
            FlatButton(
              child: Text('点击跳转到blocdemo1'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CounterBlocPage(
                          title: 'BlocDemo1',
                        )));
              },
            ),
            FlatButton(
              child: Text('点击跳转到valueListenPage'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ValueListenPage(
                          title: 'ValueListen',
                        )));
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
