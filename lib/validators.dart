bool isPhoneNumber(String string) {
  if (string.length > 9 || string.length < 9) {
    return false;
  } else {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }
}

bool isPincode(String string) {
  if (string.length > 6 || string.length < 6) {
    return false;
  } else {
    final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(string);
  }
}

// bool isComplete(isNumber, isCode){
//   if(isNumber & isCode == true){
//     return true;
//   }else{
//     return false;
//   }
// }

// bool verifying(number, code){
//   final isNumber = isPhoneNumber(number);
//   final isCode = isPincode(code);

//   if(isNumber & isCode == true){
//     return true;
//   }
// }


