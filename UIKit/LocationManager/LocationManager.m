//
//  LocationManager.m
//  ModelProduct
//
//  Created by apple on 16/1/13.
//  Copyright (c) 2016年 chj. All rights reserved.
//

#import "LocationManager.h"
#import <CoreLocation/CoreLocation.h>


@interface LocationManager()<CLLocationManagerDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)CLLocationManager *locationManager;
@property (nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation LocationManager


+ (id)shareInStance {
    static LocationManager *manager=nil;
    static dispatch_once_t dispathone;
    dispatch_once(&dispathone, ^{
        manager=[[LocationManager alloc]init];
    });
    return manager;
}

- (void)startUserLocation {
    
    self.locationManager.delegate=nil;
    [self.locationManager stopUpdatingLocation];
    
    
    _locationManager =[[CLLocationManager alloc]init];

    
    //定位服务是否可用
    BOOL enable=[CLLocationManager locationServicesEnabled];
    //是否具有定位权限
    int status=[CLLocationManager authorizationStatus];
    
    if (!enable || status <3) {
        //请求权限
        if (kAPP_System_Version >= 8.0) {
            [_locationManager requestWhenInUseAuthorization];
        }
    }
    
    if([CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        //用户已经明确拒绝授权对于这个应用程序
        //或设置位置服务被禁用。
        
        [self initEnableAlertView];
        
        return;
    }
    
    
    
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=100.0f;
    self.locationManager.delegate=self;
    [self.locationManager startUpdatingLocation];
    
}
- (void)stopUserLocation {
    self.locationManager.delegate=nil;
    [self.locationManager stopUpdatingLocation];

}


//用户没有开启定位
- (void)initEnableAlertView {
    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"提示" message:@"尚未开启定位，请在设置-隐私-定位服务中开启定位" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

#pragma CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *nowLocation=[locations lastObject];
    
    NSString *str_latitude=[NSString stringWithFormat:@"%f",nowLocation.coordinate.latitude];
    NSString *str_longitude=[NSString stringWithFormat:@"%f",nowLocation.coordinate.longitude];
    ksetDefaultValueForKey(str_latitude, kUserLocationLatitude);
    ksetDefaultValueForKey(str_longitude, kUserLocationLongitude);
    
    
    //反地理编码
    
    CLGeocoder *locationGeo=[[CLGeocoder alloc]init];
    
    [locationGeo reverseGeocodeLocation:nowLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (!error && [placemarks count] > 0) {
            
            NSDictionary *dic=[[placemarks objectAtIndex:0] addressDictionary];
            
            NSArray *formatted=[dic objectForKey:@"FormattedAddressLines"];
            ksetDefaultValueForKey([formatted objectAtIndex:0], kUserLocationAddressInfo);
            
            ksetDefaultValueForKey([dic objectForKey:@"City"], kUserLocationCity);
            ksetDefaultValueForKey([dic objectForKey:@"Country"], kUserLocationCity);
       
            [self stopUserLocation];
        }
        
        
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    [self startUserLocation];
}


#pragma UIAlertView Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self stopUserLocation];
        
        [self startUserLocation];
    }
}

@end
