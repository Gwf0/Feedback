package com.nika.feedback24_app;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

import com.yandex.mapkit.MapKitFactory;

public class MainActivity extends FlutterActivity {
  @Override
  public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
    MapKitFactory.setApiKey("8d681535-4073-44b9-98c7-9d1c78341a7b"); // Your generated API key
    super.configureFlutterEngine(flutterEngine);
  }
}
