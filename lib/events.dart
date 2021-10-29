library application_events;

import 'package:event_bus/event_bus.dart';
import 'package:inject/inject.dart';

abstract class ApplicationEvent {
  final String message;
  ApplicationEvent({required this.message});
}

class ErrorAppEvent extends ApplicationEvent {
  ErrorAppEvent({required String message}) : super(message: message);
}

class SuccessAppEvent extends ApplicationEvent {
  SuccessAppEvent({required String message}) : super(message: message);
}

class ActionEvent extends ApplicationEvent {
  final String source;
  final String action;
  ActionEvent(
      {required this.source, required this.action, required String message})
      : super(message: message);
}

class ApplicationEvents {
  static void fire(ApplicationEvent applicationEvent) {
    EventBus events = Inject().get<EventBus>();
    events.fire(applicationEvent);
  }

  static void fireSuccess({required String message}) {
    fire(SuccessAppEvent(message: message));
  }

  static void fireError({required String message}) {
    fire(ErrorAppEvent(message: message));
  }

  static void fireAction(
      {required String source,
      required String action,
      required String message}) {
    fire(ActionEvent(source: source, action: action, message: message));
  }
}
