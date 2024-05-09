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
        drawer: const LeftMenuBar(),
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          actions: const [RightMenuBar()],
          backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
          // backgroundColor: const Color.fromRGBO(224, 71, 66, 88),
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _openDrawer(),
          ),
          title: const Text(
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
                  child: Image.asset('assets/icons/Laudo_3.png'),
                ),
              ),
            ),
            const Center(child: Text('Em Desenvolvimento'))
          ],
        ));
  }
}
