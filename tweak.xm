//NoSlowAnimationsXI Version 5.1.1
//Compatible iOS versions: 11.0-11.4 beta 3
//
//Created by Patrick Knauf on 7/9/18
//
//Features:
//Sped up animations:
//App opening/closing, lock/unlock, app switcher, control center, notification banners, 3D touch
//
//
//I am not the original author of NoSlowAnimations. I have updated it to work with newer versions of iOS. Original author is Marco Singhof.

#import <UIKit/UIKit.h>

NSDictionary *bundle = [[NSUserDefaults standardUserDefaults] persistentDomainForName:@"com.pknauf.nsasettings"];

id SCisEnabled = [bundle valueForKey:@"SCisEnabled"];
id applyOnHUD = [bundle valueForKey:@"applyOnHUD"];
id aerify = [bundle valueForKey:@"aerify"];
id Slider = [bundle valueForKey:@"Slider"];
double SliderFloat = [Slider floatValue];

const double minimumHudSpeed = 0.15;


%hook SBAnimationFactorySetings //Faster various animations

-(BOOL)slowAnimations {
    if ([SCisEnabled isEqual:@1]) {

        return NO;
    }else{
        return %orig;
    }
}

-(double)slowDownFactor {
    if ([SCisEnabled isEqual:@"1"]) {
        return SliderFloat;
    }else{
        return %orig();
    }
}

%end 


%hook SBScreenWakeAnimationController    //Faster time for the screen to turn on
-(void)backlightFadeDuration:(double)arg1 {
    if ([SCisEnabled isEqual:@1]) {
        if (SliderFloat <= 0.30) {
            %orig(0.1)
        }
        else if (SliderFloat <= 0.10) {
            %orig(0.0);
        }else{
            %orig(0.2);
        }
        
    }else{
        %orig();
    }
}     

%end

%hook SBHudController  //faster HUD

-(void)presentHUDView:(id)arg1 autoDismissWithDelay:(double)arg2 {
    if ([aerify isEqual:@1]) {         //aerify mode: aerify + NoSlowAnimationsXI causes HUD to not show up
        %orig;
        }else{
            if ([SCisEnabled isEqual:@1]) {
                if ([applyOnHUD isEqual:@1]) {
                    if(SliderFloat < minimumHudSpeed) {
                       %orig(arg1, arg2 * minimumHudSpeed);
                    }else{
                        %orig(arg1, arg2 *SliderFloat);
                    }
                }else{
                    %orig(arg1, arg2);
               }
            }
       }
}

%end


%hook SBFluidBehaviorSettings      //Faster app opening/closing animations

-(void)setResponse:(double)arg1 {
    if ([SCisEnabled isEqual:@1]) {
        if ([Slider isEqual:@0.0]) {
            %orig(0.000001);      //Prevent freezing; a value lower than 0.000001 causes freezing on some devices.
        }else{
            %orig(SliderFloat);
    }else{
            return %orig;
        }
}

%end


%hook SBAppSwitcherOrbGestureAnimationSettings    //faster 3D touch on the edge of the display to switch apps.

-(void)setResponse:(double)arg1 {
    if ([SCisEnabled isEqual:@1]) {
        %orig(SliderFloat);
    }else{
        %orig();
    }
}

%end
