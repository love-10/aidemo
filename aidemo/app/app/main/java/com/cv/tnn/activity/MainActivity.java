package com.cv.tnn.activity;

import android.content.pm.PackageManager;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

import com.cv.tnn.R;
import com.cv.tnn.model.Detector;
import com.cv.tnn.model.DrawImage;
import com.cv.tnn.model.FrameInfo;
import com.cv.tnn.model.Skeleton;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;

public class MainActivity extends AppCompatActivity {
    public static boolean USE_GPU = true;
    public static int MODEL_ID = 0;
    public static int NUM_THREAD = 1;
    private ImageView resultImageView;
    private Button btnTest;
    private float score_threshold = 0.5f;
    private float iou_threshold = 0.3f;
    protected Bitmap visualBitmap;
    protected Bitmap inputBitmap;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        initModel();
        initViewID();
        initViewListener();

    }

    protected void initViewListener() {
        btnTest.setOnClickListener(view -> {
            Bitmap image;
            AssetManager am = getResources().getAssets();
            try {
                InputStream is = am.open(WelcomeActivity.TEST_IMAGES[MODEL_ID]);
                image = BitmapFactory.decodeStream(is);
                is.close();
                detBitmap(image);
            } catch (IOException e) {
                e.printStackTrace();
            }
        });

    }

    protected void initViewID() {
        resultImageView = findViewById(R.id.imageView);
        btnTest = findViewById(R.id.test_image);
    }

    protected void initModel() {
        String root = this.getFilesDir() + File.separator;
        String model_file = WelcomeActivity.TNN_MODEL_FILES[MODEL_ID];
        Detector.init(model_file, root, MODEL_ID, NUM_THREAD, USE_GPU);
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        for (int result : grantResults) {
            if (result != PackageManager.PERMISSION_GRANTED) {
                Toast.makeText(this, "Camera Permission!", Toast.LENGTH_SHORT).show();
                this.finish();
            }
        }
    }


    public void detBitmap(Bitmap bitmap) {
        if (bitmap == null) {
            Toast.makeText(this, "Photo is null", Toast.LENGTH_SHORT).show();
            return;
        }
        Thread thread = new Thread(() -> {
            visualBitmap = detectAndDraw(bitmap);
            showResultOnUI();
            runOnUiThread(() -> resultImageView.setImageBitmap(visualBitmap));
        }, "photo detect");
        thread.start();
    }

    protected void showResultOnUI() {

    }


    protected Bitmap detectAndDraw(Bitmap bitmap) {
        inputBitmap = bitmap.copy(Bitmap.Config.ARGB_8888, true);
        FrameInfo[] result;
        result = Detector.detect(inputBitmap, score_threshold, iou_threshold);
        if (result == null) {
            visualBitmap = bitmap;
            return bitmap;
        }
        visualBitmap = inputBitmap;
        visualBitmap = DrawImage.drawResult(visualBitmap, result, Skeleton.get_skeleton(MODEL_ID));
        return visualBitmap;
    }
}