library ex06;
import 'dart:html';
import 'dart:json';

part '../model/person.dart';

List pers_nos;
InputElement name,email,phone,show_name,show_email,show_phone;
ButtonElement btn_create, btn_update,clear,next,before,remove;
TableElement table, table1;
Person bac;
String data;
int rangAAfficher=-1;

void main() {
name = query('#name');
email = query('#email');
phone = query('#phone');
show_name = query('#show_name');
show_email = query('#show_email');
show_phone = query('#show_phone');
btn_create = query('#btn_create');
btn_update = query('#btn_update');
remove = query('#remove');
next = query('#next');
before = query('#before');
clear = query('#clear');
table = query('#tab');
table1 = query('#tab1');

btn_create.onClick.listen(create_person);
clear.onClick.listen(clearFrom);
btn_update.onClick.listen(updatePers);
next.onClick.listen(readLocalStorageNext);
before.onClick.listen(readLocalStorageBef);
remove.onClick.listen(deletepers);
window.onLoad.listen(initChamps);

}

bool validationChamps()
{
  int val=2;
  if (name.value=="")
  {
    window.alert("le champ nom ne doit pas être vide");
    val--;
  }
  if (!email.value.contains("@"))
  {
    window.alert("Adresse email invalide");
    val--;
  }
  if(val<2) return(false);
  else
    return(true);
}
initChamps(Event e){
      String per_json = window.localStorage[window.localStorage.keys.first];
      bac = new Person.fromJson(parse(per_json));
      show_name.value=bac.name;
      show_email.value=bac.email;
      show_phone.value=bac.phone;   
}
clearFrom(Event e){
  name.value="";
  email.value="";
  phone.value="";
  rangAAfficher=0;
}

create_person(Event e) {
  bool verif = validationChamps();
  if (verif){
  Person p=new Person(name.value,email.value,phone.value);
  try {
    window.localStorage["Personne:${p.name}"] = p.toJson();
    window.alert("Bank account data stored in the browser.");
  } on Exception catch (ex) {
    window.alert("Data not stored: Local storage has been deactivated!");
  }
  }
  else
    window.alert("informations erronées ou manqauntes");
}

readLocalStorageNext(Event e) {
  pers_nos = [];
  for (var key in window.localStorage.keys) {
      pers_nos.add(key); // extract personne number
  }
  
  if (rangAAfficher==window.localStorage.length){
    rangAAfficher=-1;
  }
  else
  {
    rangAAfficher++;
    String per_json = window.localStorage[pers_nos[rangAAfficher]];
    bac = new Person.fromJson(parse(per_json));
    show_name.value=bac.name;
    show_email.value=bac.email;
    show_phone.value=bac.phone; 
  }
}

readLocalStorageBef(Event e) {
  pers_nos = [];
  for (var key in window.localStorage.keys) {
      pers_nos.add(key); // extract personne number
  }
  if (rangAAfficher<0)
  {
    rangAAfficher=1;
  }
    rangAAfficher--;
    String per_json = window.localStorage[pers_nos[rangAAfficher]];
    bac = new Person.fromJson(parse(per_json));
    show_name.value=bac.name;
    show_email.value=bac.email;
    show_phone.value=bac.phone; 
}

updatePers(Event e){
      bac.setEmail(show_email.value);
      bac.setPhone(show_phone.value);
window.localStorage["Personne:${bac.name}"] = bac.toJson();
}

deletepers(Event e){
  String x="Personne:"+show_name.value;
  for (var key in window.localStorage.keys) {
    if (key==x)   window.localStorage.remove(key);
  }
}
