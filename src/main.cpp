#include "staple_tracker.hpp"

#include <iostream>
#include <vector>
#include <string>
#include <fstream>
#include <numeric>

#include <opencv2/opencv.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

#include <time.h>


#include <stdio.h>
#include <stdlib.h>
#include <opencv2/highgui.hpp>
#include <opencv2/opencv.hpp>
#include <iostream>
#include <fstream>
#include <sstream>
#include <opencv2/core.hpp>
#include <opencv2/videoio.hpp>

#define TEST_FPS
// #define SAVE_VIDEO


using namespace cv;
using namespace std;


cv::Rect_<float> getAxisAlignedBB(std::vector<cv::Point2f> polygon);
std::vector<cv::Rect_<float>> getgroundtruth(std::string txt_file);

int main(int argc, char * argv[])
{

      cv::Mat image;
      cv::Rect_<float> location;
      cv::Rect_<float> truebound;
      cv::Rect_<float> overlap;
      double fps;
      double av_fps = 1;
      float iou;
      float av_iou = 1;
      double time_used;
      int frame_count;

      
      std::string fpsSTRING;	//fps
      char fpsvalue[10];
      std::string iouSTRING;	//fps
      char iouvalue[10];     


    std::string read_path = "/home/nvidia/Videos/s_video/";
    std::string filename;
    std::string suffix = "/1(%d).jpg";
    std::string groundtruthsuffix = "/groundtruth.txt";
    std::cin >> filename;

//    std::string read_path = "/home/nvidia/Videos/s_video/";
//    std::string filename;
//    std::string suffix = ".mp4";
//    std::cin>>filename;

    std::string groundtruth_path = read_path+filename+groundtruthsuffix;
    std::string w_read_path = read_path+filename+suffix;


    VideoCapture cap(w_read_path);
    cap >> image;


#ifdef SAVE_VIDEO
    std::string write_path="../processed/";
    std::string w_write_path = write_path+filename+".avi";
    VideoWriter writer(w_write_path,CV_FOURCC('M','J','P','G'),24,Size(640,360));
//    VideoWriter writer(w_write_path,CV_FOURCC('M','J','P','G'),24,Size(1280,720));
#endif

   std::vector<cv::Rect_<float>> groundtruth_rect;

   groundtruth_rect = getgroundtruth(groundtruth_path);
   
   
//    for (size_t i = 0; i < groundtruth_rect.size(); ++i)
//      std::cout << i+1 << '\t' <<groundtruth_rect[i] << std::endl;

    STAPLE_TRACKER staple;

//    cv::Rect_<float> location = groundtruth_rect[0];
//    namedWindow("frame");
//     std::vector<cv::Rect_<float>> result_rects;
//    double time = 0;
//    std::cout<<"total:"<<image_files.size()<<std::endl;
    bool show_visualization = true;

   
    
    cv::rectangle(image, groundtruth_rect[0], cv::Scalar(0, 255, 0), 2);
    imshow("STAPLE", image);
    location = groundtruth_rect[0];
//     location = selectROI("STAPLE",image);

#ifdef TEST_FPS
    double start_fps,end_fps,dur_fps;
#endif

    for (frame_count=1;; frame_count++)
    {
//        image = cv::imread(image_files[frame]);

        if (frame_count == 1)
        {
            staple.tracker_staple_initialize(image, location);
            staple.tracker_staple_train(image, true);
        }
        else
        {
            cap >> image;
	    if(image.empty())
	    {
	      av_iou = av_iou/frame_count;
	      cout<<"video empty!"<<endl;
	      break;
	    }
            start_fps = clock();
            location = staple.tracker_staple_update(image);
            staple.tracker_staple_train(image, false);
	    overlap = location & groundtruth_rect[frame_count];
        }
#ifdef TEST_FPS
        end_fps = clock();
        dur_fps =end_fps-start_fps;
        time_used = (double)(dur_fps)/CLOCKS_PER_SEC;
        fps =1/time_used;
// 	av_fps += fps;
#endif

//         result_rects.push_back(location);
	iou = overlap.area()/(location.area()+groundtruth_rect[frame_count].area()-overlap.area());
	av_iou += iou;

        if (show_visualization)
        {
	  sprintf(fpsvalue,"%.2f",fps);
	  fpsSTRING = "fps:";
	  fpsSTRING += fpsvalue;
	  
	  sprintf(iouvalue,"%.3f",iou);
	  iouSTRING = "iou:";
	  iouSTRING += iouvalue;
	  
	  cv::putText(image, fpsSTRING,cv::Point(20, 40),FONT_HERSHEY_SIMPLEX, 1,
	      cv::Scalar(0, 255, 255), 2);
	  cv::putText(image, iouSTRING,cv::Point(20, 68),FONT_HERSHEY_SIMPLEX,1,
	      cv::Scalar(0, 255, 255), 2);
	  cv::rectangle(image, groundtruth_rect[frame_count], cv::Scalar(0, 255, 0), 2);
	  cv::rectangle(image, location, cv::Scalar(0, 0, 255), 2);
// 	    cv::rectangle(image, overlap, cv::Scalar(0, 0, 255), 2);
	  cv::imshow("STAPLE", image);

#ifdef SAVE_VIDEO
        writer << image;
#endif
            char key = cv::waitKey(10);
            if (key == 27 || key == 'q' || key == 'Q')
	    {
	      av_iou = av_iou/frame_count;
	      cout<<"average of iou:"<<av_iou<<endl;
	      break;
        
	    }
	}
    }
    cv::destroyAllWindows();

    return 0;
}

cv::Rect_<float> getAxisAlignedBB(std::vector<cv::Point2f> polygon)
{
    double cx = double(polygon[0].x + polygon[1].x + polygon[2].x + polygon[3].x) / 4.;
    double cy = double(polygon[0].y + polygon[1].y + polygon[2].y + polygon[3].y) / 4.;
    double x1 = std::min(std::min(std::min(polygon[0].x, polygon[1].x), polygon[2].x), polygon[3].x);
    double x2 = std::max(std::max(std::max(polygon[0].x, polygon[1].x), polygon[2].x), polygon[3].x);
    double y1 = std::min(std::min(std::min(polygon[0].y, polygon[1].y), polygon[2].y), polygon[3].y);
    double y2 = std::max(std::max(std::max(polygon[0].y, polygon[1].y), polygon[2].y), polygon[3].y);
    double A1 = norm(polygon[1] - polygon[2])*norm(polygon[2] - polygon[3]);
    double A2 = (x2 - x1) * (y2 - y1);
    double s = sqrt(A1 / A2);
    double w = s * (x2 - x1) + 1;
    double h = s * (y2 - y1) + 1;
    cv::Rect_<float> rect(cx-1-w/2.0, cy-1-h/2.0, w, h);
    return rect;

}

std::vector<cv::Rect_<float>> getgroundtruth(std::string txt_file)
{
    std::vector<cv::Rect_<float>> rects;
    std::ifstream gt;
    gt.open(txt_file.c_str());
    if (!gt.is_open())
        std::cout << "Ground truth file " << txt_file
        << " can not be read" << std::endl;
    std::string line;
//     float x1, y1, x2, y2, x3, y3, x4, y4;
    float xmin,xmax,ymin,ymax;
    while (getline(gt, line)) 
    {
//         std::replace(line.begin(), line.end(), ',', ' ');
        std::stringstream ss;
        ss.str(line);
        ss >> xmin>> xmax >> ymin >>ymax;
        std::vector<cv::Point2f>polygon;
        polygon.push_back(cv::Point2f(xmin,ymin));
        polygon.push_back(cv::Point2f(xmax,ymin));
        polygon.push_back(cv::Point2f(xmax,ymax));
        polygon.push_back(cv::Point2f(xmin,ymax));
        rects.push_back(getAxisAlignedBB(polygon)); //0-index
    }
    gt.close();
    return rects;
}


