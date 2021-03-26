package com.dscepi.lorem_ipsum

import com.baseflow.geolocator.GeolocatorPlugin
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin
import io.flutter.app.FlutterApplication
import io.flutter.embedding.engine.plugins.PluginRegistry
import io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin
import io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin
import io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin
import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin
import io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin
import io.flutter.view.FlutterMain
import rekab.app.background_locator.IsolateHolderService

class Application : FlutterApplication(), io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        IsolateHolderService.setPluginRegistrant(this)
        FlutterMain.startInitialization(this)
    }

    override fun registerWith(registry: io.flutter.plugin.common.PluginRegistry?) {
        if (!registry!!.hasPlugin("io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin")) {
            FlutterFirebaseFirestorePlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin"))
        }

        if (!registry!!.hasPlugin("io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin")){
            FlutterFirebaseAuthPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin"))
        }

        if (!registry!!.hasPlugin("io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin")){
            FlutterFirebaseCorePlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin"))
        }

        if (!registry!!.hasPlugin("io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin")){
            FlutterFirebaseMessagingPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingPlugin"))
        }

        if (!registry!!.hasPlugin("io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin")){
            FlutterFirebaseStoragePlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin"))
        }

        if (!registry!!.hasPlugin("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin")){
            FlutterLocalNotificationsPlugin.registerWith(registry!!.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"))
        }

        if (!registry!!.hasPlugin("com.baseflow.geolocator.GeolocatorPlugin")){
            GeolocatorPlugin.registerWith(registry!!.registrarFor("com.baseflow.geolocator.GeolocatorPlugin"))
        }
    }
}