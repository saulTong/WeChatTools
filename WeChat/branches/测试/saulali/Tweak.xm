#import "ali/ARECameraView.h"
#import "ali/ARERealityViewController.h"

#import "ali/AREFollowCard.h"


%hook ARERealityViewController

- (void)cameraView:(id)arg1 didFindObject:(id)arg2 {
%orig;


}
- (void)viewDidLoad{
%orig;
NSLog(@"\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad\n\n\n\n viewDidLoad \n\n\n  viewDidLoad");
}

- (void)viewWillAppear:(_Bool)arg1 {
%orig;
NSLog(@"\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear\n\n\n\n viewWillAppearviewWillAppearviewWillAppear \n\n\n  viewWillAppear");
}


%end

