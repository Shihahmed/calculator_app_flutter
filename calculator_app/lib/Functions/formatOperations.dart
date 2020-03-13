
import 'package:calculator_app/Storage/varialbes.dart';


class FormatOperations {


  bool isOperation(String str){

    if( str == "÷" || str == "×" || str == "-" || str == "+" )
      return true;
    else
      return false;

  }

  void addDigit(String digit){

    if(isEqualPressed) {
      operationsListBufer.clear();
      isEqualPressed = false;
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
    
    if(isEqualPressed) {
      isEqualPressed = false;
    }

    if( operationsListBufer != null && operationsListBufer.length>0){

      if ( isOperation(operationsListBufer.last) || operationsListBufer.last == "."){

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

  void addPercent(){

    if( operationsListBufer.isNotEmpty && operationsListBufer.length>0
         && !isOperation(operationsListBufer.last) && operationsListBufer.last != "(" && operationsListBufer.last != ")"){

      operationsListBufer.add("%");

    }

  }

  void addBrackets(){

      if(isEqualPressed) {
        operationsListBufer.clear();
        isEqualPressed = false;
      }

      if ( operationsListBufer.isEmpty || isOperation(operationsListBufer.last) || operationsListBufer.last == "(" ){
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

          if (operationsList.isNotEmpty && isOperation(operationsList.last)){
            
            numbers = (double.parse( operationsList[operationsList.length-2]) / 100 * double.parse(numbers) ).toString();

            if(numbers[numbers.length-1] == "0" && numbers[numbers.length-2] == "." ){

              numbers = numbers.substring(0, numbers.length-2);

            }

          }
          else{
            numbers = (double.parse( numbers) / 100 ).toString();

            if(numbers[numbers.length-1] == "0" && numbers[numbers.length-2] == "." ){

              numbers = numbers.substring(0, numbers.length-2);

            }

          }

        }
        else if(operation != "%" && operation.isNotEmpty){

          numbers += operation; 

        }  

      }

      if (numbers.isNotEmpty){
        
        bool dotInEnd = false;
        bool dotAndZetoInEnd = false;
        
        if (numbers[numbers.length-1] == ".") dotInEnd = true;


        if(numbers.length >1 && numbers[numbers.length-1] == "0" && numbers[numbers.length-2] == ".") dotAndZetoInEnd = true;


        numbers = double.parse(numbers).toString();


        if(!dotInEnd){

          if(numbers[numbers.length-1] == "0" && numbers[numbers.length-2] == "."){

            numbers = numbers.substring(0, numbers.length-2);

          }

        }

        if(dotInEnd){

          if(numbers[numbers.length-1] == "0" && numbers[numbers.length-2] == "."){

            numbers = numbers.substring(0, numbers.length-2);

          }
        
          numbers += ".";
        } 

        if(dotAndZetoInEnd){

          numbers += ".0";

        }

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
                operationWithCommas = " " + operation[i] + operationWithCommas;
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
                operationWithCommas = " " + operation[i] + operationWithCommas;
                counter = 0;
              }
              else{
                operationWithCommas = operation[i] + operationWithCommas;
              }
              
              counter++;
            }
            
          }

        }

        if(operationWithCommas == "In fin ity"){
          operationWithCommas = "∞";
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
          answerWithCommas = " " + rawAnswer[i] + answerWithCommas;
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
          answerWithCommas = " " + rawAnswer[i] + answerWithCommas;
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

    if(answerWithCommas == "In fin ity"){
      answerWithCommas = "∞";
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
