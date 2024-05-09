import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PagSobre extends StatelessWidget {
  const PagSobre({Key? key}) : super(key: key);

  Future<void> _launchURL(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 10,
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color.fromRGBO(85, 212, 237, 93),
          title: const Text('Sobre'),
          actions: [
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (_) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text(
                    'Site',
                  ),
                )
              ],
              onSelected: (selectValue) {
                if (selectValue == 1) {
                  final Uri toLaunch = Uri(
                    scheme: 'https', 
                    host: 'github.com',
                    path: 'thallanar/'
                  );
                  _launchURL(toLaunch);
                }
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                width: 500,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset('assets/icons/Laudo_3.png'),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: const Text(
                  'Projeto com a finalidade de atedimento ao público, na área de medicina!',
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ));
  }
}

