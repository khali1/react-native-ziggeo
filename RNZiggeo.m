#import "RNZiggeo.h"

@interface RNZiggeo ()

@property (nonatomic, strong) Ziggeo* ziggeo;

@end

@implementation RNZiggeo

RCT_EXPORT_MODULE(ReactNativeZiggeo)

RCT_EXPORT_METHOD(initialize:(NSString *)token)
{
  self.ziggeo = [[Ziggeo alloc] initWithToken:token];
}

RCT_EXPORT_METHOD(createVideo:(NSString *)videoPath
                  callback:(RCTResponseSenderBlock)callback
                  progress:(RCTResponseSenderBlock)progress)
{
  //RCTLogInfo(@"Pretending to create an event %@ at %@", name, location);


  [self.ziggeo.videos createVideoWithData:nil
                                     file:videoPath
                                    cover:nil
                                 callback:^(NSDictionary *jsonObject, NSURLResponse *response, NSError *error)
   {
     NSLog(@"video upload complete: %@, error = %@", jsonObject, error);
     callback(@[jsonObject]);
   } Progress:^(int bytesSent, int totalBytes)
   {
     NSLog(@"video upload progress: %i/%i", bytesSent, totalBytes);
     progress(@[@(bytesSent), @(totalBytes)]);
   }];
}

RCT_EXPORT_METHOD(indexWithCallback:(RCTResponseSenderBlock)callback)
{
  [self.ziggeo.videos indexWithData:nil Callback:^(NSArray *jsonArray, NSError *error) {
    //the completion block will be executed asynchronously on the response received
    NSLog(@"videos: %@\nerror: %@", jsonArray, error);
    callback(@[jsonArray]);
  }];
}

@end
