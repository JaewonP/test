"use strict";
//1. class declarations
class Person {
  constructor(name, age) {
    //생성자는 constructor로 고정
    this.name = name;
    this.age = age;
  }
  //method
  speak() {
    console.log(`${this.name}: hello!`);
  }
}

//2. object declarations
const emma = new Person("emma", 31);
console.log(emma.name);
console.log(emma.age);
emma.speak();

//3. getter, setter
class User {
  constructor(firstname, lastname, age) {
    this.firstname = firstname;
    this.lastname = lastname;
    this.age = age;
  }
  get age() {
    return this._age; //**왜 callstack되는건지 모르겠따  */
  }
  set age(value) {
    //if (value < 0) {
    //throw error("age can not be negative");
    //}
    this._age = value < 0 ? 0 : value;
  }
}
const user1 = new User("emma", "baby", -1);
console.log(user1.age);

//4. fields(public, private)
//too soon!
class Experiment {
  publicfield = 2;
  #privatefield = 0; //*#을 붙인다,private와 변수명을 붙여서 써준다.
}
const experiment = new Experiment();
console.log(experiment.publicfield);
console.log(experiment.privatefield);

//5. static
//too soon
class Article {
  static publisher = "emmababy"; //static은 class기준으로 묶여있음
  constructor(articlenumber) {
    this.articlenumber = articlenumber;
  }

  static printpublisher() {
    console.log(Article.publisher);
  }
}
const article1 = new Article(1);
const article2 = new Article(2);
console.log(Article.publisher); //static이 있으므로, class명으로 접근해주어야함
Article.printpublisher(); //static이 있으므로, class명으로 접근해주어야함

//6. Inheritance
class Shape {
  constructor(width, height, color) {
    this.width = width;
    this.height = height;
    this.color = color;
  }
  draw() {
    console.log(`drawing ${this.color} color!`);
  }
  getArea() {
    return this.width * this.height;
  }
}

class Rectangle extends Shape {} //각 클래스에스 중괄호 안열어줌
class Triangle extends Shape {
  //오버라이딩 받을 떄 괄호열어서 넣어줌
  getArea() {
    return (this.width * this.height) / 2;
  }
  draw() {
    super.draw();
    console.log(12341234);
  }
}

const rectangle = new Rectangle(4, 3, "blue");
rectangle.draw();
console.log(rectangle.getArea());

const triangle = new Triangle(5, 2, "red");
triangle.draw();
console.log(triangle.getArea());

//7. instance of  -> true /false return
console.log(rectangle instanceof Rectangle);
console.log(triangle instanceof Rectangle);
console.log(triangle instanceof Shape);
