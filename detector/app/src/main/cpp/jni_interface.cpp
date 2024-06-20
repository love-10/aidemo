#include <jni.h>
#include <string>
#include <fstream>
#include "src/object_detection.h"
#include "src/Types.h"
#include "debug.h"
#include "android_utils.h"
#include "opencv2/opencv.hpp"
#include "file_utils.h"

using namespace dm;
using namespace vision;

static ObjectDetection *detector = nullptr;


JNIEXPORT jint JNI_OnLoad(JavaVM *vm, void *reserved) {
    return JNI_VERSION_1_6;
}

JNIEXPORT void JNI_OnUnload(JavaVM *vm, void *reserved) {

}


extern "C"
JNIEXPORT void JNICALL
Java_com_cv_tnn_model_Detector_init(JNIEnv *env,
                                    jclass clazz,
                                    jstring model,
                                    jstring root,
                                    jint model_type,
                                    jint num_thread,
                                    jboolean use_gpu) {
    if (detector != nullptr) {
        delete detector;
        detector = nullptr;
    }
    std::string parent = env->GetStringUTFChars(root, 0);
    std::string model_ = env->GetStringUTFChars(model, 0);
    string model_file = path_joint(parent, model_ + ".tnnmodel");
    string proto_file = path_joint(parent, model_ + ".tnnproto");
    DeviceType device = use_gpu ? GPU : CPU;
    LOGW("parent     : %s", parent.c_str());
    LOGW("model_file : %s", model_file.c_str());
    LOGW("useGPU     : %d", use_gpu);
    LOGW("device_type: %d", device);
    LOGW("model_type : %d", model_type);
    LOGW("num_thread : %d", num_thread);
    ObjectDetectionParam model_param = MODEL_TYPE[model_type];//模型参数
    detector = new ObjectDetection(model_file,
                                   proto_file,
                                   model_param,
                                   num_thread,
                                   device);

}

extern "C"
JNIEXPORT jobjectArray JNICALL
Java_com_cv_tnn_model_Detector_detect(JNIEnv *env, jclass clazz, jobject bitmap,
                                      jfloat score_thresh, jfloat iou_thresh) {
    cv::Mat bgr;
    BitmapToMatrix(env, bitmap, bgr);
    int src_h = bgr.rows;
    int src_w = bgr.cols;
    // 检测区域为整张图片的大小
    FrameInfo resultInfo;
    // 开始检测
    if (detector!= nullptr){
        detector->detect(bgr, &resultInfo, score_thresh, iou_thresh);
    }
    else{
        ObjectInfo objectInfo;
        objectInfo.x1=0;
        objectInfo.y1=0;
        objectInfo.x2=84;
        objectInfo.y2=84;
        objectInfo.label=0;
        resultInfo.info.push_back(objectInfo);
    }

    int nums = resultInfo.info.size();
    LOGW("object nums: %d\n", nums);

    auto BoxInfo = env->FindClass("com/cv/tnn/model/FrameInfo");
    auto init_id = env->GetMethodID(BoxInfo, "<init>", "()V");
    auto box_id = env->GetMethodID(BoxInfo, "addBox", "(FFFFIF)V");
    auto ky_id = env->GetMethodID(BoxInfo, "addKeyPoint", "(FFF)V");
    jobjectArray ret = env->NewObjectArray(resultInfo.info.size(), BoxInfo, nullptr);
    for (int i = 0; i < nums; ++i) {
        auto info = resultInfo.info[i];
        env->PushLocalFrame(1);
        //jobject obj = env->AllocObject(BoxInfo);
        jobject obj = env->NewObject(BoxInfo, init_id);
        // set bbox
        //LOGW("rect:[%f,%f,%f，%f] label:%d,score:%f \n", info.rect.x,info.rect.y, info.rect.w, info.rect.h, 0, 1.0f);
        env->CallVoidMethod(obj, box_id, info.x1, info.y1, info.x2 - info.x1, info.y2 - info.y1,
                            info.label, info.score);
        // set keypoint
        for (const auto &kps : info.landmarks) {
            //LOGW("point:[%f,%f] score:%f \n", lm.point.x, lm.point.y, lm.score);
            env->CallVoidMethod(obj, ky_id, (float) kps.x, (float) kps.y, 1.0f);
        }
        obj = env->PopLocalFrame(obj);
        env->SetObjectArrayElement(ret, i, obj);
    }
    return ret;
}

