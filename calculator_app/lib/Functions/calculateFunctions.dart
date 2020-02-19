import 'package:calculator_app/Storage/varialbes.dart';


class CalculateFunctions {

  void calculate(List<String> listOperations){
    if(listOperations.isNotEmpty){

      if(listOperations.last == "("){

          listOperations.removeLast();

      }

      if (listOperations.indexOf("(") != -1){

        int openIndex  = listOperations.lastIndexOf("(");
        int openIndexIside = listOperations.lastIndexOf("(")+1;
        
        int closeIndex,closeIndexInside;

        if(listOperations.sublist(openIndex, listOperations.length).indexOf(")") != -1){
          closeIndex = listOperations.sublist(openIndex,listOperations.length).indexOf(")") + openIndex+1;
          closeIndexInside = closeIndex-1;
        }
        else{
          closeIndex = listOperations.length;
          closeIndexInside = closeIndex;
        }

        List<String> inBracketsList = listOperations.sublist(openIndexIside, closeIndexInside);

        listOperations.replaceRange( openIndex, closeIndex, prioritySecond( priorityFirst(inBracketsList) ));
        
        calculate(listOperations);
        
      }
      else{

        operationsList = prioritySecond( priorityFirst(listOperations) );

      }

    }
  }


  List<String> priorityFirst(List<String> listOperations){

    int counter = 1;
    while(counter>0){

      counter = 0;
      
      for(int i = 0; i < listOperations.length-1; i++){

        if(listOperations[i] == "×"){

          listOperations.replaceRange(i-1, 
                                      i+2,
                                      [(double.parse(listOperations[i-1]) * double.parse(listOperations[i+1])).toString()] );

          i = i+2;
          counter++;
          continue;
          
        }

        if(listOperations[i] == "÷"){

          listOperations.replaceRange(i-1,
                                      i+2,
                                      [(double.parse(listOperations[i-1]) / double.parse(listOperations[i+1])).toString()] );

          i = i+2;
          counter++;
          continue;
          
        }

      }

    }

    return listOperations;

  }

  List<String> prioritySecond(List<String> listOperations){

    int counter = 1;
    while(counter>0){

      counter = 0;
      
      for(int i = 0; i < listOperations.length-1; i++){


        if(listOperations[i] == "+"){


          listOperations.replaceRange(i-1,
                                      i+2,
                                      [(double.parse(listOperations[i-1]) + double.parse(listOperations[i+1])).toString()] );

          i = i+2;
          counter++;
          continue;
          
        }

        if(listOperations[i] == "-"){

          if(i == 0){

            listOperations.replaceRange(i,
                                        i+2,
                                        [(-1 * double.parse(listOperations[i+1])).toString()]);

          }
          else{

            listOperations.replaceRange(i-1,
                                      i+2,
                                      [(double.parse(listOperations[i-1]) - double.parse(listOperations[i+1])).toString()] );

          }

          i = i+2;
          counter++;
          continue;
          
        }

      }

    }

    return listOperations;

  }

}