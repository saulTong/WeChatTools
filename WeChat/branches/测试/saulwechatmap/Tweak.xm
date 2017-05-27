#import <CoreLocation/CoreLocation.h>
#import <mapkit/mapkit.h>



%hook MMLocationMgr
- (void)locationManager:(id)arg1 didFailWithError:(id)arg2 {
%log;
%orig;


}

- (void)locationManager:(id)arg1 didUpdateHeading:(id)arg2 {
%log;
%orig;


}

- (void)locationManager:(id)arg1 didUpdateToLocation:(id)arg2 fromLocation:(id)arg3 {
%log;
/*
NSString *oreillyAddress = @"天津火车站";
CLGeocoder *myGeocoder = [[CLGeocoder alloc] init];
[myGeocoder geocodeAddressString:oreillyAddress completionHandler:^(NSArray *placemarks, NSError *error) {
if ([placemarks count] > 0 && error == nil) {
NSLog(@"Found %lu placemark(s).", (unsigned long)[placemarks count]);
GEOMapItemStorage *firstPlacemark = [placemarks objectAtIndex:0];
NSLog(@"\n\n\n\n  %@ \n=", firstPlacemark.placemark);
//NSLog(@"Latitude = %f", firstPlacemark.location.coordinate.latitude);
//NSLog(@"\n\n\n\n%@",firstPlacemark);
}
else if ([placemarks count] == 0 && error == nil) {
NSLog(@"Found no placemarks.");
} else if (error != nil) {
NSLog(@"An error occurred = %@", error);
}
}];
*/



CLLocation *location = [[CLLocation alloc] initWithLatitude:47.33975331 longitude:123.99487495];
CLLocation *location1 = [[CLLocation alloc] initWithLatitude:47.33975332 longitude:123.99487496];
arg2 = location;
arg3 = location1;
NSLog(@"\n\n\n\n\n\n %s",object_getClassName(arg3));

%orig;
%log;

}

- (unsigned long long)startUpdateGPSLocation {
%log;
long long orig = %orig;
NSLog(@"%lld",orig);
return orig;
}
- (void)mapView:(id)arg1 didFailToLocateUserWithError:(id)arg2 {
%log;
%orig;


}

- (void)mapView:(id)arg1 didUpdateUserLocation:(id)arg2 {
%log;
%orig;


}



%end
