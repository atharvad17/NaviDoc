import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/login_screen.dart';
import 'package:navi_doc/practice_information_screen.dart';
import 'package:navi_doc/report_screen.dart';
import 'package:navi_doc/work_records_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  String username = "";
  UserLogin? userLogin;

  Widget _buildWelcome(){
    return Text('Welcome Dr. '+username, style: const TextStyle(
        color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold
    ),
    );
  }

  Widget _buildPracticeBtn(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
          minimumSize: const Size(350, 45),
          primary: Colors.green[900],), onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PracticeInformationScreen()));
      },
          child: const Text('Hospitals', style: TextStyle(
            fontSize: 18,
          ),)
      ),
    );
  }

  Widget _buildWorkBtn(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
        minimumSize: const Size(350, 45),
          primary: Colors.indigo[900],), onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const WorkRecords()));
      },
          child: const Text('Procedures', style: TextStyle(
            fontSize: 18,
          ),)
      ),
    );
  }

  Widget _buildReportBtn(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
          minimumSize: const Size(350, 45),
          primary: Colors.green[900],),  onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ReportScreen()));
      },
          child: const Text('Reports', style: TextStyle(
            fontSize: 18,
          ),)
      ),
    );
  }

  Widget _buildSearchHeader(){
    return IconButton(
      icon: const Icon(
        Icons.search,
        color: Colors.black,
      ),
      onPressed: () {

      },
    );
  }

  Widget _buildMsgHeader(){
    return IconButton(
      icon: const Icon(
        Icons.message_outlined,
        color: Colors.black,
      ),
      onPressed: () {

      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferences.getInstance().then((prefs) => {
      userLogin = userLoginFromJson(prefs.getString("UserLogin")!),
      setState(() {
        username = userLogin!.Username;
      }),

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        //leading: const Icon(Icons.view_headline, color: Colors.black,),
        title: Image.asset('assets/images/navigo4.jpg', height: MediaQuery.of(context).size.height * 0.1, width: MediaQuery.of(context).size.width * 0.2,),
        // actions: [
        //   _buildSearchHeader(),
        //   _buildMsgHeader(),
        // ],
      ),
      body: WillPopScope(
        onWillPop: () { // this is the block you need
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return WillPopScope(
                  onWillPop: () async => false,
                  child: AlertDialog(
                    title: const Text('Do You Wish to Exit or Logout'),
                    actions: <Widget>[
                      ElevatedButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: const Text('Cancel')),
                      ElevatedButton(onPressed: () {
                        SystemNavigator.pop();
                      }, child: const Text('Exit')),
                      ElevatedButton(
                        child: const Text('Logout'),
                        onPressed: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.remove("UserLogin");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                        },
                      ),
                    ],
                  ),
                );
              }
          );
          return Future.value(false);
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 35,),
              _buildWelcome(),
              const SizedBox(height: 150,),
              _buildPracticeBtn(),
              const SizedBox(height: 30,),
              _buildWorkBtn(),
              const SizedBox(height: 30,),
              _buildReportBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
