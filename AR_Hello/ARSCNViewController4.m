//
//  ARSCNViewController4.m
//  AR_Hello
//
//  Created by MAC on 2017/9/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ARSCNViewController4.h"


@implementation ARSCNViewController4

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
    if(self.planeNode)
    {
        [self.planeNode removeFromParentNode];
    }
    
    
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    self.planeNode = scene.rootNode.childNodes[0];
    
    self.planeNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
    self.planeNode.position = SCNVector3Make(0, -15,-15);
    
    for (SCNNode *node in self.planeNode.childNodes)
    {
        node.scale = SCNVector3Make(0.5, 0.5, 0.5);
        node.position = SCNVector3Make(0, -15,-15);
    }
    
    
    
    
    
    //绕相机旋转的关键点在于：在相机的位置创建一个空节点，然后将台灯添加到这个空节点，最后让这个空节点自身旋转，就可以实现台灯围绕相机旋转
    SCNNode *node1 = [[SCNNode alloc] init];
    node1.position = self.arSCNView.scene.rootNode.position;
    [self.arSCNView.scene.rootNode addChildNode:node1];
    [node1 addChildNode:self.planeNode];
    
    
    CABasicAnimation *moonRotationAnimation = [CABasicAnimation animationWithKeyPath:@"rotation"];
    moonRotationAnimation.duration = 10;
    moonRotationAnimation.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(0, 1, 0, M_PI * 2)];
    moonRotationAnimation.repeatCount = FLT_MAX;
    [node1 addAnimation:moonRotationAnimation forKey:@"moon rotation around earth"];
    
    
    
    CABasicAnimation *moonRotationAnimation2 = [CABasicAnimation animationWithKeyPath:@"rotation"];
    moonRotationAnimation2.duration = 5;
    moonRotationAnimation2.toValue = [NSValue valueWithSCNVector4:SCNVector4Make(1, 1, 1, M_PI * 2)];
    moonRotationAnimation2.repeatCount = FLT_MAX;
    [self.planeNode addAnimation:moonRotationAnimation2 forKey:@"moon rotation"];
}








#pragma mark - 懒加载
- (ARSCNView *)arSCNView
{
    if(_arSCNView==nil)
    {
        _arSCNView = [[ARSCNView alloc] initWithFrame:self.view.bounds];
        
        _arSCNView.delegate = self;
        _arSCNView.session.delegate = self;
        
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
