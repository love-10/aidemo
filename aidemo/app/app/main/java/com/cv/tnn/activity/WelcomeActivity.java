package com.cv.tnn.activity;

import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.res.AssetManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;

import com.cv.tnn.R;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;

public class WelcomeActivity extends AppCompatActivity {
    private static final String TAG = "WelcomeActivity";
    public static final String FACE_MODEL = "face/rfb1.0_face_320_320.opt";
    public static final String FACE_LANDMARK_MODEL = "face_ldmks/rfb_landm_face_320_320_sim.opt";
    public static final String PERSON_MODEL = "person/rfb1.0_person_320_320_sim.opt";
    public static final String FACE_PERSON_MODEL = "face_person/rfb1.0_face_person_320_320_sim.opt";
    public static String[] TNN_MODEL_FILES = {
            FACE_MODEL,
            FACE_LANDMARK_MODEL,
            PERSON_MODEL,
            FACE_PERSON_MODEL,
    };
    // 设置默认的测试图片
    public static String[] TEST_IMAGES = {
            "persone.jpg",
            "person.jpeg",
            "person.jpeg",
            "jpeg",
    };
    public static String MODEL_TYPE[] = {"人脸检测", "人脸关键点检测", "人体检测", "人脸+人体检测"};
    private Button btnStart;
    private Button btnSelect;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_welcome);
        btnSelect = (Button) findViewById(R.id.btn_select);
        btnStart = findViewById(R.id.btn_start_detect);
        enableButtons(false);
        initView();
        copyModelFromAssetsToData();
    }


    private void enableButtons(boolean status) {
        btnSelect.setEnabled(status);
        btnStart.setEnabled(status);
    }

    protected void initView() {
        //选择模型
        btnSelect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                AlertDialog.Builder builder = new AlertDialog.Builder(WelcomeActivity.this, android.R.style.Theme_Holo_Light_Dialog);
                builder.setTitle("请选择检测类型");
                builder.setItems(MODEL_TYPE, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        Toast.makeText(WelcomeActivity.this, "检测类型:" + String.valueOf(which) + MODEL_TYPE[which], Toast.LENGTH_SHORT).show();
                        MainActivity.MODEL_ID = which;
                    }
                });
                builder.show();
            }
        });

        //开始检测
        btnStart.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(WelcomeActivity.this, MainActivity.class);
                WelcomeActivity.this.startActivity(intent);
            }
        });

    }

    protected void copyModelFromAssetsToData() {
        // assets目录下的模型文件名
        Toast.makeText(this, "Copy model to data...", Toast.LENGTH_SHORT).show();
        try {
            for (String tnn_model : TNN_MODEL_FILES) {
                //  {"face/rfb1.0_face_320_320.opt.tnnproto", "face/rfb1.0_face_320_320.opt.tnnmodel"};
                String tnnproto = tnn_model + ".tnnproto";
                String tnnmodel = tnn_model + ".tnnmodel";
                Log.w(TAG, "copy model:" + tnn_model);
                copyAssetFileToFiles(this, tnnproto);
                copyAssetFileToFiles(this, tnnmodel);
            }
            enableButtons(true);
            Toast.makeText(this, "Copy model Success", Toast.LENGTH_SHORT).show();
        } catch (Exception e) {
            e.printStackTrace();
            Toast.makeText(this, "Copy model Error", Toast.LENGTH_SHORT).show();
        }
    }

    public void copyAssetDirToFiles(Context context, String dirname) throws IOException {
        File dir = new File(context.getFilesDir() + File.separator + dirname);
        dir.mkdir();

        AssetManager assetManager = context.getAssets();
        String[] children = assetManager.list(dirname);
        for (String child : children) {
            child = dirname + File.separator + child;
            String[] grandChildren = assetManager.list(child);
            if (0 == grandChildren.length) {
                copyAssetFileToFiles(context, child);
            } else {
                copyAssetDirToFiles(context, child);
            }
        }
    }

    public void copyAssetFileToFiles(Context context, String filename) throws IOException {
        InputStream is = context.getAssets().open(filename);
        byte[] buffer = new byte[is.available()];
        is.read(buffer);
        is.close();

        File file = new File(context.getFilesDir() + File.separator + filename);
        File parent = new File(file.getParent());
        if (!parent.exists()) {
            parent.mkdirs();
        }
        file.createNewFile();
        FileOutputStream os = new FileOutputStream(file);
        os.write(buffer);
        os.close();
    }

}