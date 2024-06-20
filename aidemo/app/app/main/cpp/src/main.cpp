//
// Created by Jervint on 2020/6/24.
//

#include "object_detection.h"
#include <iostream>
#include <string>
#include <vector>
#include "file_utils.h"

using namespace dm;
using namespace vision;
using namespace std;

void test_face_person_detector() {
    const int num_thread = 1;
    DeviceType device = CPU;
    // 人脸和关键点检测
//    const char *model_file = (char *) "../data/tnn/face_ldmks/rfb_landm_face_320_320_sim.opt.tnnmodel";
//    const char *proto_file = (char *) "../data/tnn/face_ldmks/rfb_landm_face_320_320_sim.opt.tnnproto";
//    ObjectDetectiobParam model_param = FACE_LANDMARK_MODEL;

    // 人脸+人体检测
//     const char *model_file = (char *) "../data/tnn/face_person/rfb1.0_face_person_300_300_sim.opt.tnnmodel";
//     const char *proto_file = (char *) "../data/tnn/face_person/rfb1.0_face_person_300_300_sim.opt.tnnproto";
//     ObjectDetectiobParam model_param = FACE_PERSON_MODEL;//模型参数
    // 人脸检测
    const char *model_file = (char *) "../data/tnn/face/rfb1.0_face_320_320.opt.tnnmodel";
    const char *proto_file = (char *) "../data/tnn/face/rfb1.0_face_320_320.opt.tnnproto";
    ObjectDetectiobParam model_param = FACE_MODEL;//模型参数


    // 设置检测阈值
    const float scoreThresh = 0.5;
    const float iouThresh = 0.3;
    ObjectDetection *detector = new ObjectDetection(model_file,
                                                    proto_file,
                                                    model_param,
                                                    num_thread,
                                                    device);

    string image_dir = "../data/test_image/person";
    std::vector<string> image_list = get_files_list(image_dir);
    for (string image_path:image_list) {
        cv::Mat bgr_image = cv::imread(image_path);
        if (bgr_image.empty()) continue;
        FrameInfo resultInfo;
        printf("init frame\n");
        // 开始检测
        detector->detect(bgr_image, &resultInfo, scoreThresh, iouThresh);
        // 可视化代码
        detector->visualizeResult(bgr_image, &resultInfo);
    }
    delete detector;
    detector = nullptr;
    printf("FINISHED.\n");
}


void test_card_detector() {
    const int num_thread = 1;
    DeviceType device = GPU;
    // 人脸和关键点检测
    const char *model_file = (char *) "../data/tnn/card/rfb_card_320_320_freeze_sim.opt.tnnmodel";
    const char *proto_file = (char *) "../data/tnn/card/rfb_card_320_320_freeze_sim.opt.tnnproto";
    ObjectDetectiobParam model_param = CARD_DET_MODEL;
    model_param.input_width = 320;
    model_param.input_height = 320;
    model_param.freeze_header = true; //如果模型是freeze的，则设置freeze_header=true
    model_param.use_rgb = true;

    // 设置检测阈值
    const float scoreThresh = 0.5;
    const float iouThresh = 0.3;
    ObjectDetection *detector = new ObjectDetection(model_file,
                                                    proto_file,
                                                    model_param,
                                                    num_thread,
                                                    device);
    string image_dir = "../data/test_image/card";
    std::vector<string> image_list = get_files_list(image_dir);
    for (string image_path:image_list) {
        cv::Mat bgr_image = cv::imread(image_path);
        if (bgr_image.empty()) continue;
        FrameInfo resultInfo;
        printf("init frame\n");
        // 开始检测
        detector->detect(bgr_image, &resultInfo, scoreThresh, iouThresh);
        // 可视化代码
        detector->visualizeResult(bgr_image, &resultInfo);
    }
    delete detector;
    detector = nullptr;
    printf("FINISHED.\n");
}


void test_retails_detector() {
    const int num_thread = 1;
    DeviceType device = GPU;
    // 人脸和关键点检测
    const char *model_file = (char *) "../data/tnn/retails/RFB_default_320_160_0.78426_freeze_sim.opt.tnnmodel";
    const char *proto_file = (char *) "../data/tnn/retails/RFB_default_320_160_0.78426_freeze_sim.opt.tnnproto";
    ObjectDetectiobParam model_param = RETAILS_DET_MODEL;
    model_param.input_width = 320;
    model_param.input_height = 160;
    model_param.freeze_header = true; //如果模型是freeze的，则设置freeze_header=true
    model_param.use_rgb = true;

    // 设置检测阈值
    const float scoreThresh = 0.5;
    const float iouThresh = 0.3;
    ObjectDetection *detector = new ObjectDetection(model_file,
                                                    proto_file,
                                                    model_param,
                                                    num_thread,
                                                    device);
    string image_dir = "../data/test_image/retails";
    std::vector<string> image_list = get_files_list(image_dir);
    for (string image_path:image_list) {
        cv::Mat bgr_image = cv::imread(image_path);
        if (bgr_image.empty()) continue;
        FrameInfo resultInfo;
        printf("init frame\n");
        // 开始检测
        detector->detect(bgr_image, &resultInfo, scoreThresh, iouThresh);
        // 可视化代码
        detector->visualizeResult(bgr_image, &resultInfo);
    }
    delete detector;
    detector = nullptr;
    printf("FINISHED.\n");
}

int main() {
    test_face_person_detector();
     //test_card_detector();
//    test_retails_detector();
    return 0;
}
