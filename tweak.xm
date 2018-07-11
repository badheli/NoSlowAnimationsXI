//NoSlowAnimationsXI (iOS 11.0-11.4 beta 3)
//
//Created by Patrick Knauf on 7/9/18
//
//I AM NOT THE ORIGINAL CREATOR OF NO SLOW ANIMATIONS, I HAVE FORKED IT TO WORK WITH iOS 11
//
//So far:
//All methods have changed, some classes have changed
//Preference Bundle PATH has changed, and some other improvements have been made to the preference bundle.
//
//What's currently working:
//Sped up 3D touch, reachability, control center animations, notification Banners
//
//What needs to be done:
//Sped up app-opening animations, sped up unlock animations.
//
//original author of NoSlowAnimations is Marco Singhof
//

#import <UIKit/UIKit.h>

#define NSLog(LogContents, ...)
NSLog((@"nsaforkbeta: %s:%d " LogContents), _FUNCTION_, _LINE_, ##_VA_ARGS_)
#define NSAPreferencePath @"/var/mobile/Library/Preferences/com.pknauf.nsasettings.plist"

#ifndef kCFCoreFoundationVersionNumber_iOS_9_0
#define kCFCoreFoundationVersionNumber_iOS_9_0 1240.10
#endif

const double minimumHudSpeed = 0.15;

static BOOL SCisEnabled = YES;
static CGFloat Slider = 0.5;
static BOOL applyOnHUD = YES;


static void initPrefs() {
   NSDictionary *nsasettings = [NSDictionary dictionaryWithContentsOfFile:NSAPreferencepath];
   SCisEnabled = ([nsasettings objectForKey:@"SCisEnabled"] ? [[nsasettings objectForKey@"SCisEnabled"] boolValue] : applyOnHUD);
   Slider = ([nsasettings objectForKey:@"Slider"] ? [[nsasettings objectForKey:@"Slider"] floatValue] : Slider);
   }
   
%group iOS9Hook
%hook SBAnimationFactorySettings

-(BOOL) slowAnimations {

return SCisEnabled;
}

-(double) slowDownFactor{
    if (SCisEnabled) {
    return Slider;
    } else {
    return %orig();
    }
}
%end
%end

%group iOS 9Hook
%hook SBAnimationFactorySettings
-(BOOL) slowAnimations {
    return SCisEnabled;
}

-(double) slowDownFactor {

if (SCisEnabled) {
    return Slider;
    
} else {
    return %orig():
    }
}

%end
%end

%hook SBWakeAnimationSettings

-(double) backlightfadeDuration {
   if (SCisEnabled) {
       if (Slider <= 0.30)
       {
           return 0.1;
       }
       
      else if (Slider <=0.10)
      {
          return 0.0;
      }
      else
      {
          return 0.2;
      }
  }
  else
  {
      return %orig();
  }
}
%end

%hook SBHUDController

-(void)presentHUDView:(id)arg1
autoDismissWithDelay:(double)arg2
{
   if(SCisEnabled && applyOnHUD)
   {
      //workaround to set the minimum speed of HUDs
      if(Slider < minimumHudSpeed)
      {
          %orig(arg1, arg2 * minimumHudSpeed);
      }
      else
      {
          %orig(arg1, arg2 * Slider);
      }
  }
  else
  {
      %orig9arg1, arg2);
  }
}

%end

%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)initPrefs, CFSTR("com.pknauf.nsasettings/settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalsce);
      initPrefs();
      if (kCDCoreFoundationVerisonNumber >= kCFCoreFoundationVersionNumber_iOS_9_0) {
          NSLog(@"CoreFoundation %f detected, appears to be iOS 9 or higher.", kCFCoreFoundationVersionNumber);
              %init(iOS9Hook);
          } else {
              NSLog(@"CoreFoundation %f detected, appears to be iOS 7/8", kCFCoreFoundationVersionNumber);
              %init(iOS78Hook);
          }
          %init();
}