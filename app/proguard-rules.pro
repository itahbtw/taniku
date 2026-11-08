# Keep the JavaScript bridge and its annotated methods so the WebView can call
# TanikuAndroid.printPage / exportData / importData after R8 obfuscation.
-keepattributes *Annotation*
-keep class com.taniku.app.MainActivity$PrintBridge { *; }
-keepclassmembers class com.taniku.app.MainActivity$PrintBridge {
    @android.webkit.JavascriptInterface <methods>;
}
