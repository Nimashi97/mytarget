import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

final Stream<QuerySnapshot> _targetStream = FirebaseFirestore.instance.collection('targets').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _targetStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text("Something went wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return Text("Loading");
        }
        return new ListView(
          children: snapshot.data!.docs.map(  //!no need to check null
            (DocumentSnapshot document){
              dynamic doc = document.data();
              return ListTile(
                title: new Text(doc['name']),
                subtitle: new Text(doc['amount'].toString()),
              );
            }
          ).toList(),
        );
      }
    );
  }
}
