import 'dart:math' as math show Random;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// yellow
String _toYellow(String text) {
  return '\x1B[33m$text\x1B[0m';
}

// red
String _toRed(String text) {
  return '\x1B[31m$text\x1B[0m';
}

// blue
String _toBlue(String text) {
  return '\x1B[34m$text\x1B[0m';
}

//green
String _toGreen(String text) {
  return '\x1B[32m$text\x1B[0m';
}

extension PrintToConsole on Object? {
  get pr {
    String message = _toGreen('[LOG] [B O D Y > > ] ') + _toGreen('$this');
    if (kDebugMode) {
      print(message);
    }
    return this;
  }
}

extension DontPrintToConsole on Object? {
  get prx {
    return this;
  }
}

extension PrintTitleToConsole on Object? {
  get prt {
    String message = _toRed('[LOG] [T I T L E > ] ') + _toRed('$this');
    if (kDebugMode) {
      print(message);
    }
    return this;
  }
}

extension PrintTitleAndMessageToConsole on Object? {
  prm(String t) {
    String title = '${_toYellow('[LOG] [B O D Y > > ] ')}${_toYellow(t)} >> ${_toGreen(toString())}';
    if (kDebugMode) {
      print(title);
    }
    return this;
  }
}

extension AddS on String {
  String s(int number) {
    if (number > 1) {
      return '${this}s';
    } else {
      return this;
    }
  }
}

extension CenterOneWidget on Widget {
  Widget get cr => Center(child: this);
}

extension ExpandOneWidget on Widget {
  Widget get ex => Expanded(child: this);
}

extension SliverAdapter on Widget {
  Widget get sliver => SliverToBoxAdapter(child: this);
}

extension CenterAllWidgets on List<Widget> {
  List<Widget> get center => map((e) => Center(child: e)).toList();
}

extension ExpandAllWidgets on List<Widget> {
  List<Widget> get expand => map((e) => Expanded(child: e)).toList();
}

extension MapValueToString on Map {
  Map<String, String> get keyAndvalueToString => map((key, value) => MapEntry(key.toString(), value.toString()));
}

extension ToMap on Object? {
  Map<String, Object?> get toMap => this as Map<String, Object?>;
}

extension ToInt on Object? {
  int get toInt => this as int;
}

extension ToDouble on Object? {
  double get toDouble => this as double;
}

snackBar({required BuildContext context, required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(title).cr,
    duration: const Duration(milliseconds: 800),
  ));
}

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}
