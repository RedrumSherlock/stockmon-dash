import 'package:flutter/material.dart';
import 'package:stockmondash/tab_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Monitor Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Stock Monitor Dashboard'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: 'Market'),
              Tab(text: 'Traders'),
            ],
          ),
        ),
        body: const SafeArea(
          bottom: true,
          child: TabBarView(
            children: [
              BasicsPage(),
              ConvertedSimplePage(),
            ],
          ),
        ),
      ),
    );
  }
}
