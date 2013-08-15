/*
 * Writes a program that takes a floating point number from the user representing a sum of 
 * money (such as 15.47) and calculates the min imum number of coins required to equal it.
*/

library change_calculator; //using library as opposed to import

import 'dart:html';
import 'package:web_ui/web_ui.dart';

part "VO/currency_unit.dart"; //This says "take this file from the path, and make it part of THIS file here"

//Strings
const String DEFAULT_MSG = '<span class="label">Enter Values.</span>';
const String INVALID_INPUT = '<span class="label label-important">Invalid input.</span>';

//UI properties (these should typically have default values assigned here)
//AKA the stuff that binds/shows up in the HTML
@observable String convertOutputHeader = "Change"; //@observable is a tag used to show that you're binding it to HTML.
@observable String dollars = "";
@observable String gold = "";
@observable String convertMessage = DEFAULT_MSG;
@observable String totalMessage = DEFAULT_MSG;
@observable String outputTotal = "0.00 gp";
List<CurrencyUnit> outputUnits = toObservable([]); //we use the toObservable([]) function so that we can
//reuse the same list over and over, rather than having to switch between lists.
//@observable only observes the actual list, NOT the contents. Whereas toObservable() observes the contents!
//we could even put @observable at the top of our code, and that makes EVERY variable observable. (lazy)

//list of USD currency units
final List<CurrencyUnit> unitsUSD = [
  //new CurrencyUnit("dollar", 100, 1),
  new CurrencyUnit ("qurter", 25, 0.25),
  new CurrencyUnit("dime", 10, 0.1),
  new CurrencyUnit("nickel", 5, 0.05),
  new CurrencyUnit("penny", 1, 0.01)
];                                     

//list of DND currency units
final List<CurrencyUnit> unitsDnD = [  
  new CurrencyUnit ("platinum", 1000, 10),
  new CurrencyUnit("gold", 100, 1),
//new CurrencyUnit("electrum", 50, 0.5),
  new CurrencyUnit("silver", 10, 0.1),
  new CurrencyUnit("copper", 1, 0.01)
];                

//all a class really is, is a bunch of properties you can access by using a dot. (.) 
void main() {
  
}

void convertDollars() {
  if (convertToCoins(dollars, unitsUSD)) {
    outputConversion(unitsUSD, "USD");
  }
}

void convertGold() {
  if (convertToCoins(gold, unitsDnD)) {
    outputConversion(unitsDnD, "DnD");
  }
}

bool convertToCoins(String primaryUnitAmount, List<CurrencyUnit> units) {
  //the atomic amount is the value expressed in the system's most basic unit (pennies for USD)
  int atomicAmount;
  
  try {
    atomicAmount = (double.parse(primaryUnitAmount) * 100).round();
  }
  catch (e) {
    convertMessage = INVALID_INPUT;
    return false;
  }
  
  units.forEach((CurrencyUnit unit) {
    unit.qty = (atomicAmount / unit.atomicValue).floor(); //floor rounds down.
    atomicAmount %= unit.atomicValue; //%= means modulous, which does the above function, and returns the remainder.
  });
  
  convertMessage = DEFAULT_MSG;
  
  return true;
}

void outputConversion(List<CurrencyUnit> units, String headerText) {
  //send output to console
  print("\n");
  units.forEach((CurrencyUnit unit) => print(unit)); 

  //send output to web page
  convertOutputHeader = headerText;
  outputUnits.clear(); //we had to add the .clear() to clear the list, then .addAll(units) to repopulate with the new.
  outputUnits.addAll(units);
}

void calculateTotal() {
  double total = 0.0;
  
  try {
    unitsDnD.forEach((CurrencyUnit unit) {
      total += int.parse(unit.qtyStr) * unit.primaryValue;
    });
    
    totalMessage= DEFAULT_MSG;
    
    gold = total.toStringAsFixed(2);
    
    outputTotal = "${total.toStringAsFixed(2)} gp"; //this puts it into a string with 2 decimal places. (we set 2)
  }
  catch (e) {
    totalMessage = INVALID_INPUT;
  }
}


