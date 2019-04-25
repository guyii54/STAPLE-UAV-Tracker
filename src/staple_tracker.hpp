#ifndef STAPLE_TRACKER_HPP
#define STAPLE_TRACKER_HPP

#include <iostream>
#include <vector>
#include <string>
#include <cmath>

#include <opencv2/opencv.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/features2d/features2d.hpp>

///
/// \brief The staple_cfg struct
///
struct staple_cfg
{
    bool grayscale_sequence = false;    // suppose that sequence is colour
    int hog_cell_size = 4;
    int fixed_area = 150*150;           // standard area to which we resize the target
    int n_bins = 2*2*2*2*2;             // number of bins for the color histograms (bg and fg models)
    double learning_rate_pwp = 0.04;    // bg and fg color models learning rate
    const char * feature_type = "fhog"; // "fhog", ""gray""
    double inner_padding = 0.2;         // defines inner area used to sample colors from the foreground
    double output_sigma_factor = 1/16.0; // standard deviation for the desired translation filter output
    double lambda = 1e-3;               // egularization weight
    double learning_rate_cf = 0.01;     // HOG model learning rate
//     double merge_factor = 0.3;          // fixed interpolation factor - how to linearly combine the two responses
    double merge_factor = 0.9;
    const char * merge_method = "const_factor";
    bool den_per_channel = false;

    // scale related
    bool scale_adaptation = true;
    int hog_scale_cell_size = 4;         // Default DSST=4
//     double learning_rate_scale = 0.025;	//original
    double learning_rate_scale = 0.025;
    double scale_sigma_factor = 1/4.0;
    int num_scales = 33;
    double scale_model_factor = 1.0;
    double scale_step = 1.03;
    double scale_model_max_area = 32*16;
    //new
//     double w_scale_step = 1.02;
//     double h_scale_step = 1.02;
//     double h_nscale = 5;
//     double w_nscale = 5;

    // debugging stuff
    int visualization = 0;              // show output bbox on frame
    int visualization_dbg = 0;          // show also per-pixel scores, desired response and filter output



    cv::Point_<float> init_pos;
    cv::Size target_sz;
};

///
/// \brief The STAPLE_TRACKER class
///
class STAPLE_TRACKER
{
public:
    STAPLE_TRACKER()
    {
        cfg = default_parameters_staple(cfg);
        frameno = 0;
    }
    ~STAPLE_TRACKER(){}

    void mexResize(const cv::Mat &im, cv::Mat &output, cv::Size newsz, const char *method);
    void tracker_staple_train(const cv::Mat &im, bool first);
    void tracker_staple_initialize(const cv::Mat &im, cv::Rect_<float> region);
    cv::Rect tracker_staple_update(const cv::Mat &im);
    staple_cfg cfg;
    std::vector<cv::Rect> rects;

    cv::Rect firstroi;

    cv::Mat lastroi;

    double maxresponse;
    double cfmaxresponse,pwpmaxresponse;
    double confidence;
    double cfconfidence,pwpconfidence;


protected:
    staple_cfg default_parameters_staple(staple_cfg cfg);
    void initializeAllAreas(const cv::Mat &im);

    void getSubwindow(const cv::Mat &im, cv::Point_<float> centerCoor, cv::Size model_sz, cv::Size scaled_sz, cv::Mat &output);
    void getSubwindowFloor(const cv::Mat &im, cv::Point_<float> centerCoor, cv::Size model_sz, cv::Size scaled_sz, cv::Mat &output);
    void updateHistModel(bool new_model, cv::Mat &patch, double learning_rate_pwp=0.0);
    void CalculateHann(cv::Size sz, cv::Mat &output);
    void gaussianResponse(cv::Size rect_size, double sigma, cv::Mat &output);
    void getFeatureMap(cv::Mat &im_patch, const char *feature_type, cv::MatND &output);
    void cropFilterResponse(const cv::Mat &response_cf, cv::Size response_size, cv::Mat& output);
    void getColourMap(const cv::Mat &patch, cv::Mat& output);
    void getCenterLikelihood(const cv::Mat &object_likelihood, cv::Size m, cv::Mat& center_likelihood);
    void mergeResponses(const cv::Mat &response_cf, const cv::Mat &response_pwp, cv::Mat &response);
    void getScaleSubwindow(const cv::Mat &im, cv::Point_<float> centerCoor, cv::Mat &output);
    void sumMat(cv::Mat &im, double sum, double mean);
    void getconfidence(cv::Mat response, double &confidence, double &maxVal, cv::Point maxLoc);
    double compute_PSNR(cv::Mat lastroi, cv::Mat currentroi);

private:
    

    cv::Point_<float> pos;
    cv::Size target_sz;

    cv::Rect predict_rect;

    cv::Size bg_area;
    cv::Size fg_area;
    double area_resize_factor;
    cv::Size cf_response_size;

    cv::Size norm_bg_area;
    cv::Size norm_target_sz;
    cv::Size norm_delta_area;
    cv::Size norm_pwp_search_area;

    cv::Mat im_patch_pwp;

    cv::MatND bg_hist;
    cv::MatND fg_hist;

    cv::Mat hann_window;
    cv::Mat yf;

    std::vector<cv::Mat> hf_den;
    std::vector<cv::Mat> hf_num;

    cv::Rect rect_position;

    float scale_factor;
    cv::Mat scale_window;
    cv::Mat scale_factors;
    cv::Size scale_model_sz;
    float min_scale_factor;
    float max_scale_factor;
    cv::Size base_target_sz;

    cv::Mat ysf;	//为尺度滤波器构造的高斯得分
    cv::Mat sf_den;
    cv::Mat sf_num;

    int frameno = 0;
};

#endif
