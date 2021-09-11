import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mytarget/tabs/ChartPage.dart';
import 'package:mytarget/tabs/HistoryPage.dart';
import 'package:mytarget/tabs/HomePage.dart';

import 'pages/target/create.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // ensure widgets are initialized
  await Firebase.initializeApp();  // await --> don't run the app untill initialize the app
  runApp(MyApp());      //to start the app by using runApp()
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      title: 'MyTarget',
      theme: ThemeData(
        
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index=0;
  List<Widget> tabs=[];
  late Widget page;
  bool pageAssigned=false;

  @override
  Widget build(BuildContext context) {

    tabs.add(Homepage());
    tabs.add(ChartPage());
    tabs.add(Historypage());


    return Scaffold(
      appBar: AppBar(
        title: Text("MY TARGET"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState((){
          page= TargetCreate();
          pageAssigned=true;
        });
        },
        ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
            child: Text("Your Name Here"),
            decoration: BoxDecoration(
            color: Colors.amber
            ),
        ),
        ListTile(
          title:Text("Collection History"),
          onTap:(){

          },
        ),
        ListTile(
          title:Text("My Profile"),
          onTap:(){

          },
        ),
        ListTile(
          title:Text("Log Out"),
          onTap:(){

          },
        ),
      ],
      ),
      ),
      body:
      pageAssigned? page:tabs[index], 
      bottomNavigationBar: BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",

        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart),
          label: "Charts",
          
        ),
         BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "History",
          
        )
      ],
      currentIndex: index,
      onTap: (i){
        setState(() {
          index=i;
          pageAssigned=false;
        });
      },
      ),
    );
  }
}
