//
//  ARSCNViewController.h
//  AR_Hello
//
//  Created by MAC on 2017/9/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SceneKit/SceneKit.h>
#import <ARKit/ARKit.h>

@interface ARSCNViewController : UIViewController

//AR视图：展示3D界面
@property (nonatomic, strong)ARSCNView *arSCNView;

//会话追踪配置：负责追踪相机的运动
@property (nonatomic, strong)ARWorldTrackingConfiguration *arConfiguration;

@end
