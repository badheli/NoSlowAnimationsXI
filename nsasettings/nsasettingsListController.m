#import <UIKit/UIKit.h>

#import <Preferences/PSViewController.h>
#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PreferencesAppController.h>
#import <Preferences/PSBundleController.h>
#import <Preferences/PSControltableCell.h>
#import <Preferences/PSDiscreteSlider.h>
#import <Preferences/PSEditableTableCell.h>
#import <Preferences/PSHeaderFooterView.h>
#import <Preferences/PSListItemsController.h>
#import <Preferences/PSRootController.h>
#import <Preferences/PSSliderTableCell.h>
#import <Preferences/PSSwitchTableCell.h>
#import <Preferences/PSSystemPolicyForApp.h>
#import <Preferences/PSTableCell.h>


#define NSAPreferencePath @"/var/mobile/Library/Preferences/com.pknauf.nsasettings.plist"

@interface nsasettingsListController : PSListController {
}
@end

@implementation nsasettingsListController

- (id)specifiers {
    if(_specifiers == nil) {
            _specifiers = [[self loadSpecifiersFromPlistname:@"Root" target:self] retain];
        }
        return _specifiers;
        
  }
  
  -(id) bundle {
      return [NSBundle bundleForClass:[self class]];
}

-(id) readPreferenceValue:(PSSpecifier*)specifier {
    NSDictionary *nsasettings = [NSDictionary dictionaryWithContentsOfFile:NSAPreferencePath];
    if (!nsasettings[specifier.properties[@"key"]]) {
        return specifier.properties[@"default"];
    }
    return nsasettings[specifier.properties[@"key"]];
    
}

-(void) setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier {
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    [defaults writeToFile:NSAPreferencePath atomically:YES];
    CFStringref NSAPost =(CFStringRef)specifier.properties[@"PostNoticiation"];
    
CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), NSAPost, NULL NULL, YES);
}
  
  -(void) respring:(id)arg1 {
           system ("killall -9 backboardd");
}

-(void) twitter:(id)arg1 {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://twitter.com/patrickk1734"]];
}

-(void) sendEmailTo:(id)arg1 {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:patrickknauf17@gmail.com"]];
}
  
  -(void) github:(id)arg1 {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/Patrickk17/NoSlowAnimationsXI"]];
  }
@end
