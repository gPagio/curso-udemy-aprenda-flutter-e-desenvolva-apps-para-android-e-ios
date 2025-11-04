import 'package:flutter/material.dart';

class CounterProviderState {
  int _counter = 0;

  void increment() => _counter++;

  void decrement() => _counter--;

  int get value => _counter;

  bool different(CounterProviderState other) {
    return _counter != other._counter;
  }
}

class CounterProvider extends InheritedWidget {
  final CounterProviderState state = CounterProviderState();

  CounterProvider({super.key, required super.child});

  static CounterProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>();
  }

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.state.different(state);
  }
}
