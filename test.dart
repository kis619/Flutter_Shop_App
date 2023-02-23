class Mammal {
  void breathe() {
    print('breathe in mamal');
  }
}

mixin Ability {
  var speed = 10;

  void sleep() {
    print("sleep");
  }
}

class Person extends Mammal with Ability {
  String? name;
  int? age;

  Person(this.name, this.age);

  // @override
  // void breathe() {
  //   print("breathe in human");
  // }
}

void main() {
  final pers = Person('Max', 30);
  pers.breathe();
  pers.sleep();
}
