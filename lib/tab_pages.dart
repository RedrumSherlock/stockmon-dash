import 'dart:convert';

import 'package:flutter/material.dart';

import 'model/market.dart';
import 'model/trader.dart';

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

   final response = "[{\"cash\":21.0499999999995,\"end_date\":\"2100-12-31\",\"init_funds\":11500,\"last_5_transactions\":[{\"action\":\"buy\",\"amount\":33,\"datetime\":\"2022-09-02 09:45:23\",\"price\":30.37,\"symbol\":\"PDF.TO\"},{\"action\":\"buy\",\"amount\":32,\"datetime\":\"2022-09-02 09:45:25\",\"price\":31.22,\"symbol\":\"ESGA.TO\"},{\"action\":\"buy\",\"amount\":78,\"datetime\":\"2022-09-02 10:00:24\",\"price\":14.41,\"symbol\":\"TQGM.TO\"},{\"action\":\"sell\",\"amount\":7,\"datetime\":\"2022-09-02 12:45:16\",\"price\":28.16,\"symbol\":\"PBI.TO\"},{\"action\":\"buy\",\"amount\":12,\"datetime\":\"2022-09-02 13:00:23\",\"price\":28.2,\"symbol\":\"PBI.TO\"}],\"latest_price\":{\"CINT.TO\":17.6,\"CLG.TO\":16.67,\"EDGF.TO\":8.96,\"ESGA.TO\":30.82,\"FIG.TO\":9.37,\"FLCP.TO\":17.42,\"FLSD.TO\":18.51,\"HAB.TO\":9.58,\"HXF.TO\":56.38,\"PBI.TO\":27.72,\"PDF.TO\":29.86,\"TQGM.TO\":14.05,\"XSC.TO\":17.49,\"ZBBB.TO\":26.83},\"position\":{\"CINT.TO\":0,\"CLG.TO\":67,\"EDGF.TO\":0,\"ESGA.TO\":32,\"FIG.TO\":120,\"FLCP.TO\":64,\"FLSD.TO\":61,\"HAB.TO\":117,\"HXF.TO\":0,\"PBI.TO\":12,\"PDF.TO\":33,\"TQGM.TO\":78,\"XSC.TO\":64,\"ZBBB.TO\":42},\"start_date\":\"2020-06-30\",\"total_value\":11273.569999999998,\"trader_name\":\"Default Trader\"}]";
   List<dynamic> dynamicList = json.decode(response);
   Trader.fromJson(json.decode(response)[0]);
   List<Trader> traderList = dynamicList.map((dynamic o) => Trader.fromJson(o as Map<String, dynamic>)).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        const SizedBox(height: 16.0),
        SimpleObjectViewList(simpleObjects: traderList),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class SimpleObjectViewList extends StatelessWidget {
  const SimpleObjectViewList({required this.simpleObjects, super.key});

  final List<Trader> simpleObjects;

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

  final Trader simpleObject;

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
              'name:',
              style: boldStyle,
            ),
            Text(
              simpleObject.name != null
                  ? '"${simpleObject.name}"'
                  : 'NULL',
              style: localTheme.bodyText2,
            ),
          ],
        ),
        TableRow(
          children: [
            Text('cash:', style: boldStyle),
            Text(
              simpleObject.cash.toString(),
              style: localTheme.bodyText2,
            ),
          ],
        ),
        TableRow(children: [
          Text('total value:', style: boldStyle),
          Text(
            simpleObject.totalValue.toString(),
            style: localTheme.bodyText2,
          ),
        ]),
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