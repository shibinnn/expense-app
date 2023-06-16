import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'expence.dart';


class providerr extends ChangeNotifier {
  DateTime selectedDate = DateTime.now();
  Future<List<String>?> getreason(key) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getStringList(key);
  }

  Future<List<String>?> getamount(key) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getStringList(key + 'amount');
  }

  Future<List<String>?> gettime(key) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getStringList(key + 'time');
  }

  Future<Future<bool>> savereason(List<String> reason, {String? key}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setStringList(key!, reason);
  }

  Future<Future<bool>> saveamount(List<String> amount, {String? key}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setStringList('${key!}amount', amount);
  }

  Future<Future<bool>> savetime(List<String> time, {String? key}) async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.setStringList('${key!}time', time);
  }

  abc(BuildContext context) {
   
 
     String newreason = reasonController.text;
     double newamount = double.tryParse(amountController.text) ?? 0;
     String newtime = timeController.text;

     reason.add(newreason);
     savereason(reason,
       key: DateFormat("yyyy-MM-dd").format(selectedDate).toString());

     amount.add(newamount.toStringAsFixed(2));
     saveamount(amount,
       key: '${DateFormat("yyyy-MM-dd").format(selectedDate)}Amount');

     time.add(newtime);
     savetime(time,
       key: '${DateFormat("yyyy-MM-dd").format(selectedDate)}Time');

     total += newamount.toInt();
     expense += newamount;
    Navigator.pop(context);
    notifyListeners();
  }
    pvd(int index) {
    reason.clear();
    time.clear();
    amount.clear();
    buttonindex = index;
    currentDateSelectedIndex = index;
    selectedDate = DateTime.now().add(Duration(days: index));

    notifyListeners();
  }


  pro() {
     getreason(DateFormat("yyyy-MM-dd")
                                    .format(selectedDate)
                                    .toString())
                                .then((value) {
                              reason = value!;
                            });
                            
                            gettime('${DateFormat("yyyy-MM-dd")
                                        .format(selectedDate)}Time')
                                .then((value) {
                              time = value!;
                            });
                            
                            getamount('${DateFormat("yyyy-MM-dd")
                                        .format(selectedDate)}Amount')
                                .then((value) {
                              amount = value!;
                              notifyListeners();
                            });
  }
}