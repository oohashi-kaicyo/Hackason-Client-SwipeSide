//
//  BroadCaster.h
//  Hackason
//
//  Created by oohashi on 2015/07/07.
//  Copyright (c) 2015年 Yasuhiro.Hashimoto. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

/**
 * Beacon化の為のClassです．
 *
 * setWithUUIDでアドバタイズしたいBeacon識別番号を設定
 * Pattern1: Display Mode | Swipe ModeのSwitchをトリガー
 *     永続的に起動
 * Pattern1: Contents送信完了のタイミングでアドバタイズ
 *     なんらかのタイミングでstopBroadCartを呼び出し，アドバタイズ終了
 */
@interface BroadCaster : NSObject <CBPeripheralManagerDelegate>

@property(nonatomic) CLBeaconRegion      *beaconRegion;
@property(nonatomic) CBPeripheralManager *peripheralManager;

+ (BroadCaster *)SharedManerger;
- (void)setWithUUID: (NSString *)uuid
              major: (NSString *)major
              minor: (NSString *)minor
         identifier: (NSString *)identifier;
- (void)startBroadCast;
- (void)stopBroadCast;

@end
