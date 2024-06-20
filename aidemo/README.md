# ssd-detection-tnn-sdk
SSD目标检测
- 支持人脸检测和关键点检测
- 支持人脸+人体检测
- 支持人体检测

## 1.目录结构
```
.
├── 3rdparty
├── data
├── src
├── docs
├── build.sh
├── CMakeLists.txt
├── README.md
└── result.jpg
```

## 2.配置说明
#### (1)依赖库
- TNN：https://github.com/Tencent/TNN
- OpenCV: https://opencv.org/releases （推荐opencv-4.3.0）
- OpenCL: https://software.intel.com/content/www/us/en/develop/tools/opencl-sdk/choose-download.html (GPU的支持)
- base-utils：https://github.com/PanJinquan/base-utils  (一些文件和图像处理的相关工具)

#### (2)配置说明
- git clone https://***/object-detection-tnn-sdk
- 拉取子模块submodule(TNN,base-utils)库

```bash
# pull 3rdparty(TNN,base-utils) submodule
git submodule init
git submodule update
```

- 配置OpenCV
> 推荐opencv-4.3.0
  
```bash
mkdir build
cd build
cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local ..
sudo make install
```

- 配置OpenCL（可选）
> Android系统一般都支持OpenCL，Linux系统可参考如下配置：

```bash
# 参考安装OpenCL： https://blog.csdn.net/qq_28483731/article/details/68235383，作为测试，安装`intel cpu版本的OpenCL`即可
# 安装clinfo，clinfo是一个显示OpenCL平台和设备的软件
sudo apt-get install clinfo
# 安装依赖
sudo apt install dkms xz-utils openssl libnuma1 libpciaccess0 bc curl libssl-dev lsb-core libicu-dev
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
sudo apt-get install mono-complete
# 在intel官网上下载了intel SDK的tgz文件，并且解压
sudo sh install.sh
```

## 3.CMake配置说明
#### (1)Linux OR Windows测试，`CMakeLists.txt`
```cmake
# TNN set
    set(TNN_OPENCL_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_CPU_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_X86_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_QUANTIZATION_ENABLE OFF CACHE BOOL "" FORCE)
    set(TNN_OPENMP_ENABLE ON CACHE BOOL "" FORCE)  # Multi-Thread
    add_definitions(-DTNN_OPENCL_ENABLE)           # for OpenCL GPU
    add_definitions(-DDEBUG_ON)                    # for WIN/Linux Log
    add_definitions(-DDEBUG_LOG_ON)                # for WIN/Linux Log
    add_definitions(-DDEBUG_IMSHOW_OFF)            # for OpenCV show
    add_definitions(-DPLATFORM_LINUX)
    # add_definitions(-DPLATFORM_WINDOWS)
```

#### (2)Android测试，`CMakeLists.txt`
```cmake
# TNN set
    set(TNN_OPENCL_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_ARM_ENABLE ON CACHE BOOL "" FORCE)
    set(TNN_BUILD_SHARED OFF CACHE BOOL "" FORCE)
    set(TNN_OPENMP_ENABLE ON CACHE BOOL "" FORCE)  # Multi-Thread
    #set(TNN_HUAWEI_NPU_ENABLE OFF CACHE BOOL "" FORCE)
    add_definitions(-DTNN_OPENCL_ENABLE)           # for OpenCL GPU
    add_definitions(-DTNN_ARM_ENABLE)              # for Android CPU
    add_definitions(-DDEBUG_ANDROID_ON)            # for Android Log
    add_definitions(-DPLATFORM_ANDROID)
```

## 4.模型参数说明
- 模型需要配置的参数如下：
```c++

/***
 * SSD Detection Model Param
 */
struct ObjectDetectiobParam {
    int input_width;                       // 模型输入宽度，单位：像素
    int input_height;                      // 模型输入高度，单位：像素
    bool use_rgb;                          // 是否使用RGB作为模型输入（PS：接口固定输入BGR，use_rgb=ture时，预处理将BGR转换为RGB）
    bool freeze_header;                    // 模型anchor是否进行了固化处理,固化后，可以加速，但会要求固定的输入分辨率
    int num_landmarks;                     // 关键点个数
    vector<vector<float>> min_boxes;       // anchor大小，单位：像素
    vector<float> strides;                 // 每个featuremap的缩放倍数
    vector<vector<float>> aspect_ratios;   // anchor的长宽比
    NetNodes InputNodes;                   // 输入节点名称
    NetNodes OutputNodes;                  // 输出节点名称
    vector<string> class_names;            // 类别集合
};
```

## 6.Demo
- `bash build.sh`


 i=0,bboxe:[247.76387,250.78210,304.97583,329.90674],score:0.99950
 i=1,bboxe:[106.47206,31.37002,158.35550,101.62581],score:0.99887