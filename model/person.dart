part of ex06;

class Person {

  String _name, _email, _phone;

  String get name => _name;
  
  set name(value) {
    if (value != null && !value.isEmpty) _name = value;
  }

  String get email => _email;
  set email(value) {
    if (value != null && !value.isEmpty) _email = value;
  }

  String get phone => _phone;
  set phone(value) {
    if (value != null && !value.isEmpty) _phone = value;
  }

  Person(name,email, phone) {
    this.name = name;
    this.email = email;
    this.phone = phone;
  }
  // methods:
  String toString() => 'Person: $name, $email, $phone';
  
  Person.fromJson(Map json) {
    this.name = json["name"];
    this.email = json["email"];
    this.phone = json["phone"];
   }
  
  String toJson() {
    var per = new Map<String, Object>();
    per["name"] = name;
    per["email"] = email;
    per["phone"] = phone;
    var pers = stringify(per); 
    return pers;
  }
  
  setName(String newName)
  {
    this.name=newName;
  }
  
  setEmail(String newEmail)
  {
    this.email=newEmail;
  }
  
  setPhone(String newPhone)
  {
    this.phone=newPhone;
  }
}


