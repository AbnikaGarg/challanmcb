package com.example.challanmcbjava;


import static com.example.challanmcbjava.ActivityWelcome.REQUEST_PERMISSION;

import io.flutter.embedding.android.FlutterActivity;
import com.basewin.aidl.OnPrinterListener;
import com.basewin.define.FontsType;
import com.basewin.define.GlobalDef;
import com.basewin.models.BitmapPrintLine;
import com.basewin.models.PrintLine;
import com.basewin.models.TextPrintLine;
import com.basewin.services.PrinterBinder;
import com.basewin.services.ServiceManager;
import com.basewin.utils.AppUtil;
import com.basewin.utils.TimerCountTools;
import com.basewin.zxing.utils.QRUtil;
import com.pos.sdk.accessory.PosAccessoryManager;
import com.pos.sdk.printer.PosPrinter;
import com.pos.sdk.printer.PosPrinterInfo;

import android.Manifest;
import android.annotation.SuppressLint;
import android.app.AlertDialog;
import android.content.ComponentName;
import android.content.Intent;
import android.graphics.BitmapFactory;
import android.graphics.Matrix;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Spinner;

import android.app.AlertDialog;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;
import android.annotation.TargetApi;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.pdf.PdfRenderer;
import android.os.ParcelFileDescriptor;
import android.util.Log;
import androidx.annotation.NonNull;

import com.basewin.models.BitmapPrintLine;
import com.basewin.models.PrintLine;
import com.basewin.models.TextPrintLine;
import com.basewin.services.ServiceManager;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.embedding.android.FlutterActivity;
import pub.devrel.easypermissions.AfterPermissionGranted;
import pub.devrel.easypermissions.AppSettingsDialog;
import pub.devrel.easypermissions.EasyPermissions;
import pub.devrel.easypermissions.PermissionRequest;

import com.basewin.log.LogUtil;
import com.basewin.log.LogUtil;
import com.printerlibrary.wrapper.PrintUtility;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "CallAndriodChannel";

    private int         iLineWidth             = 576;
    private final String tag = "AclasPrinter";
    private Spinner spPrnType                 = null;
    AlertDialog.Builder builder;
    private int         iPtnType                = 0 ;//0 2inch; 1 3inch
    private String      strStatusPaperExist   = null;
    private String      strStatusPaperNoExist = null;
    private boolean     bFlagPrinterOpen        = false;
    byte[] tmpData2 = new byte[4096];
    private String test=null;
    private Button btn_c, btn_android, btn_layout;
    // private EditText et_gray;
    // private TextView tv_display;
    private TimerCountTools timeTools;
    private TimerCountTools timeTools1;
    private String str_display = "", str_c = "C Print: \n", str_android = "Android Print: \n", str_layout = "Layout Print: \n";
    private int printType = 1;
    private  int printMaxNum = 0;
   // com.pax.dal.IDAL dal = null;


    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
      //  permission();
        try {

            PrintUtility printUtility = new PrintUtility(getApplicationContext());
          //  dal =  Payment.getDal();

        } catch (Exception e) {
            e.printStackTrace();
        }
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            // Note: this method is invoked on the main thread.
                            if (call.method.equals("print")) {
                                String base64 = call.argument("encoded");

                                ServiceManager.getInstence().init(getApplicationContext());
                                LogUtil.openLog();
                                ///  devPrn  = new AclasPrinter(MainActivity.this);
                                //   iPtnType          = 1;
                                //  bFlagPrinterOpen =  devPrn.openPrinter(iPtnType);
                                showLog("Open Printer Successfully:");
                                // showLog(bFlagPrinterOpen?("Open Printer Successfully:"+String.valueOf(iPtnType)):"Open Printer Failed");
                              //  String results= printBmp(base64);
                               // result.success(results);



                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }
    @AfterPermissionGranted(REQUEST_PERMISSION)
    private void permission(){
        String[] perms = {
                Manifest.permission.WRITE_EXTERNAL_STORAGE,
                Manifest.permission.READ_EXTERNAL_STORAGE,
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.SEND_SMS,
                "com.pos.permission.SECURITY",
                "com.pos.permission.ACCESSORY_DATETIME",
                "com.pos.permission.ACCESSORY_LED",
                "com.pos.permission.ACCESSORY_BEEP",
                "com.pos.permission.ACCESSORY_RFREGISTER",
                "com.pos.permission.CARD_READER_ICC",
                "com.pos.permission.CARD_READER_PICC",
                "com.pos.permission.CARD_READER_MAG",
                "com.pos.permission.COMMUNICATION",
                "com.pos.permission.PRINTER",
                "com.pos.permission.ACCESSORY_RFREGISTER",
                "com.pos.permission.EMVCORE"
        };
        if (EasyPermissions.hasPermissions(this, perms)) {
            Toast.makeText(this,"Already Permission",Toast.LENGTH_SHORT).show();
            // startDemo();
        } else {
            // Do not have permissions, request them now
            EasyPermissions.requestPermissions(
                    new PermissionRequest
                            .Builder(this,REQUEST_PERMISSION,perms)
                            .setRationale("Dear users\n need to apply for storage Permissions for\n your better use of this application")
                            .setNegativeButtonText("NO")
                            .setPositiveButtonText("YES")
                            .build()
            );
        }
    }
    @SuppressLint("NewApi")
    private void startDemo()
    {
        ServiceManager.getInstence().init(getApplicationContext());
        LogUtil.openLog();




        finish();
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        Log.e("Granted", "onRequestPermissionsResult:" + requestCode);
        if(requestCode == 1){
            // startDemo();
        }
    }




    private void showLog(String s) {
        Log.d(tag,"showLog:"+s);

    }
    public void onJump(View v){
        Intent intent = new Intent();
        ComponentName componentName=new ComponentName("demo.mifare.com", "demo.mifare.com.ActivityWelcome");
        intent.setComponent(componentName);
        startActivity(intent);

    }
    public Bitmap switchColor(Bitmap switchBitmap) {
        int width = switchBitmap.getWidth();
        int height = switchBitmap.getHeight();

        Bitmap newBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        Canvas canvas = new Canvas(newBitmap);
        canvas.drawBitmap(switchBitmap, new Matrix(), new Paint());

        int current_color, red, green, blue, alpha, avg = 0;
        for (int i = 0; i < width; i++) {
            for (int j = 0; j < height; j++) {
                current_color = switchBitmap.getPixel(i, j);
                red = Color.red(current_color);
                green = Color.green(current_color);
                blue = Color.blue(current_color);
                alpha = Color.alpha(current_color);
                avg = (red + green + blue) / 3;
                if (avg >= 210) {
                    newBitmap.setPixel(i, j, Color.argb(alpha, 255, 255, 255));// white
                } else if (avg < 210 && avg >= 80) { // avg<126 && avg>=115
                    newBitmap.setPixel(i, j, Color.argb(alpha, 108, 108, 108));// grey
                } else {
                    newBitmap.setPixel(i, j, Color.argb(alpha, 0, 0, 0));// black
                }
            }
        }
        return newBitmap;
    }
    private Bitmap getFixedBitmap(@NonNull Bitmap bm) {
        int width = bm.getWidth();
        int height = bm.getHeight();
        int fix = 0;
        if (width > 384) {
            width = 384;
        }
        // 不是8的倍数的宽度，就进行缩放
        if (width % 8 != 0) {
            if (width > 8) {
                fix = width % 8;
                width -= fix;
                height -= fix;
            } else {
                fix = 8 - width % 8;
                width += fix;
                height += fix;
            }
        }else{
            return bm;
        }
        return Bitmap.createScaledBitmap(bm, width, height, true);
        // return Bitmap.createBitmap(bm, fix, 0, width - fix * 2, height);
    }
    private PrinterListener printer_callback = new PrinterListener();


    private String printBmp(String base64key){
        Bitmap bitmapPrint = null;

        try {iPtnType          = 1;
            // int DotLineWidth=200;
            byte[] decodedString = Base64.decode(base64key, Base64.DEFAULT);
            Bitmap decodedByte = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);
            //decodedByte =  Bitmap.createScaledBitmap(decodedByte, DotLineWidth, decodedByte.getHeight()*DotLineWidth/decodedByte.getWidth(), true);
            //  Bitmap bmpRet = Bitmap.createBitmap(decodedByte.getWidth(),decodedByte.getHeight(),Bitmap.Config.ARGB_8888);
            Log.d(tag," PDF changeBmp w:"+decodedByte.getWidth()+" h:"+decodedByte.getHeight());
            //devPrn.sendBitmap(decodedByte);
            //  devPrn.saveImage(bitmapPrint,MainActivity.this);
            System.out.println("bmp_is: "+decodedByte);
            //android.graphics.Bitmap@946f39f
            BitmapPrintLine bitmapPrintLine = new BitmapPrintLine();
            bitmapPrintLine.setType(PrintLine.BITMAP);
            bitmapPrintLine.setPosition(PrintLine.CENTER);
            bitmapPrintLine.setBitmap(decodedByte);

            // ServiceManager.getInstence().init(getApplicationContext());

            ServiceManager.getInstence().getPrinter().cleanCache();
            ServiceManager.getInstence().getPrinter().setPrintGray(2000);
            ServiceManager.getInstence().getPrinter().setLineSpace(1);
            ServiceManager.getInstence().getPrinter().setPrintFont(FontsType.DroidSansMono);
            ServiceManager.getInstence().getPrinter().addPrintLine(bitmapPrintLine);




            ServiceManager.getInstence().getPrinter().beginPrint(printer_callback);
            return "1";
        } catch (Exception e) {
            Log.e(tag, "Open Bitmap Error" + e);
            return "0";
        }
    }
    Handler handler = new Handler(){
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            if(printMaxNum == 0){
                return;
            }
            switch (printType){
                case 1:
                    printAndroid();
                    break;
                case 2:
                    printLayout();
                    break;
                default:
                    break;
            }
        }
    };
    private static final String TAG = "MainActivity";
    private void printAndroid(){

//        Intent intent= new Intent();
//        intent.setAction("android.intent.action.VIEW");
//        Uri content_url = Uri.parse("https://www.baidu.com");
//        ComponentName name = new ComponentName("com.android.chrome","com.google.android.apps.chrome.IntentDispatcher");
//        intent.setData(content_url);
//        intent.setComponent(name);
//        startActivity(intent);

        try {
            printType = 1;
            Log.e(TAG, "ANDROID_TYPESETTING");
            ServiceManager.getInstence().getPrinter().setPrintTypesettingType(GlobalDef.ANDROID_TYPESETTING);

            //  printBase();
        }catch (Exception e){

        }
    }

    private void printLayout(){
        try {
            printType = 2;
            Log.e(TAG, "PRINTERLAYOUT_TYPESETTING");
            ServiceManager.getInstence().getPrinter().setPrintTypesettingType(GlobalDef.PRINTERLAYOUT_TYPESETTING);

            //printBase();
        }catch (Exception e){
            Log.e(TAG, "PRINTERLAYOUT_TYPESETTING");
        }
    }

    class PrinterListener implements OnPrinterListener {
        private final String TAG = "Print";

        @Override
        public void onStart() {
            // TODO 打印开始
            // Print start
           // Toast.makeText(MainActivity.this, "onStart  printing", Toast.LENGTH_SHORT).show();
            Log.e(TAG, "onStart");

        }

        @Override
        public void onFinish() {
            // TODO 打印结束
            // End of the print
            Log.e(TAG, "onFinish");;
           // Toast.makeText(MainActivity.this, "onFinish  printing", Toast.LENGTH_SHORT).show();
            //  handler.sendEmptyMessage(0);
        }

        @Override
        public void onError(int errorCode, String detail) {
            // TODO 打印出错
            // print error
            Log.e(TAG,"print error" + " errorcode = " + errorCode + " detail = " + detail);
            if (errorCode == PrinterBinder.PRINTER_ERROR_NO_PAPER) {
                //Toast.makeText(MainActivity.this, "paper runs out during printing", Toast.LENGTH_SHORT).show();
            }
            if (errorCode == PrinterBinder.PRINTER_ERROR_OVER_HEAT) {
                Toast.makeText(MainActivity.this, "over heat during printing", Toast.LENGTH_SHORT).show();
            }
            if (errorCode == PrinterBinder.PRINTER_ERROR_OTHER) {
                Toast.makeText(MainActivity.this, "other error happen during printing", Toast.LENGTH_SHORT).show();
            }

            //handler.sendMessageDelayed(null, 1000);
            handler.sendEmptyMessageDelayed(1,1000);
        }
    }

}
