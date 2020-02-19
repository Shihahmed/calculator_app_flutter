
import 'package:calculator_app/Storage/varialbes.dart';


class FormatOperations {


  bool isOperation(String str){

    if( str == "÷" || str == "×" || str == "-" || str == "+" )
      return true;
    else
      return false;

  }

  void addDigit(String digit){

    if(equalPressed) {
      operationsListBufer.clear();
      equalPressed = false;
    }

    if (operationsListBufer.length>0 ){

      if (operationsListBufer.last != ")")
      operationsListBufer.add(digit);

    }
    else{

      operationsListBufer.add(digit);

    }
    
  }

  void addDot(String operation){

    if(operationsListBufer.isEmpty){

      operationsListBufer.add("0");
      operationsListBufer.add(operation);

    }

    if(operationsListBufer != null && operationsListBufer.length>0  && (operationsListBufer.last != "(" && operationsListBufer.last != ")")){

      bool haveDot = false;
      for(int i = operationsListBufer.length-1; i>0 ; i--){
        if (isOperation(operationsListBufer[i])){
          break;
        }
        else if(operationsListBufer[i] == "."){
          haveDot = true;
        }
      }

      if(!haveDot){

        if ( isOperation(operationsListBufer[operationsListBufer.length-1]) || operationsListBufer.last == "." ){
          
          bool haveDot = false;
          for(int i = operationsListBufer.length-2; i>0 ; i--){

            if (isOperation(operationsListBufer[i])){
              break;
            }
            else if(operationsListBufer[i] == "."){
              haveDot = true;
            }
          }

          if((!haveDot)){

            operationsListBufer.removeLast();
            operationsListBufer.add(operation);

          }
          

        }
        else  {
          operationsListBufer.add(operation);
        }

      }

    }

  }

  void addOperation(String operation){
    
    if(equalPressed) {
      equalPressed = false;
    }

    if(operationsListBufer != null && operationsListBufer.length>0){

      if ( isOperation(operationsListBufer[operationsListBufer.length-1]) || operationsListBufer[operationsListBufer.length-1] == "."){

        if ( operationsListBufer[operationsListBufer.length-2] == "(" && operation == "-" ){

          operationsListBufer.removeLast();
          operationsListBufer.add(operation);

        }
        else if (operationsListBufer[operationsListBufer.length-2] != "("){

          operationsListBufer.removeLast();
          operationsListBufer.add(operation);

        }

      }
      else{

        if ( operationsListBufer.last == "(" && operation == "-" ){

          operationsListBufer.add(operation);

        }
        else if (operationsListBufer.last != "("){

          operationsListBufer.add(operation);

        }
        

      }


    }

  }

  void addBrackets(){

      if(equalPressed) {
        operationsListBufer.clear();
        equalPressed = false;
      }

      if ( operationsListBufer.isEmpty || isOperation(operationsListBufer.last) ){
        operationsListBufer.add("(");
      }
      else{
        int counterOpen  = 0;
        int counterClose = 0;

        for(String operation in operationsListBufer){
          if(operation == "(") counterOpen++;
          if(operation == ")") counterClose++;
        }

        if(counterClose < counterOpen){
          operationsListBufer.add(")");
        }


      }

  }
    
  void deleteLast(){

    if(operationsListBufer != null && operationsListBufer.length>0){
      operationsListBufer.removeLast();

    }

  }

  void deleteAll(){

    if (operationsListBufer.isEmpty){
      historyList.clear();
      historyListBufer.clear();
    }

    operationsListBufer.clear();

    cangeAC();
  

  }

  void splitListBufer(){

    String numbers = "";
    operationsList = [];

    if(operationsListBufer.length>0){

      for(String operation in operationsListBufer ){

        if (isOperation(operation) || (operation == "(" || operation == ")") ){

          if (numbers.isNotEmpty){
            operationsList.add(numbers);
          }

          operationsList.add(operation);
          numbers = "";
        }
        else if(operation == "%" && numbers.isNotEmpty){

          numbers = (double.parse( numbers) / 100 ).toString();

        }
        else if(operation != "%"){

          numbers += operation; 

        } 

      }

      if (numbers.isNotEmpty){

        operationsList.add(numbers);

      }

    }

  }

  void setCommas(){

    operations = "0";
    if(operationsList != null && operationsList.length>0){

      operations = "";
      
      for(String operation in operationsList){

        bool haveDot = false;
        int positionDot = 0;
        int counter = 1;
        String operationWithCommas = "";

        if(isOperation(operation)){

          operationWithCommas += operation;

        }
        else{

          for(int i = operation.length-1; i >= 0 ; i-- ){
            if (operation[i] == "."){
              haveDot = true;
              positionDot = i;
              break;
            }
          }

          if(haveDot){
            

            for (int i = operation.length-1; i >= positionDot ; i--) {
              operationWithCommas = operation[i] + operationWithCommas; 
            }
            

            for (int i = positionDot-1; i >= 0 ; i--) {
              if (counter == 3 && i != 0){
                operationWithCommas = "," + operation[i] + operationWithCommas;
                counter = 0;
              }
              else{
                operationWithCommas = operation[i] + operationWithCommas;
              }

              counter++;
            }

          }
          else{

            for (int i = operation.length-1; i >= 0 ; i--) {
              if (counter == 3 && i != 0){
                operationWithCommas = "," + operation[i] + operationWithCommas;
                counter = 0;
              }
              else{
                operationWithCommas = operation[i] + operationWithCommas;
              }
              
              counter++;
            }
            
          }

        }

        operations += operationWithCommas;

      }

    }

  }

  void formatAnswer(String rawAnswer){

    bool haveDot = false;
    bool haveMinus = false;
    int positionDot = 0;
    int counter = 1;
    String answerWithCommas = "";

    if (rawAnswer != "0" && rawAnswer[rawAnswer.length-1] == "0" && rawAnswer[rawAnswer.length-2] == "."){
      rawAnswer = rawAnswer.substring(0,rawAnswer.length-2);
    }

    if(rawAnswer[0]=="-"){
      rawAnswer = rawAnswer.substring(1,rawAnswer.length);
      haveMinus = true;
    } 

    for(int i = rawAnswer.length-1; i >= 0 ; i-- ){
      if (rawAnswer[i] == "."){
        haveDot = true;
        positionDot = i;
        break;
      }
    }

    if(haveDot){
      
      for (int i = rawAnswer.length-1; i >= positionDot ; i--) {
        answerWithCommas = rawAnswer[i] + answerWithCommas; 
      }
      
      for (int i = positionDot-1; i >= 0 ; i--) {
        if (counter == 3 && i != 0){
          answerWithCommas = "," + rawAnswer[i] + answerWithCommas;
          counter = 0;
        }
        else{
          answerWithCommas = rawAnswer[i] + answerWithCommas;
        }

        counter++;
      }

    }
    else{

      for (int i = rawAnswer.length-1; i >= 0 ; i--) {
        if (counter == 3 && i != 0){
          answerWithCommas = "," + rawAnswer[i] + answerWithCommas;
          counter = 0;
        }
        else{
          answerWithCommas = rawAnswer[i] + answerWithCommas;
        }
        
        counter++;
      }
      
    }

    if(haveMinus){
      answerWithCommas = "-" + answerWithCommas;
    }

    answer = answerWithCommas;

  }

  void cangeAC(){

    if (operationsListBufer.isEmpty){
      cOrAC = "AC";
    }
    else{
      cOrAC = "C";
    }

  }
  
}
