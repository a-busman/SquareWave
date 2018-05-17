//
//  FileEngine.h
//  Square Wave
//
//  Created by Alex Busman on 5/8/18.
//  Copyright © 2018 Alex Busman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "SSZipArchive.h"

#define __DEBUG_FILE_ENGINE

#if defined(__DEBUG_FILE_ENGINE)
#define __DEBUG_FE(m, ...) NSLog((m), __VA_ARGS__)
#else
#define __DEBUG_FE(m, ...)
#endif

@interface FileEngine : NSObject
+ (BOOL) addFile:(nonnull NSURL *)url;
+ (void) refreshDatabase;
@end
