import 'dart:async';

import 'package:onesignal_flutter/onesignal_flutter.dart';


/*Crear cuenta en onesignal, ahi esta toda la info para registrar con todoo y firebase*/

class OneSignalData {
  //Sustituir por tu propio appId
  static const appId = "44f0f302-24c8-480f-ac3c-4fed4dfd2a68";
}

class PushNotificationService {


  static final StreamController<OSNotification> _messageStreamController = StreamController.broadcast();
  static Stream<OSNotification> get messageStream => _messageStreamController.stream;


  static Future initializeApp() async {
    //Remove this method to stop OneSignal Debugging
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    await OneSignal.shared.setAppId(OneSignalData.appId);

    // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    await OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });

    // Al recibir notificación con la app abierta
    OneSignal.shared.setNotificationWillShowInForegroundHandler(_setNotificationWillShowInForegroundHandler);
    // Al clickar notificación
    OneSignal.shared.setNotificationOpenedHandler(_setNotificationOpenedHandler);
  }

  static Future _setNotificationWillShowInForegroundHandler(OSNotificationReceivedEvent event) async {
    OSNotification notification = event.notification;
    _messageStreamController.add(notification);
    //Enviar en null si no se quiere mostrar notificacion
    event.complete( null /*event.notification*/);
  }

  static Future _setNotificationOpenedHandler(OSNotificationOpenedResult result) async {
    OSNotification notification = result.notification;
    //_messageStreamController.add(notification);
  }
}
