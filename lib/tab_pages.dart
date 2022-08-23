import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/converted_simple_object.dart';

class BasicsPage extends StatelessWidget {
  const BasicsPage({super.key});

  List<TableRow> createMapRows(
      Map<String, dynamic> values, TextStyle normalStyle, TextStyle boldStyle) {
    return values.keys.map((k) {
      return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
            child: Text(k, style: boldStyle),
          ),
          Text(
            values[k] is String ? '"${values[k]}"' : '${values[k]}',
            style: normalStyle,
          ),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    final boldStyle =
    localTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600);

    const mapOfDynamics = '''
    {
      "anInt": 1,
      "aString": "Blah, blah, blah.",
      "aDouble": 1.0
    }''';
    final dynamicMapOfDynamics = json.decode(mapOfDynamics) as Map;
    final strongMapOfDynamics = Map<String, dynamic>.from(dynamicMapOfDynamics);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Table(
            columnWidths: const {
              0: IntrinsicColumnWidth(),
              1: FlexColumnWidth(1.0),
            },
            children: createMapRows(
              strongMapOfDynamics,
              localTheme.bodyText2!,
              boldStyle,
            ),
          ),
      ],
    );
  }
}

class ConvertedSimplePage extends StatelessWidget {
  const ConvertedSimplePage({super.key});

  @override
  Widget build(BuildContext context) {

    final simpleObjects = [
      '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfInts": [1, 2, 3],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfInts": [1, 2, 3],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "aDouble": 1.0,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfInts": [1, 2, 3],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfInts": [1, 2, 3],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfInts": [1, 2, 3],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfInts": [1, 2, 3]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfStrings": [],
      "aListOfInts": [1, 2, 3],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfInts": [],
      "aListOfDoubles": [1.0, 2.0, 3.0]
    }''',
        '''
    {
      "aString": "Blah, blah, blah.",
      "anInt": 1,
      "aDouble": 1.0,
      "aListOfStrings": ["one", "two", "three"],
      "aListOfInts": [1, 2, 3],
      "aListOfDoubles": []
    }''',
    ];
    var objects = simpleObjects.map(
          (jsonString) {
        final parsedJson = json.decode(jsonString) as Map<String, dynamic>;
        return ConvertedSimpleObject.fromJson(parsedJson);
      },
    ).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 16.0),
        SimpleObjectViewList(simpleObjects: objects),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class SimpleObjectViewList extends StatelessWidget {
  const SimpleObjectViewList({required this.simpleObjects, super.key});

  final List<dynamic> simpleObjects;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[];

    for (var i = 0; i < simpleObjects.length; i++) {
      widgets.addAll([
        Text(
          'SimpleObject $i:',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 4.0),
        SimpleObjectView(simpleObject: simpleObjects[i]),
        const SizedBox(height: 24.0),
      ]);
    }

    widgets.removeLast();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}

class SimpleObjectView extends StatelessWidget {
  const SimpleObjectView({required this.simpleObject, super.key});

  final dynamic simpleObject;

  @override
  Widget build(BuildContext context) {
    final localTheme = Theme.of(context).textTheme;
    final boldStyle =
    localTheme.bodyText2!.copyWith(fontWeight: FontWeight.w600);

    if (simpleObject == null) return Text('NULL', style: localTheme.bodyText2);

    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(1.0),
      },
      children: [
        TableRow(
          children: [
            Text(
              'aString:',
              style: boldStyle,
            ),
            Text(
              simpleObject.aString != null
                  ? '"${simpleObject.aString}"'
                  : 'NULL',
              style: localTheme.bodyText2,
            ),
          ],
        ),
        TableRow(
          children: [
            Text('anInt:', style: boldStyle),
            Text(
              simpleObject.anInt?.toString() ?? 'NULL',
              style: localTheme.bodyText2,
            ),
          ],
        ),
        TableRow(children: [
          Text('aDouble:', style: boldStyle),
          Text(
            simpleObject.aDouble?.toString() ?? 'NULL',
            style: localTheme.bodyText2,
          ),
        ]),
        TableRow(
          children: [
            Text('aListOfStrings:', style: boldStyle),
            Text(
              prettyPrintList(
                simpleObject.aListOfStrings as Iterable<dynamic>?,
              ),
              style: localTheme.bodyText2,
            ),
          ],
        ),
        TableRow(
          children: [
            Text('aListOfInts:', style: boldStyle),
            Text(
              prettyPrintList(simpleObject.aListOfInts as Iterable<dynamic>?),
              style: localTheme.bodyText2,
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text('aListOfDoubles:', style: boldStyle),
            ),
            Text(
              prettyPrintList(
                  simpleObject.aListOfDoubles as Iterable<dynamic>?),
              style: localTheme.bodyText2,
            ),
          ],
        ),
      ],
    );
  }
}

String prettyPrintList(Iterable? iter) {
  if (iter == null) return 'NULL';

  final buff = StringBuffer();
  var isFirst = true;

  buff.write('[');

  for (final val in iter) {
    if (!isFirst) buff.write(', ');
    isFirst = false;
    if (val is String) {
      buff.write('"$val"');
    } else {
      buff.write(val.toString());
    }
  }

  buff.write(']');

  return buff.toString();
}