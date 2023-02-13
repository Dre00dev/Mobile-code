import 'package:flutter/material.dart';
import 'package:mobilecode/services/models.dart';
import 'package:provider/provider.dart';


//note _name means private otherwise its public...
//copied format to implementations in ds
class QuizState with ChangeNotifier {
  //private
  double _progress = 0;
  Option? _selected;  //use ? to indicate _selected can be null

 
  //public
  final PageController controller = PageController();  //controller 
  //getters
  double get progress => _progress;
  Option? get selected => _selected;

  //setters


  set progress(double newValue) {  //sets the value in the progress bar
    _progress = newValue;
    notifyListeners();  //will rerender when this data changes
  }

  set selected(Option? newValue) {  //the current option user selected.
    _selected = newValue;
    notifyListeners();  //rerenders when data data changes
  }
  
   void nextPage() async {
    await controller.nextPage( //awaits this call to change page
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

}