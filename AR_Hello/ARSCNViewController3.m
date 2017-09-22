//
//  ARSCNViewController3.m
//  AR_Hello
//
//  Created by MAC on 2017/9/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ARSCNViewController3.h"

@implementation ARSCNViewController3

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
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    SCNNode *planeNode = scene.rootNode.childNodes[0];
    
    planeNode.scale = SCNVector3Make(0.5, 0.5, 0.5);
    planeNode.position = SCNVector3Make(0, -15,-15);
    
    //一个飞机的3D建模不是一气呵成的，可能会有很多个子节点拼接，所以里面的子节点也要一起改，否则上面的修改会无效
    for (SCNNode *node in planeNode.childNodes)
    {
        node.scale = SCNVector3Make(0.5, 0.5, 0.5);
        node.position = SCNVector3Make(0, -15,-15);
    }
    
    [self.arSCNView.scene.rootNode addChildNode:planeNode];
    self.planeNode = planeNode;
}





#pragma mark -ARSessionDelegate
- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame
{
    if(self.planeNode)
    {
        //捕捉相机的位置，让节点随着相机移动而移动
        //根据官方文档记录，相机的位置参数在4X4矩阵的第三列
        
        self.planeNode.position = SCNVector3Make(frame.camera.transform.columns[3].x,frame.camera.transform.columns[3].y,frame.camera.transform.columns[3].z);
    }
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
