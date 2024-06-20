package com.cv.tnn.model;

import android.graphics.Bitmap;

public class Detector {

    static {
        System.loadLibrary("tnn_wrapper");
    }


    /***
     * 初始化检测模型
     * @param model： TNN *.tnnmodel文件文件名（含后缀名）
     * @param root：模型文件的根目录，放在assets文件夹下
     * @param model_type：模型类型
     * @param num_thread：开启线程数
     * @param useGPU：是否使用GPU进行加速
     */
    public static native void init(String model, String root, int model_type, int num_thread, boolean useGPU);

    /***
     * 检测关键点
     * @param bitmap 图像（bitmap），ARGB_8888格式
     * @param score_thresh：置信度阈值
     * @param iou_thresh：  IOU阈值
     * @return
     */
    public static native FrameInfo[] detect(Bitmap bitmap, float score_thresh, float iou_thresh);
}
