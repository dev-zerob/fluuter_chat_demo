part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {

}

class AuthenticationSuccess extends AuthenticationState {
  final Member member;

  AuthenticationSuccess(this.member);

  @override
  List<Object> get props => [this.member];
}

class AuthenticationFailure extends AuthenticationState {

}