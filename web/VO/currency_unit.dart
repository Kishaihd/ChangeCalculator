//this is a part of the change calculator program
part of change_calculator;

class CurrencyUnit {
  final String name; //final flags the variable saying once it's assigned, it cannot be changed. New to Dart
  final int atomicValue; //value compared to atomic currency unit for the system (pennies in USD)
  final num primaryValue; //value compared to primary currency unit for the system (dollars in USD)
  int qty = 0;
  @observable String qtyStr = "0";

  //this type of function is called a constructor. Has no return value.
  CurrencyUnit(this.name, this.atomicValue, this.primaryValue);
  
//this is another way to write the above function.
  /*CurrencyUnit(this.name, this.atomicValue, this.primaryValue) {
  *
  * }
  */
  
//This is the loooong way to write the active one-liner above.
//  CurrencyUnit(String name, int atomicValue, num primaryValue) {
//     this.name = name;
//     this.atomicValue = atomicValue;
//     this.primaryValue = primaryValue;
//   }
  
  
  
  
  String toString() {
    return "$name: $qty";
  }
}











