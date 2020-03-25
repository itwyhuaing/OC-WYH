//
//  UIColor+Colors.h
//  
//
//  Created by yujian on 15/6/17.
//  Copyright (c) 2014 Dongxiang Cai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

// Color Scheme Creation Enum
typedef enum
{
    ColorSchemeAnalagous = 0,
    ColorSchemeMonochromatic,
    ColorSchemeTriad,
    ColorSchemeComplementary
	
} ColorScheme;

@interface UIColor (Colors)

#pragma mark - Color from Hex/RGBA/HSBA
/**
 Creates a UIColor from a Hex representation string
 @param hexString   Hex string that looks like @"#FF0000" or @"FF0000"
 @return    UIColor
 */
+ (UIColor *)colorFromHexString:(NSString *)hexString;

/**
 Creates a UIColor from an array of 4 NSNumbers (r,g,b,a)
 @param rgbaArray   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromRGBAArray:(NSArray *)rgbaArray;

/**
 Creates a UIColor from a dictionary of 4 NSNumbers
 Keys: @"r",@"g",@"b",@"a"
 @param rgbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromRGBADictionary:(NSDictionary *)rgbaDict;

/**
 Creates a UIColor from an array of 4 NSNumbers (h,s,b,a)
 @param hsbaArray   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromHSBAArray:(NSArray *)hsbaArray;

/**
 Creates a UIColor from a dictionary of 4 NSNumbers
 Keys: @"h",@"s",@"b",@"a"
 @param hsbaDictionary   4 NSNumbers for rgba between 0 - 1
 @return    UIColor
 */
+ (UIColor *)colorFromHSBADictionary:(NSDictionary *)hsbaDict;

+ (UIColor *)colorScale:(CGFloat)scale color:(UIColor *)incolor;

#pragma mark - Hex/RGBA/HSBA from Color
/**
 Creates a Hex representation from a UIColor
 @return    NSString
 */
- (NSString *)hexString;

/**
 Creates an array of 4 NSNumbers representing the float values of r, g, b, a in that order.
 @return    NSArray
 */
- (NSArray *)rgbaArray;

/**
 Creates an array of 4 NSNumbers representing the float values of h, s, b, a in that order.
 @return    NSArray
 */
- (NSArray *)hsbaArray;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "r", "g", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)rgbaDictionary;

/**
 Creates a dictionary of 4 NSNumbers representing float values with keys: "h", "s", "b", "a"
 @return    NSDictionary
 */
- (NSDictionary *)hsbaDictionary;


#pragma mark - 4 Color Scheme from Color
/**
 Creates an NSArray of 4 UIColors that complement the UIColor.
 @param type ColorSchemeAnalagous, ColorSchemeMonochromatic, ColorSchemeTriad, ColorSchemeComplementary
 @return    NSArray
 */
- (NSArray *)colorSchemeOfType:(ColorScheme)type;


#pragma mark - Contrasting Color from Color
/**
 Creates either [UIColor whiteColor] or [UIColor blackColor] depending on if the color this method is run on is dark or light.
 @return    UIColor
 */
- (UIColor *)blackOrWhiteContrastingColor;


#pragma mark - Colors
// System Colors
+ (UIColor *)infoBlueColor;
+ (UIColor *)successColor;
+ (UIColor *)warningColor;
+ (UIColor *)dangerColor;

// Whites
+ (UIColor *)antiqueWhiteColor;
+ (UIColor *)oldLaceColor;
+ (UIColor *)ivoryColor;
+ (UIColor *)seashellColor;
+ (UIColor *)ghostWhiteColor;
+ (UIColor *)snowColor;
+ (UIColor *)linenColor;

// Grays
+ (UIColor *)black25PercentColor;
+ (UIColor *)black50PercentColor;
+ (UIColor *)black75PercentColor;
+ (UIColor *)warmGrayColor;
+ (UIColor *)coolGrayColor;
+ (UIColor *)charcoalColor;

// Blues
+ (UIColor *)tealColor;
+ (UIColor *)steelBlueColor;
+ (UIColor *)robinEggColor;
+ (UIColor *)pastelBlueColor;
+ (UIColor *)turquoiseColor;
+ (UIColor *)skyBlueColor;
+ (UIColor *)indigoColor;
+ (UIColor *)denimColor;
+ (UIColor *)blueberryColor;
+ (UIColor *)cornflowerColor;
+ (UIColor *)babyBlueColor;
+ (UIColor *)midnightBlueColor;
+ (UIColor *)fadedBlueColor;
+ (UIColor *)icebergColor;
+ (UIColor *)waveColor;

// Greens
+ (UIColor *)emeraldColor;
+ (UIColor *)grassColor;
+ (UIColor *)pastelGreenColor;
+ (UIColor *)seafoamColor;
+ (UIColor *)paleGreenColor;
+ (UIColor *)cactusGreenColor;
+ (UIColor *)chartreuseColor;
+ (UIColor *)hollyGreenColor;
+ (UIColor *)oliveColor;
+ (UIColor *)oliveDrabColor;
+ (UIColor *)moneyGreenColor;
+ (UIColor *)honeydewColor;
+ (UIColor *)limeColor;
+ (UIColor *)cardTableColor;

// Reds
+ (UIColor *)salmonColor;
+ (UIColor *)brickRedColor;
+ (UIColor *)easterPinkColor;
+ (UIColor *)grapefruitColor;
+ (UIColor *)pinkColor;
+ (UIColor *)indianRedColor;
+ (UIColor *)strawberryColor;
+ (UIColor *)coralColor;
+ (UIColor *)maroonColor;
+ (UIColor *)watermelonColor;
+ (UIColor *)tomatoColor;
+ (UIColor *)pinkLipstickColor;
+ (UIColor *)paleRoseColor;
+ (UIColor *)crimsonColor;

// Purples
+ (UIColor *)eggplantColor;
+ (UIColor *)pastelPurpleColor;
+ (UIColor *)palePurpleColor;
+ (UIColor *)coolPurpleColor;
+ (UIColor *)violetColor;
+ (UIColor *)plumColor;
+ (UIColor *)lavenderColor;
+ (UIColor *)raspberryColor;
+ (UIColor *)fuschiaColor;
+ (UIColor *)grapeColor;
+ (UIColor *)periwinkleColor;
+ (UIColor *)orchidColor;

// Yellows
+ (UIColor *)goldenrodColor;
+ (UIColor *)yellowGreenColor;
+ (UIColor *)bananaColor;
+ (UIColor *)mustardColor;
+ (UIColor *)buttermilkColor;
+ (UIColor *)goldColor;
+ (UIColor *)creamColor;
+ (UIColor *)lightCreamColor;
+ (UIColor *)wheatColor;
+ (UIColor *)beigeColor;

// Oranges
+ (UIColor *)peachColor;
+ (UIColor *)burntOrangeColor;
+ (UIColor *)pastelOrangeColor;
+ (UIColor *)cantaloupeColor;
+ (UIColor *)carrotColor;
+ (UIColor *)mandarinColor;

// Browns
+ (UIColor *)chiliPowderColor;
+ (UIColor *)burntSiennaColor;
+ (UIColor *)chocolateColor;
+ (UIColor *)coffeeColor;
+ (UIColor *)cinnamonColor;
+ (UIColor *)almondColor;
+ (UIColor *)eggshellColor;
+ (UIColor *)sandColor;
+ (UIColor *)mudColor;
+ (UIColor *)siennaColor;
+ (UIColor *)dustColor;

//Color for Dada
+ (UIColor *) DDNavBarDark;
+ (UIColor *) DDNavBarBlue;
+ (UIColor *) DDNavBarLightBlue;
+ (UIColor *) DDNavBarLight;
+ (UIColor *) DDBackgroundGray;
+ (UIColor *) DDInputGray;
+ (UIColor *) DDInputText;
+ (UIColor *) DDInputLightGray;

/**
 * APP 3.0
 */
+ (UIColor *) DDNarMainColor;

+ (UIColor *) DDTextWhite;
+ (UIColor *) DDTextGrey;
+ (UIColor *) DDButtonRed;
+ (UIColor *) DDButtonBlue;
+ (UIColor *) DDLableBlue;
+ (UIColor *) DDLableRed;
+ (UIColor *) DDLableYellow;
+ (UIColor *) DDBackgroundLightGray;
+ (UIColor *) DDSideChatTextDark;
+ (UIColor *) DDSideChatBackgroundGray;
+ (UIColor *) DDSideChatSearchInputBackgroundDark;
+ (UIColor *) DDSidePointGreen;

+ (UIColor *) DDMedalGold;
+ (UIColor *) DDMedalSilver;
+ (UIColor *) DDMedalCopper;

+ (UIColor *) DDBillBoardOrange;
+ (UIColor *) DDBillBoardRed;
+ (UIColor *) DDBillBoardGray;

+ (UIColor *) DDListBackGround;
+ (UIColor *) DDNormalBackGround;
+ (UIImage *) createImageWithColor: (UIColor *) color;
+ (UIColor *) DDPlaceHoldGray;
/* login&register */
+ (UIColor *) DDRegisterBackGround;
+ (UIColor *) DDRegisterButtonGray;
+ (UIColor *) DDRegisterButtonEnable;
+ (UIColor *) DDRegisterButtonNormal;


+ (UIColor *) DDToolBarTopLine;
+ (UIColor *) DDToolBarBackGround;
+ (UIColor *) DDNavSearchBarBlue;
+ (UIColor *) DDEdgeGray;
+ (UIColor *) DDHomePageEdgeGray;
+ (UIColor *) DDBlack333;
+ (UIColor *) DDCouponTextGray;
+ (UIColor *) DDCouponNotAvailableTextGray;

#pragma mark - IMAssessQuestionnaire 移民评估问卷
/* IMAssessQuestionnaire 移民评估问卷 */
+ (UIColor *) DDIMAssessQuestionnaireTitleColor;
+ (UIColor *) DDIMAssessQuestionnaireNoteColor;
+ (UIColor *) DDIMAssessQuestionnaireBtnTextColor;
+ (UIColor *) DDIMAssessQuestionnaireBtnBorderColor;
+ (UIColor *) DDIMAssessQuestionnaireHeadBgViewColor;

/* IMHundredQuestion 移民百问标签 */
+ (UIColor *) DDIMHundredQuestionLabelColor;

/* IMProjectHomeViewController TabBar的颜色*/
+ (UIColor *) DDIMProjectHomeTabColor;

#pragma mark - 新版首页 rgb
/* 新版首页 rgb */

/**
 * 黑色   （应用范围：大标题，需重点突出）
 */
+ (UIColor *)DDR0_G0_B0ColorWithalph:(CGFloat)alph;

/**
 * 深灰  （应用范围：标题）
 */
+ (UIColor *)DDR51_G51_B51ColorWithalph:(CGFloat)alph;
+ (UIColor *)DDR50_G50_B50ColorWithalph:(CGFloat)alph;
+ (UIColor *)DDR85_G85_B85ColorWithalph:(CGFloat)alph;

/**
 * 灰  （应用范围：正文颜色略深）
 */
+ (UIColor *)DDR102_G102_B102ColorWithalph:(CGFloat)alph;

/**
 * 浅灰  （应用范围：正文颜色略深浅）
 */
+ (UIColor *)DDR153_G153_B153ColorWithalph:(CGFloat)alph;

/**
 * 黄1   （应用范围：需突出的文字）
 */
+ (UIColor *)DDR255_G138_B93ColorWithalph:(CGFloat)alph;

/**
 * 黄2   （应用范围：需突出的文字）
 */
+ (UIColor *)DDR255_G209_B97ColorWithalph:(CGFloat)alph;

/**
 * 蓝     （应用范围：按钮或者可的点击文字）
 */
+ (UIColor *)DDR37_G182_B237ColorWithalph:(CGFloat)alph;

+ (UIColor *)DDR63_G162_B255ColorWithalph:(CGFloat)alph;

/**
 * 灰色
 */
+ (UIColor *)DDR136_G136_B136ColorWithalph:(CGFloat)alph;
+ (UIColor *)DDR113_G113_B113ColorWithalph:(CGFloat)alph;

/**
 * 新版主题 灰色 背景
 */
+ (UIColor *)DDR245_G245_B245ColorWithalph:(CGFloat)alph;
+ (UIColor *)DDR204_G204_B204ColorWithalph:(CGFloat)alph;

+ (UIColor *)DDR238_G238_B238ColorWithalph:(CGFloat)alph;

/**
 * 橙     （应用范围：个人中心加V的文字颜色）
 */
+ (UIColor *)DDR255_G104_B47ColorWithalph:(CGFloat)alph;

/**
 * 蓝     （应用范围：个人中心按钮背景色）
 */
+ (UIColor *)DDR81_G197_B241ColorWithalph:(CGFloat)alph;
+ (UIColor *)DDR59_G189_B239ColorWithalph:(CGFloat)alph;

+ (UIColor *)DDR129_G194_B255ColorWithalph:(CGFloat)alph;
+ (UIColor *)DDR147_G203_B255ColorWithalph:(CGFloat)alph;

/**
 * 橘黄色   （应用范围：2017 518移民节 Tab）
 */
+ (UIColor *)DDR255_G169_B39Withalph:(CGFloat)alph;

/**
 * （应用范围： V3.1首页 海外课堂）
 */
+ (UIColor *)DDR253_G187_B56Withalph:(CGFloat)alph;

#pragma mark - 颜色转换 IOS中十六进制的颜色转换为UIColor
+ (UIColor *) colorWithHexString: (NSString *)string;

#pragma mark - CIColor String类型转UIColor
+ (UIColor *) colorWithString:(NSString *)textDefaultColorStr;

/**
 * APP 3.1 - 2018/1/15年春节版
 */
+ (UIColor *)DDR251_G51_B27WithAlph:(CGFloat)alph;

@end
