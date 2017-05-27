#import "WeChat/WWKAttendanceCheckViewController.h"
#import <CoreLocation/CoreLocation.h>


%hook WWKAttendanceCheckViewController

- (void)locationManager:(id)arg1 didUpdateLocations:(id)arg2 {


//40.0266714969,116.4835013435
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:40.0266714969 longitude:116.4835013435];
    NSArray *array = [[NSArray alloc] initWithObjects:loc, nil];
    arg2 = array;
/*
// +40.00458953,+116.42153540
*/

NSLog(@" \n didUpdateLocations \n\n  arg1: \n\n %@ \n\n arg2:\n\n %@ \n\n didUpdateLocations", arg1 , arg2);

}

- (void)mapView:(id)arg1 didUpdateUserLocation:(id)arg2 updatingLocation:(_Bool)arg3
{
%orig;

NSLog(@" \n didUpdateUserLocation \n\n  arg1: \n\n %@ \n\n arg2:\n\n %@ \n\n didUpdateUserLocation", arg1 , arg2);

}


%end
