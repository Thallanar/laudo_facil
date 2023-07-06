import 'package:flutter/material.dart';

import '../content/menu_bar/left_menu_bar.dart';
import '../content/menu_bar/right_menu_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: LeftMenuBar(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          actions: [RightMenuBar()],
          backgroundColor: Colors.black45,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => _openDrawer(),
          ),
          title: Text(
            'Laudo Fácil',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 400,
                width: 500,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset('assets/icons/Laudo.png'),
                ),
              ),
            ),
            Center(child: Text('Em Desenvolvimento'))
          ],
        ));
  }
}
