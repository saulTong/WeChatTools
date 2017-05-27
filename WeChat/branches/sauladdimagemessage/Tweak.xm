#import "WeChat/WCTimeLineViewController.h"
#import "WeChat/MMImagePickerController.h"
#import "WeChat/MMAssetPickerController.h"

%hook MMAssetPickerController

- (void)OnSend:(id)arg1
{
%orig;
NSLog(@"\n OnSend \n %@ \nend",arg1);
}

- (void)processingImageAtIndex:(id)arg1
{
%orig;
NSLog(@"\n processingImageAtIndex \n %@ \nend",arg1);

}
%end

%hook MMImagePickerController

- (void)MMImagePickerController:(id)arg1 didFinishPickingMediaWithInfo:(id)arg2{
%orig;
NSLog(@"\n MMImagePickerController \n %@ \n %@ \n end",arg1,arg2);

}

- (void)MMImagePickerControllerDidCancel:(id)arg1{
%orig;
NSLog(@"\n MMImagePickerControllerDidCancel \n %@ \n end",arg1);

}

- (void)selectedAssets:(id)arg1{
%orig;
NSLog(@"\n selectedAssets \n %@ \n end",arg1);

}

- (int)getPickerScene{
int orig = %orig;
NSLog(@"\n selectedAssets \n %lld@ \n end",(long long)orig);
return orig;
}


%end

%hook WCTimeLineViewController

- (void)viewDidLoad {
%orig;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)),
    dispatch_get_main_queue(), ^{

        [self showImagePicker:0];

    });
}

%end
/*
 *  发送文字  - (void)openWriteTextViewController

 * 拍照和照片 - (void)showImagePicker:(long long)arg1; 1是拍照
    MMAssetPickerController
 * 小视频
*/

