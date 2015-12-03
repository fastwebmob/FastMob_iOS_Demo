FastMobile SDK开发者文档（iOS）
===

1、	支持系统版本
---
iOS 6.0及以上版本。

2、	服务申请
---
向Fastweb技术人员申请开通账号和开发者Key。


3、	SDK使用方式
---
3.1集成SDK

* 1、将FWMobSDK.framework添加到工程中 
* 2、添加支持库  CoreTelephony.framework, ImageIO.framework, AssetsLibrary.framework, MobileCoreServices.framework, Accelerate.framework, libz.tbd, libresolv.tbd, libstdc++.tbd

3.2 使用方法

* 1、在应用启动时，添加启动服务代码，如下： 

```json
	- (BOOL)application:(UIApplication *)application 
			didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
	｛
		//key为申请流程时提供
    	[FWMobService start:@"your key"]; 
		//YES为debug模式,可以输出log,    NO为release模式.
		[FWMobService debugOn:NO]; 
	｝
```

* 2、在应用进入后台时，添加停止服务代码，如下：

```json
	- (void)applicationDidEnterBackground:(UIApplication *)application
	{ 
	//在进入后台时，可停止停止服务
	[FWMobService stop];  
	//如果需要，可以在进入后台时，延时停止服务
    //[FWMobService delayStopWithTime:10.f];
	｝ 

```
  注: 如果app在后台运行时，继续需要加速服务，则不用在此处调用stop方法。但请在onTermination方法中调用stop方法。

* 3、在应用回到前台时，如果进入后台时停止了服务，请添加启动服务代码，如下：

```json
	- (void)applicationWillEnterForeground:(UIApplication *)application
	{
      [FWMobService start:@"your key"];
	}
```