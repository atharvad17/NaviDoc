import 'package:flutter/material.dart';
import 'package:navi_doc/Model/UserLogin.dart';
import 'package:navi_doc/Services/common.dart';
import 'package:navi_doc/home_screen.dart';
import 'package:navi_doc/report_screen.dart';
import 'package:navi_doc/work_records_screen.dart';
import 'Services/api_call.dart';
import 'add_hospital_screen.dart';

class PracticeInformationScreen extends StatefulWidget {
  const PracticeInformationScreen({Key? key}) : super(key: key);

  @override
  _PracticeInformationScreenState createState() => _PracticeInformationScreenState();
}

class _PracticeInformationScreenState extends State<PracticeInformationScreen> {
  late UserLogin userLogin ;

  Widget _buildHeader(){
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
  void initState()  {

  }

  Widget _buildBody(BuildContext context){
    //Common.buildShowDialog(context);
    return Container(
      child: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height *0.07,
              color: Colors.green[900],
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width *0.2,
                    child: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,
                    size: 28,),
                      onPressed: (){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
                      },
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *0.6,
                    child: const Text("\t\t\t\t\t\t\t\t\t\t\t\t\t\tHospitals", style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width *0.2,
                    child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AddHospitalScreen(hospital: null)));
                        },
                      ),
                  ),

                ],
              )

          ),
          Container(
              height: MediaQuery.of(context).size.height *0.022,
              child: const Text('Press "+" Button to Add Hospital')),
          SizedBox(
            height: MediaQuery.of(context).size.height *0.7,
            child: Card(
              child: FutureBuilder(
                future: getHospitalData(context),
                builder: (context, AsyncSnapshot snapshot){
                  Common.buildShowDialog(context);
                  if (snapshot.data == null){
                    Common.hideDialog(context);
                    return Container(
                      child: const Center(
                        child: Text('No Data Available'),
                      ),
                    );
                  }
                  else {
                    Common.hideDialog(context);
                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                      ),
                      child: ListView.builder( scrollDirection: Axis.vertical,
                          shrinkWrap: true,itemCount: snapshot.data.length, itemBuilder: (context, index) {

                        return Column(
                          children: [
                            ListTile(
                                  leading: Text('${index + 1}'),
                                  title: Text(snapshot.data[index].Name),
                                  // subtitle: Text(snapshot.data[index].body),
                                  trailing: IconButton(
                                    icon: const Icon(
                                        Icons.edit_outlined
                                    ), onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => AddHospitalScreen(hospital: snapshot.data[index])));
                                  },
                                  ),
                                  // onTap: () {
                                  //   Fluttertoast.showToast(
                                  //     msg: "Title: "+snapshot.data[index].title,
                                  //     toastLength: Toast.LENGTH_LONG,
                                  //     gravity: ToastGravity.BOTTOM,
                                  //     timeInSecForIosWeb: 1,
                                  //     textColor: Colors.white,
                                  //     fontSize: 16.0,
                                  //   );
                                  // },
                                ),
                            const Divider(height: 1, color: Colors.black, thickness: 1.5,),
                          ],
                        );
                          }),
                    );
                  }
                },

              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height *0.075,
            child: Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width *0.05,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width *0.35,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
    primary: Colors.indigo[900],
    ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const WorkRecords()));
                    },
                    child: const Text('Procedures'),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width *0.2,),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  width: MediaQuery.of(context).size.width *0.35,
                  child: ElevatedButton(style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[900],
                  ),
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const ReportScreen()));
                    },
                    child: const Text('Reports'),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width *0.05,),
              ],
            ),
          )
        ],
      )

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        //leading: const Icon(Icons.view_headline, color: Colors.black,),
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/navigo4.jpg', height: MediaQuery.of(context).size.height * 0.1, width: MediaQuery.of(context).size.width * 0.2,),
        // actions: <Widget>[
        //   _buildHeader(),
        //   _buildMsgHeader(),
        // ],
      ),
      body: WillPopScope(
        onWillPop: () { // this is the block you need
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
          return Future.value(false);
        },
        child: _buildBody(context),
      ),
    );
  }
}
