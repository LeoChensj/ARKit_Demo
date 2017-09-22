//
//  ARSCNViewController2.m
//  AR_Hello
//
//  Created by MAC on 2017/9/22.
//  Copyright © 2017年 MAC. All rights reserved.
//

#import "ARSCNViewController2.h"

@implementation ARSCNViewController2

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




#pragma mark - ARSCNViewDelegate
//添加节点时候调用
- (void)renderer:(id <SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    if ([anchor isMemberOfClass:[ARPlaneAnchor class]])
    {
        NSLog(@"捕捉到平地");
        
        //添加一个3D平面模型，ARKit只有捕捉能力，锚点只是一个空间位置，要想更加清楚看到这个空间，我们需要给空间添加一个平地的3D模型来渲染他
        
        //1.获取捕捉到的平地锚点
        ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
        
        //2.创建一个3D物体模型    （系统捕捉到的平地是一个不规则大小的长方形，这里笔者将其变成一个长方形，并且是否对平地做了一个缩放效果）
        //参数分别是长宽高和圆角
        SCNBox *plane = [SCNBox boxWithWidth:planeAnchor.extent.x*0.3 height:0 length:planeAnchor.extent.x*0.3 chamferRadius:0];
        
        //3.使用Material渲染3D模型（默认模型是白色的，这里笔者改成红色）
        plane.firstMaterial.diffuse.contents = [UIColor redColor];
        
        //4.创建一个基于3D物体模型的节点
        SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
        
        //5.设置节点的位置为捕捉到的平地的锚点的中心位置  SceneKit框架中节点的位置position是一个基于3D坐标系的矢量坐标SCNVector3Make
        planeNode.position =SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
        
        [node addChildNode:planeNode];
        
        
        //1s之后在平地添加飞机
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
            
            SCNNode *shipNode = scene.rootNode.childNodes[0];
            
            shipNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
            
            [node addChildNode:shipNode];
            
        });
    }
}
//刷新时调用
- (void)renderer:(id <SCNSceneRenderer>)renderer willUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    NSLog(@"刷新中");
}

//更新节点时调用
- (void)renderer:(id <SCNSceneRenderer>)renderer didUpdateNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    NSLog(@"节点更新");
}

//移除节点时调用
- (void)renderer:(id <SCNSceneRenderer>)renderer didRemoveNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor
{
    NSLog(@"节点移除");
}



#pragma mark -ARSessionDelegate
//会话位置更新（监听相机的移动），此代理方法会调用非常频繁，只要相机移动就会调用，如果相机移动过快，会有一定的误差，具体的需要强大的算法去优化，笔者这里就不深入了
- (void)session:(ARSession *)session didUpdateFrame:(ARFrame *)frame
{
    //NSLog(@"相机移动");
}
- (void)session:(ARSession *)session didAddAnchors:(NSArray<ARAnchor*>*)anchors
{
    NSLog(@"添加锚点");
    
}
- (void)session:(ARSession *)session didUpdateAnchors:(NSArray<ARAnchor*>*)anchors
{
    NSLog(@"刷新锚点");
    
}
- (void)session:(ARSession *)session didRemoveAnchors:(NSArray<ARAnchor*>*)anchors
{
    NSLog(@"移除锚点");
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
