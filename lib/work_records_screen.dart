import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navi_doc/Services/common.dart';
import 'package:navi_doc/add_work_record_screen.dart';
import 'package:navi_doc/add_amount_record_screen.dart';
import 'package:navi_doc/home_screen.dart';
import 'package:navi_doc/practice_information_screen.dart';
import 'package:navi_doc/report_screen.dart';
import 'Services/api_call.dart';

class WorkRecords extends StatefulWidget {
  const WorkRecords({Key? key}) : super(key: key);

  @override
  _WorkRecordsState createState() => _WorkRecordsState();
}

class _WorkRecordsState extends State<WorkRecords> {
  late DateTime date, currentDate = DateTime.now();

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

  Widget _buildBody(BuildContext context){
    return Container(
        //margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height *0.07,
            color: Colors.indigo[900],
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
                  child: const Text('\t\t\t\t\t\t\t\t\t\t\t\t\tProcedures', style: TextStyle(
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
                  size: 28,
                  color: Colors.white,
                  ),
        onPressed: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (context) => AddWorkRecordScreen(workRecord: null, flag: true,)));
        },
        ),
 ),
              ],
            )
          ),
          const Text('Press "+" Button to Add Work Record'),
          Container(
            height: MediaQuery.of(context).size.height *0.7,
            child: Card(
              child: FutureBuilder(
                future: getWorkRecordData(context),
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
                        date = DateFormat("dd-MM-yyyy").parseStrict(snapshot.data[index].DueDate.toString());

                        return Column(
                          children: [
                            ListTile(
                                  title: Row(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width *0.25,
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(snapshot.data[index].HospitalName,),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(snapshot.data[index].SurgeryDate,
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.grey[700]
                                                  )),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(snapshot.data[index].PatientName,
                                                  style: TextStyle(
                                                      fontSize: 14, color: Colors.grey[700]
                                                  )),
                                            ),
                                            //             Row(
                                            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            //               children: [
                                            //                 Text("\u{20B9} "+snapshot.data[index].AmountCharged.toString()),
                                            // //               if (currentDate.compareTo(date) >= 0) Text("Due Date: "+snapshot.data[index].DueDate.toString(),
                                            // // style: const TextStyle(
                                            // // color: Colors.red,
                                            // // ),) else Text("Due Date: "+snapshot.data[index].DueDate.toString(),
                                            // //                 style: const TextStyle(
                                            // //                   color: Colors.black,
                                            // //                 ),),
                                            //               ],
                                            //             ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width *0.1,),
                                      Column(
                                        children: [
                                          //SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                                          if (currentDate.compareTo(date) >= 0) Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.indigo,
                                                width: 3.0,
                                              ),
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                            child: Text("\t\t\t\tDue On \n"+snapshot.data[index].DueDate.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.red,
                                              ),),
                                          ) else Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                              border: Border.all(
                                                color: Colors.indigo,
                                                width: 3.0,
                                              ),
                                              borderRadius: BorderRadius.circular(6.0),
                                            ),
                                            child: Text("\t\t\t\tDue On \n"+snapshot.data[index].DueDate.toString(),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  //Text(snapshot.data[index].HospitalName),
                                //   subtitle: Row(
                                //     children: [
                                //       Container(
                                //         width: MediaQuery.of(context).size.width *0.2,
                                //         child: Column(
                                //           children: <Widget>[
                                //             Align(
                                //               alignment: Alignment.centerLeft,
                                //               child: Text(snapshot.data[index].SurgeryDate),
                                //             ),
                                //             Align(
                                //               alignment: Alignment.centerLeft,
                                //               child: Text(snapshot.data[index].PatientName),
                                //             ),
                                // //             Row(
                                // //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // //               children: [
                                // //                 Text("\u{20B9} "+snapshot.data[index].AmountCharged.toString()),
                                // // //               if (currentDate.compareTo(date) >= 0) Text("Due Date: "+snapshot.data[index].DueDate.toString(),
                                // // // style: const TextStyle(
                                // // // color: Colors.red,
                                // // // ),) else Text("Due Date: "+snapshot.data[index].DueDate.toString(),
                                // // //                 style: const TextStyle(
                                // // //                   color: Colors.black,
                                // // //                 ),),
                                // //               ],
                                // //             ),
                                //           ],
                                //         ),
                                //       ),
                                //       SizedBox(width: MediaQuery.of(context).size.width *0.1,),
                                //       Column(
                                //         children: [
                                //           //SizedBox(height: MediaQuery.of(context).size.height *0.02,),
                                //           if (currentDate.compareTo(date) >= 0) Container(
                                //             decoration: BoxDecoration(
                                //               shape: BoxShape.rectangle,
                                //               color: Colors.white,
                                //               border: Border.all(
                                //                 color: Colors.indigo,
                                //                 width: 3.0,
                                //               ),
                                //                borderRadius: BorderRadius.circular(6.0),
                                //             ),
                                //             child: Text("\t\t\t\tDue On \n"+snapshot.data[index].DueDate.toString(),
                                //               style: const TextStyle(
                                //                 fontSize: 14,
                                //                 color: Colors.red,
                                //               ),),
                                //           ) else Container(
                                //             decoration: BoxDecoration(
                                //               shape: BoxShape.rectangle,
                                //               color: Colors.white,
                                //               border: Border.all(
                                //                 color: Colors.indigo,
                                //                 width: 3.0,
                                //               ),
                                //               borderRadius: BorderRadius.circular(6.0),
                                //             ),
                                //             child: Text("\t\t\t\tDue On \n"+snapshot.data[index].DueDate.toString(),
                                //               style: const TextStyle(
                                //                 fontSize: 14,
                                //                 color: Colors.black,
                                //               ),),
                                //           ),
                                //         ],
                                //       ),
                                //     ],
                                //   ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // IconButton(
                                      //   icon: Icon(
                                      //       Icons.edit
                                      //   ),
                                      //   onPressed: () {
                                      //     Navigator.push(context,
                                      //         MaterialPageRoute(builder: (context) => AddWorkRecordScreen(workRecord: workRecord, flag: true)));
                                      //   },
                                      // ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                        ),
                                        child: ElevatedButton(style: ElevatedButton.styleFrom(
                                  primary: Colors.green[900],),
                                          child: const Text('Received\n\t\t\t\t\t\tOn', style: TextStyle(
                                            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white
                                        ),),

                                          onPressed: () {

                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (context) => AddAmountScreen(workRecord: snapshot.data[index])));
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) => AddWorkRecordScreen(workRecord: snapshot.data[index], flag: false)));
                                  },
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
                          MaterialPageRoute(builder: (context) => const PracticeInformationScreen()));
                    },
                    child: const Text('Hospitals'),
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
        backgroundColor: Colors.white,
        //leading: const Icon(Icons.view_headline, color: Colors.black,),
        automaticallyImplyLeading: false,
        title: Image.asset('assets/images/navigo4.jpg', height: MediaQuery.of(context).size.height * 0.1, width: MediaQuery.of(context).size.width * 0.2,),
        // actions: <Widget>[
        //   _buildHeader(),
        //   _buildMsgHeader(),
        // ],
        shadowColor: Colors.white,
        elevation: 0,
      ),
      body: WillPopScope(
        onWillPop: () {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
    return Future.value(false);
    },
       child: _buildBody(context),
      ),
    );
  }
}
