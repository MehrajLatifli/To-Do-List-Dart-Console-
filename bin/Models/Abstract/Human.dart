abstract class Human<T extends String, T2 extends double> {
  T? name;
  T2? age;

  T? get Get_name => this.name;

  void Set_name(T? name) {
    this.name = name;
  }

  T2? get Get_age => this.age;

  void Set_age(T2? age) {
    this.age = age;
  }

  Human(this.name, this.age);

  void humanInfo();
}
