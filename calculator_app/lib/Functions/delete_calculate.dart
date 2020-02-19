import 'package:calculator_app/Storage/varialbes.dart';


class CalculateFunctions {

  void calculate(List<String> listOperations){
    if(listOperations.isNotEmpty){


      if (listOperations.indexOf("(") != -1){

        if(listOperations.indexOf("(") == listOperations.length){
          listOperations.removeLast();
        }
        
        List<String> inBracketsList = listOperations.sublist(listOperations.indexOf("(")+1, listOperations.lastIndexOf(")") != -1 ? listOperations.lastIndexOf(")"): listOperations.length);

        listOperations.replaceRange(listOperations.indexOf("("),
                                    listOperations.lastIndexOf(")") != -1 ? listOperations.lastIndexOf(")")+1: listOperations.length,
                                    prioritySecond(priorityFirst(inBracketsList)));
        calculate(listOperations);
        
      }
      else{

        operationsList = prioritySecond(priorityFirst(listOperations));

      }

    }
  }


  List<String> priorityFirst(List<String> listOperations){

    int counter = 1;
    while(counter>0){

      counter = 0;
      
      for(int i = 0; i < listOperations.length-2; i++){

        if(listOperations[i] == "*"){

          listOperations.replaceRange(i-1, 
                                      i+1,
                                      [(double.parse(listOperations[i-1]) * double.parse(listOperations[i+1])).toString()] );
          counter++;
          continue;
          
        }

        if(listOperations[i] == "/"){

          listOperations.replaceRange(i-1,
                                      i+1,
                                      [(double.parse(listOperations[i-1]) / double.parse(listOperations[i+1])).toString()] );
          counter++;
          continue;
          
        }

      }

    }

    print(listOperations);
    return listOperations;

  }

  List<String> prioritySecond(List<String> listOperations){

    int counter = 1;
    while(counter>0){

      counter = 0;
      
      for(int i = 0; i < listOperations.length-2; i++){


        if(listOperations[i] == "+"){

          listOperations.replaceRange(i-1,
                                      i+1,
                                      [(double.parse(listOperations[i-1]) + double.parse(listOperations[i+1])).toString()] );
          counter++;
          continue;
          
        }

        if(listOperations[i] == "-"){

          listOperations.replaceRange(i-1,
                                      i+1,
                                      [(double.parse(listOperations[i-1]) - double.parse(listOperations[i+1])).toString()] );
          counter++;
          continue;
          
        }

        if(listOperations[i] == "%"){

          listOperations.replaceRange(i-1, i+1, [(double.parse(listOperations[i-1]) % double.parse(listOperations[i+1])).toString()] );
          counter++;
          continue;

        }

      }

    }

    print(listOperations);
    return listOperations;

  }

}