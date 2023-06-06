abstract class LoginStates {}

class LogininInitState extends LoginStates {}

class LoginErrorState extends LoginStates {
  final String? msgEr;

  LoginErrorState({this.msgEr});
}

class LoginSuccessState extends LoginStates {
  final String? msg;

  LoginSuccessState({this.msg});
}

class LoginLoadingState extends LoginStates {}
