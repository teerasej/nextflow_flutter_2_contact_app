import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nextflow_flutter_2_contact_app/pages/contact_detail_page.dart';
import 'package:nextflow_flutter_2_contact_app/user_data.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nextflow Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(title: 'Nextflow Contact'),
        '/detail': (context) => ContactDetailPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Uri uri = Uri.https(
    'randomuser.me',
    '/api',
    {'results': '200'},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: http.get(uri),
        builder: (BuildContext context, AsyncSnapshot<http.Response> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var response = snapshot.data;
            var data = userDataFromJson(response.body);

            var contacts = data.results;

            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                var contact = contacts[index];

                return ListTile(
                  title: Text(contact.name.first),
                  subtitle: Text(contact.phone),
                  leading: Image.network(contact.picture.large),
                  onTap: () {
                    Navigator.pushNamed(context, '/detail');
                  },
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
