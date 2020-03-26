
import 'package:calculator_app/Functions/calculateFunctions.dart';
import 'package:flutter/material.dart';
import 'package:calculator_app/Functions/formatOperations.dart';
import 'package:calculator_app/Storage/varialbes.dart';

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MainPage());
  }
  
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class CostomBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}


class _MainPageState extends State<MainPage> {

  void changeState(){
    setState(() {

      if (!isEqualPressed){
        answerFont = 26;
      }

      FormatOperations().splitListBufer();
      FormatOperations().setCommas();
      
      CalculateFunctions().calculate(operationsList);
      
      FormatOperations().formatAnswer( (operationsList.length > 0) ? operationsList[0] : "0" );
      FormatOperations().cangeAC();

    });
  }
  
  //UI
  @override
  Widget build(BuildContext context) {

    return SafeArea(
            child:Scaffold(
              
                backgroundColor: Colors.black87,
              
                body: 
                   Column(
                     children: [

                       
                      Expanded(
                        child: ScrollConfiguration(
                          behavior: CostomBehavior(),

                          child: ListView.builder( 
                            

                            reverse: true, 
                            
                            itemCount: historyList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                        onTap: (){
                                          operationsListBufer =  historyListBufer[index] + [];

                                          changeState();
                                        },
                                        title: Column( children: <Widget>[
                                                  Align(alignment: Alignment(0.9,1),  child: Text( historyList[index][0] , style: TextStyle(color: Colors.grey, fontSize: 24))),
                                                  Align(alignment: Alignment(0.9,1),  child: Text("= "+ historyList[index][1], style: TextStyle(color: Colors.grey, fontSize: 20))),
                                        ],),
                                                    
                                    );
                            } 
                          )
                      ),),
                       

                      Container(height: 4),

                      Align(alignment: Alignment(0.8,1),
                          
                        child: SingleChildScrollView(

                                scrollDirection: Axis.horizontal,reverse: true ,
                                child:Text( operations , style: TextStyle(color: Colors.white, fontSize: 28)),

                              )
                          
                      ),

                       Align(alignment: Alignment(0.8,1),
                            
                          child: Text("= "+ answer, style: TextStyle(color: Colors.white, fontSize: answerFont))
                            
                        ),

                       //keyboard
                       Table(
                        children: [
                        TableRow(
                          children: [
                                    FlatButton(

                                      child: Text( cOrAC , style: TextStyle(color: Colors.red,fontSize: 26)),
                                      color: Colors.black,
                                      onPressed:(){
                                        FormatOperations().deleteAll();
                                        changeState();
                                       }

                                    ),
                                     FlatButton(
                                      child: Icon(
                                                  Icons.trending_flat,
                                                  textDirection:  TextDirection.rtl,
                                                  color: Colors.white,
                                                  size: 25.0
                                                ),

                                      color: Colors.black87,
                                      shape: StadiumBorder(side: BorderSide(color: Colors.white,width: 0.8 )),
                                      onPressed: (){
                                        FormatOperations().deleteLast();
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("%", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addPercent();
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      
                                      child: Text("÷", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addOperation("÷");
                                        changeState(); 
                                      }
                                    ),
                          ]
                        ),
                         TableRow(
                          children: [
                                    FlatButton(
                                      child: Text("7", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("7"); 
                                        changeState();
                                      }

                                    ),
                                     FlatButton(
                                      child: Text("8", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("8");
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("9", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("9");
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      onPressed: (){
                                        FormatOperations().addOperation("×"); 
                                        changeState();
                                      },
                                      child: Text("×", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                    ),
                          ]
                        ),
                         TableRow(
                          children: [
                                    FlatButton(
                                      child: Text("4", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("4"); 
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("5", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("5"); 
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("6", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("6"); 
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("-", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addOperation("-");
                                        changeState();
                                      }
                                    ),
                          ]
                        ),
                         TableRow(
                          children: [
                                    FlatButton(
                                      child: Text("1", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("1");
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("2", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("2");
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("3", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("3"); 
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text("+", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addOperation("+");
                                        changeState();
                                      },
                                    ),
                          ]
                        ),
                         TableRow(
                          children: [
                                    FlatButton(
                                      child: Text("( )", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addBrackets();
                                        changeState();
                                      },
                                    ),
                                     FlatButton(
                                      child: Text("0", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDigit("0");
                                        changeState();
                                      }
                                    ),
                                     FlatButton(
                                      child: Text(".", style: TextStyle(color: Colors.white,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){
                                        FormatOperations().addDot(".");
                                        changeState();
                                      },
                                    ),
                                     FlatButton(
                                      child: Text("=", style: TextStyle(color: Colors.red,fontSize: 26)),
                                      color: Colors.black87,
                                      onPressed: (){

                                            if(operationsListBufer.length>0){

                                              setState(() {
                                                historyList = [[operations,answer]] + historyList;
                                                historyListBufer = [operationsListBufer+[]] + historyListBufer;

                                                answerFont = 36;
                                              });

                                              operationsListBufer.clear();

                                              if(answer == "∞"){
                                               
                                                operationsListBufer.add("Infinity");

                                              }
                                              else{

                                                operationsListBufer.add(answer.replaceAll(" ", ""));

                                              }
                                              
                                              isEqualPressed = true;

                                            }                                          
                                            
                                      }
                                    ),
                  ]
                )
              ],         
            )
          ]
        ) 
      )
    );
  }
}

