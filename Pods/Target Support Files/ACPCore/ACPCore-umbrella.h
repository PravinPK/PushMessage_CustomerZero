#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ACPCoreUmbrella.h"
#import "ACPCore.h"
#import "ACPExtensionEvent.h"
#import "ACPMobileVisitorId.h"
#import "NSError+AEPError.h"
#import "ACPBridgeExtension.h"
#import "ACPExtension.h"
#import "ACPExtensionApi.h"
#import "ACPExtensionError.h"
#import "ACPExtensionListener.h"
#import "ACPIdentity.h"
#import "ACPLifecycle.h"
#import "ACPSignal.h"

FOUNDATION_EXPORT double ACPCoreVersionNumber;
FOUNDATION_EXPORT const unsigned char ACPCoreVersionString[];

