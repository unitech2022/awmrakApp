part of 'notification_cubit.dart';

@immutable
abstract class NotificationState {}

class NotificationInitial extends NotificationState {}




//get Notifications
class GetNotificationsLoad extends NotificationState {}
class GetNotificationsSuccess extends NotificationState {
}

class GetNotificationsError extends NotificationState {
}

