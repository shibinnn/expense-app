import 'package:expence_app/my_widget_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
//  import 'package:shared_preferences/shared_preferences.dart';

 List<String> reason = [];
  List<String> amount = [];
  List<String> time = [];
  int total = 0;
double remainingBalance = 5000;
double expense = 0;
 DateTime selectedDate = DateTime.now(); // TO tracking date
  int currentDateSelectedIndex = 0; 
   int buttonindex = -1;
   
  TextEditingController reasonController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController timeController = TextEditingController();

class MyWidget extends StatefulWidget {
    

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  

  List<String> months = [
    "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
  ]; 
  
  final List<String> days = [ "Mon", "Tue", "Wed", "Thu", "Fri", "Sat","sun"];
  
   List<Color> colors = [
  const Color.fromRGBO(137, 244, 232, 1),
  const Color.fromRGBO(166, 159, 199, 1),
  const Color.fromRGBO(145, 182, 205, 1),
  const Color.fromARGB(255, 220, 133, 127),
  const Color.fromARGB(255, 77, 116, 148),
  const Color.fromARGB(255, 91, 96, 98),
  const Color.fromARGB(255, 106, 203, 133),
  const Color.fromARGB(255, 221, 153, 220)
  ];

  @override
  Widget build(BuildContext context) {
   final myprovider=Provider.of<providerr>(context);
   myprovider.pro();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Container(
              height: 35,
              margin: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                '${months[myprovider. selectedDate.month - 1]} ${myprovider. selectedDate.year}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            // SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  365,
                  // days.length,
                  (index) => Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FloatingActionButton(
                          backgroundColor: currentDateSelectedIndex == index
                                  ? Colors.black
                                  : Colors.grey[400],
                          onPressed: () {
                            myprovider.pvd(index);
                            myprovider.pro();
                        },
                          child: Text(
                            DateTime.now()
                                        .add(Duration(days: index))
                                        .day
                                        .toString(),
                            style: TextStyle(
                              color:currentDateSelectedIndex == index
                            ? Colors.white
                           : Colors.black),
                          ),
                        ),
                      ),
                      Text(
                              days[DateTime.now()
                                          .add(Duration(days: index))
                                          .weekday - 1]
                                  .toString(),
                              style:const TextStyle(fontSize: 15, color: Colors.black),
                            ),
                    ],
                  ),
                ).toList(),
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(right: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                 Text('Remaining Balance : ' '${remainingBalance - total}'),
                  Text('Expense : ' '$total')
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                height: 489,
                color: Colors.white,
                child: ListView.builder(
                    itemCount: reason.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            height: 80,
                            width: 330,
                            decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: 80,
                                  width: 250,
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          height: 25,
                                          width: 50,
                                          child: Icon(Icons.restore)),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            reason[index],
                                            style: const TextStyle(fontSize: 17),
                                          ),
                                          Text(time[index]),
                                          // "hrcuk"),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 80,
                                  width: 80,
                                  color: Colors.transparent,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        '',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22),
                                      ),
                                      Text(
                                        amount[index],
                  
                                        // "hjwbi",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ],
        ),
       
           floatingActionButton: FloatingActionButton(
             backgroundColor: Colors.black,
             onPressed: () {
               Dialog errorDialog = Dialog(
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20),
                 ),
                 child: SizedBox(
                   height: 260,
                   width: 300,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           const Text('add new expence',
                           style: TextStyle(fontSize: 15),
                           ),
                           const SizedBox(height: 20),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: TextField(
                 controller: reasonController,
                 decoration: const InputDecoration(
                   hintText: 'Reason',
                   border: InputBorder.none,
                   filled: true,
                   fillColor:Color.fromARGB(255, 207, 207, 207)
                 ),
               ),
             ),
             const SizedBox(height: 25),
             Row(
               children: [
                 Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: TextField(
                   controller: amountController,
                   decoration: const InputDecoration(
                     hintText: 'amount',border: InputBorder.none,filled: true,fillColor:Color.fromARGB(255, 207, 207, 207),
                   ),
                   keyboardType: TextInputType.number,
                   inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                   onSubmitted: (String value) {
                    //  setState(() {
                    //    expense += enteredAmount;
                    //    remainingBalance -= enteredAmount;
                    //  });
                     amountController.clear();
                   },
                 ),
                 )
                 ),
                 const SizedBox(width: 10),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: TextField(
                       controller: timeController,
                        decoration: const InputDecoration(
                 hintText: 'Time',
                 border: InputBorder.none,
                 filled: true,
                 fillColor: Color.fromARGB(255, 207, 207, 207),
               ),
                onTap: () async {
                 // Show a clock popup and wait for user input
                 TimeOfDay? selectedTime = await showTimePicker(
                   context: context,
                   initialTime: TimeOfDay.now(),
                 );
    
                 // Update the TextField with the selected time
                 if (selectedTime != null) {
                   timeController.text = selectedTime.format(context);
                 }
               },
                     ),
                     ))
               ],
             ),
              const SizedBox(height: 20),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
               ElevatedButton(
                         onPressed: () {
                           Navigator.of(context).pop();
                         },
                         child: const Text('Cancel'),
                       ),
                        ElevatedButton(
                        onPressed: () {
   myprovider.abc(context);
},
                         child: const Text('Add'),
                       ),
                       ],
              )
                         ],
                       )
                     ],
                   ),
                 ),
               );
           
               showDialog(
                 barrierDismissible: true,
                 context: context,
                 builder: (BuildContext context) => errorDialog,
               );
             },
             child: const Icon(Icons.add),
           ),
       ),
    );
  }
}