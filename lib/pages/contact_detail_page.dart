import 'package:flutter/material.dart';
import 'package:nextflow_flutter_2_contact_app/user_data.dart';

class ContactDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Result contactResult = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(contactResult.name.first),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(contactResult.picture.large),
              ),
            ),
          )
        ],
      ),
    );
  }
}
