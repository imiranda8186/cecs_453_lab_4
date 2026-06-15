import 'package:flutter/material.dart';
//Have to add dart math import to do the payment calculations
import 'dart:math';

void main() {
  runApp(const CalcApp());
}


class Mortgage{
  double amount;
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
  State<DetailsScreen> createState() => _DetailsScreenState();

}

class _DetailsScreenState extends State<DetailsScreen> {
    //defining the values for the year selection and rates, and creating the TextEditingController
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

    //formKey for the text field
    final _formKey = GlobalKey<FormState>();
    double? _selectedValue = 0.02;

    //dispose function for the controller
    @override 
    void dispose(){
      _amountController.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context){
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: Text("Enter details for calculation")
          ),

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                //Adding the radio button for the years selection
                RadioGroup<int>(
                  groupValue: yearselection,
                  onChanged: (val) => setState(() => yearselection = val!),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Year Selection: '),
                      Radio<int>(value: 10),
                      Text('10'),
                      Radio<int>(value: 15),
                      Text('15'),
                      Radio<int>(value: 30),
                      Text('30')
                    ]
                  )
                ),

                //The row for storing the text field
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 80, child: Text('Amount')),
                    SizedBox(
                      width: 240,
                      //Using a Form with validation to ensure the value is a double
                      //Makes sure app doesn't crash when try to pass in the values to
                      //The next screen
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                            controller: _amountController,
                            decoration: InputDecoration(
                              labelText: 'Enter amount'
                            ),
                            //This is what's used to check if the value is actually entered
                            validator: (value){
                              if (value==null || value.isEmpty){
                                return 'Enter an amount';
                              }

                              //This is the logic to check to see if it's a valid double
                              if (double.tryParse(value) == null) {
                                return 'Enter a valid number in decimal form';
                              }

                              //If both conditions are met, it's a valid value
                              return null;
                            }
                          )
                        )
                      ) 
                  ]
                ),


                //The drop down button to select the interest rate
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Select the yearly interest rate:'),
                    SizedBox(width: 20),
                    DropdownButton<double>(
                      value: _selectedValue,
                      items: _rates.map((double rate){
                        return DropdownMenuItem<double>(
                          value: rate,
                          child: Text(rate.toString()),
                        );
                      }).toList(),
                      onChanged: (double? newValue) {
                        setState((){
                          _selectedValue = newValue;
                        });
                      },
                    ),
                  ]
                ),
                
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onPressed: (){
                  //Check to see that the text field has a valid number inside it 
                  if (_formKey.currentState!.validate()){
                    //Create the object to be used in the next screen
                    final mortgage = Mortgage(
                      //Still have to parse the text field into a double, since it's stored as a string
                      amount: double.parse(_amountController.text),
                      years: yearselection,
                      interest: _selectedValue!
                    );

                    //Only navigates if the fields have the correct values
                    Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ResultsScreen(mortgage: mortgage),
                          )
                      );
                    }//End of validator logic
                  },
                    child: const Text('Calculate Payments', style: TextStyle(fontSize: 20, color: Colors.white)),
                  )
              ]

            )

        )
      );
    }
}

//Results screen takes in the newly created object and displays its contents
class ResultsScreen extends StatefulWidget{
  //Creating and passing in the object from the previous screen
  final Mortgage mortgage;
  const ResultsScreen({super.key, required this.mortgage});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {

  //Value used for the checkbox
  bool terms = false;

  @override
  Widget build(BuildContext context){

    //Payment is calculated here
    final double principal = widget.mortgage.amount;
    final double rate = widget.mortgage.interest /12;
    final int numberOfPayments = widget.mortgage.years * 12;

    final double monthlyPayment = principal * rate * pow(1 + rate, numberOfPayments) /
    (pow(1 + rate, numberOfPayments) -1);

    final double totalPayment = monthlyPayment * numberOfPayments;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Calculated results")
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Need to access the data using widget.mortgage
              //State object doesn't have the data, only the actual class does
              Text('Amount: ${widget.mortgage.amount}', style: TextStyle(fontSize: 20)),
              Text('Years: ${widget.mortgage.years}', style: TextStyle(fontSize: 20)),
              Text('Yearly Interest Rate: ${widget.mortgage.interest}', style: TextStyle(fontSize: 20)),


              SizedBox(height: 80),


              //Payment is shown here
              Text('Monthly Payment: \$${monthlyPayment}'),
              Text('Total Payment: \$${totalPayment}'),

              SizedBox(height: 80),

              //Checkbox for Terms and Conditions
              CheckboxListTile(
                title: Text('Accept Terms and Conditions'),
                value: terms,
                checkColor: Colors.white,
                activeColor: Colors.green,
                onChanged: (bool? value) {
                  setState((){
                    terms = value!;
                  });
                  if (value == true) {
                    showDialog(context: context, 
                      builder: (context) => AlertDialog(
                        title: Text('Terms and Conditions'),
                        content: Text('Accepted Terms and Conditions'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK') 
                          )
                        ]

                      ));
                  }
                },
              ),

              SizedBox(height: 80),

              ElevatedButton(
                  style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Return to details screen', style: TextStyle(fontSize: 20, color: Colors.white))
                  )


            ]

          )

        )
    );
  }
}