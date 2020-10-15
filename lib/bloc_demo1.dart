import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterBlocPage extends StatefulWidget {
  final String title;

  const CounterBlocPage({Key key, this.title}) : super(key: key);

  @override
  _CounterBlocPageState createState() => _CounterBlocPageState();
}

class _CounterBlocPageState extends State<CounterBlocPage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    // 获取Bloc
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: BlocBuilder<CounterBloc, int>(builder: (context, count) {
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
                  Text(
                    '$count',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  // 加
                  FlatButton(
                    onPressed: () {
                      context.bloc<CounterBloc>().add(CounterEvent.increment);
                    },
                    child: Icon(Icons.add),
                  ),
                  // 减
                  FlatButton(
                    onPressed: () {
                      context.bloc<CounterBloc>().add(CounterEvent.decrement);
                    },
                    child: Icon(Icons.remove),
                  ),
                ],
              ),
            ),
        );
      }),
    );
  }
}


/// Event being processed by [CounterBloc]
enum CounterEvent {
  /// Notifies bloc to increment state.
  increment,

  /// Notifies bloc to decrement state.
  decrement
}

/// {@template counter_bloc}
/// A simple [Bloc] which manages an `int` as its state.
/// {@endtemplate}
class CounterBloc extends Bloc<CounterEvent, int> {
  /// {@macro counter_bloc}
  CounterBloc() : super(0);

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.decrement:
        yield state - 1;
        break;
      case CounterEvent.increment:
        yield state + 1;
        break;
      default:
        addError(Exception('unsupported event'));
    }
  }
}
