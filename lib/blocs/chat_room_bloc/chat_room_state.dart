part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {
  @override
  List<Object> get props => [];
}

class ChatRoomInitial extends ChatRoomState {}

class ChatRoomLoading extends ChatRoomState {}

class ChatRoomLoadSuccess extends ChatRoomState {
  final List<ChatMessage> message;

  ChatRoomLoadSuccess({this.message});
  @override
  List<Object> get props => [message];
}

class ChatRoomLoadFailure extends ChatRoomState {}
