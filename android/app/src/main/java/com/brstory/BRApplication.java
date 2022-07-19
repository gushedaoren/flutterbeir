package com.brstory;


import io.flutter.app.FlutterApplication;

public class BRApplication extends FlutterApplication {


    public static BRApplication instances;

    public static BRApplication getInstance() {
        return instances;
    }

    @Override
    public void onCreate() {
        super.onCreate();

        instances = this;



      
        android.util.Log.i("UMLog", "UMConfigure.init@MainApplication");


    }


}
