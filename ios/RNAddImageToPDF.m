#import <React/RCTBridge.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface RCT_EXTERN_MODULE(RNAddImageToPDF, NSObject)

RCT_EXTERN_METHOD(loadImageToPDF: (NSString *)pdfPath
                  imagePath: (NSString *)imagePath
                  x: (CGFloat)x
                  y: (CGFloat)y
                  width: (CGFloat)width
                  height: (CGFloat)height
                  resolver: (RCTPromiseResolveBlock)resolver
                  rejecter: (RCTPromiseRejectBlock)rejecter)

@end
