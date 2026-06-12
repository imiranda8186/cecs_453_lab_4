import 'package:flutter/material.dart';

void main() {
  runApp(const CalcApp());
}


class Mortgage{
  int amount;
  int years;
  double interest;

  Mortgage({
    required this.amount,
    required this.years,
    required this.interest
  });

}
class CalcApp extends StatelessWidget { 
  const CalcApp({super.key}); 
  @override 
  Widget build(BuildContext context) { 
    return MaterialApp( 
      debugShowCheckedModeBanner: false, 
      title: 'Mortgage Calculator', 
      home: DetailsScreen(), 
    ); 
  } 
}

class DetailsScreen extends StatefulWidget{
  @override
  _DetailsScreenState createState() => _DetailsScreenState();

}

class _DetailsScreenState extends State<DetailsScreen> {
    int yearselection = 10;
    final TextEditingController _amountController = TextEditingController();
    final List<double> _rates = [0.02, 0.0225, 0.0250, 0.0275, 0.03,
                                  0.0325, 0.035, 0.0375, 0.04,
                                  0.0425, 0.045, 0.0475, 0.05,
                                  0.0525, 0.055, 0.0575, 0.06,
                                  0.0625, 0.065, 0.0675, 0.07,
                                  0.0725, 0.075, 0.0775, 0.08,
                                  0.0825, 0.085, 0.0875, 0.09,
                                  0.0925, 0.095, 0.0975, 0.10,
                                  0.1025, 0.105, 0.1075, 0.11,
                                  0.1125, 0.115, 0.1175, 0.12,
                                  0.1225, 0.125, 0.1275, 0.13,
                                  0.1325, 0.135, 0.1375, 0.14,
                                  0.1425, 0.145, 0.1475, 0.15,];

    @override 
    void dispose(){
      _amountController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Text("Enter details for calculation")
          ),

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ResultsScreen(),
                          )
                      );
                    },
                    child: const Text('Calculate', style: TextStyle(fontSize: 20, color: Colors.white)),
                  )
              ]

            )

        )
      );
    }
}

class ResultsScreen extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Calculated results")
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

            ]

          )

        )
    );
  }
}