package com.brstory;


import com.umeng.commonsdk.UMConfigure;

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



        UMConfigure.init(this, UMConfigure.DEVICE_TYPE_PHONE, "");

        android.util.Log.i("UMLog", "UMConfigure.init@MainApplication");


    }


}
