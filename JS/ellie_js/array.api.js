// Q1. make a string out of an array
{
  const fruits = ["apple", "banana", "orange"];
  //for (let fruit of fruits) {
  //  console.log(fruit);
  //}
  const result = fruits.join(); //separater로 나누어서 문자열로 출력가능/ ()안에 구분자를 넣어줘도 좋다.
  console.log(result);
  console.log("join함수사용은 원래의 배열을 훼손시키나?" + fruits);
}

// Q2. make an array out of a string
{
  const fruits = "🍎, 🥝, 🍌, 🍒";
  // const arr = [fruits];       //배열edit불가
  // console.log(arr);
  const result = fruits.split(",", 2); //split:문자열을 배열화 시킴(원하는정보만 갖고와서 배열생성가능)
  console.log(result);
  console.log("split함수사용은 원래의 배열을 훼손시키나?" + fruits);
}

// Q3. make this array look like this: [5, 4, 3, 2, 1]
{
  const array = [1, 2, 3, 4, 5];
  const result = array.reverse(); //배열자체를 반대로 변경시킴
  console.log(result);
  console.log("reverse함수사용은 원래의 배열을 훼손시키나?" + array);
}

// Q4. make new array without the first two elements
{
  const array = [1, 2, 3, 4, 5];
  //const result = array.splice(0, 2);  //새 array를 만들어야하는데, splice는 배열자체를 수정함
  //console.log(array);
  const result = array.slice(2, 5); //특정부분을 return , end point는 exclusive(예외)
  console.log(result);
  console.log("slice함수사용은 원래의 배열을 훼손시키나?" + array); //배열은 그냥둔다-> slice, 배열자체를 수정-> splice
}

class Student {
  constructor(name, age, enrolled, score) {
    this.name = name;
    this.age = age;
    this.enrolled = enrolled;
    this.score = score;
  }
}
const students = [
  new Student("A", 29, true, 45),
  new Student("B", 28, false, 80),
  new Student("C", 30, true, 90),
  new Student("D", 40, false, 66),
  new Student("E", 18, true, 88),
];

// Q5. find a student with the score 90
{
  //  students[i];
  //for (let value of students) {
  //  console.log(value);
  //}
  const result = students.find(function (student, index) {
    return student.score === 90;
  });
  console.log(result);

  //arrow function
  //{
  //const result = students.find((student)=> student.score === 90);
  //console.log(result);
  //);
}

// Q6. make an array of enrolled students
{
  const result = students.filter((student) => student.enrolled);
  console.log(result);
}

// Q7. make an array containing only the students' scores
// result should be: [45, 80, 90, 66, 88]
{
  const result = students.map((student) => student.score);
  console.log(result);
}

// Q8. check if there is a student with the score lower than 50
{
  const result = students.some((student) => student.score < 50); //배열의 일부요소가 조건 충족해도 true
  console.log(result);

  const result2 = !students.every((student) => student.score < 50); //배열의 모든요소들이 조건 충족해야 true
  console.log(result2);
}

// Q9. compute students' average score
{
  const result = students.reduce();
}

// Q10. make a string containing all the scores

// result should be: '45, 80, 90, 66, 88'
{
}

// Bonus! do Q10 sorted in ascending order
// result should be: '45, 66, 80, 88, 90'
{
}
