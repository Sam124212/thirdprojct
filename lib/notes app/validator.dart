String? validateName(String?name){
  if(name == null || name.isEmpty){
    return "User name is required";
  }
  else if(name.toString().length<4){
    return "User name should be 4 chracters";
  }
}
String? validateEmail(String?email){
  if(email == null || email.isEmpty){
    return "Email is required";
  }else if(!email.toString().contains("@")){
    return "Required @.com";
  }else if(!email.toString().contains(".com")){
    return "Required .com";
  }
  return null;
}
String? validatePass(String?pass){
  if(pass == null || pass.isEmpty){
    return "Password is required";
  }else if (pass.toString().length<6){
    return "Password should be at least 6 characters";
  }
  return null;
}
