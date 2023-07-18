import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PagSobre extends StatelessWidget {
  const PagSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: Colors.black54,
          title: Text('Sobre'),
          actions: [
            PopupMenuButton(
              offset: Offset(0, 55),
              // color: Colors.black87,
              icon: Icon(Icons.more_vert),
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text(
                    'Site',
                    // style: TextStyle(color: Colors.white),
                  ),
                  value: 1,
                )
              ],
              onSelected: (selectValue) {
                // if (selectValue == 1) {
                //   _launchURL();
                // }
              },
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              width: 300,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Image.asset('assets/icons/Laudo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
              child: Text(
                'Projeto com finalidade ao atedimento ao público, na área de medicina!',
                textAlign: TextAlign.center,
              ),
            )
          ],
        ));
  }
}

// _launchURL() async {
//   const url = 'https://unifoa.edu.br';
//   if (await canLaunchUrlString(url)) {
//     await launchUrlString(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
