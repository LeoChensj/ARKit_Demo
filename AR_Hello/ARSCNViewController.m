//
//  ARSCNViewController.m
//  AR_Hello
//
//  Created by MAC on 2017/9/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ARSCNViewController.h"

@implementation ARSCNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.arSCNView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.arSCNView.session runWithConfiguration:self.arConfiguration];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.arSCNView.session pause];
}





- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //1.使用场景加载scn文件（scn格式文件是一个基于3D建模的文件，使用3DMax软件可以创建，这里系统有一个默认的3D飞机）
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    
    //2.获取飞机节点（一个场景会有多个节点，此处我们只写，飞机节点则默认是场景子节点的第一个）
    //所有的场景有且只有一个根节点，其他所有节点都是根节点的子节点
    SCNNode *shipNode = scene.rootNode.childNodes[0];
    shipNode.position = SCNVector3Make(0, -1, -1);
    
    //3.将飞机节点添加到当前屏幕中
    [self.arSCNView.scene.rootNode addChildNode:shipNode];
}






#pragma mark - 懒加载
- (ARSCNView *)arSCNView
{
    if(_arSCNView==nil)
    {
        _arSCNView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        
        //自动刷新灯光（3D游戏用到，此处可忽略）
        _arSCNView.automaticallyUpdatesLighting = YES;
    }
    
    return _arSCNView;
}

- (ARWorldTrackingConfiguration *)arConfiguration
{
    if(_arConfiguration==nil)
    {
        _arConfiguration = [[ARWorldTrackingConfiguration alloc] init];
        
        //设置追踪方向
        _arConfiguration.planeDetection = ARPlaneDetectionHorizontal;
        
        //自适应灯光（相机从暗到强光快速过渡效果会平缓一些）
        _arConfiguration.lightEstimationEnabled = YES;
    }
    
    return _arConfiguration;
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
