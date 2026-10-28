##Opacity Widget Demo

Small Flutter app demonstrating the Opacity widget which can make its child fine-tuned between 0.0 (invisible), and 1.0 (fully visible).

 #What the demo shows

The app is a " Photo Gear Shop" screen having a lineup of items. Products that are out of stock (Tripod Stand and Lens Cleaning Kit) will be packaged in opacity and thus will be visibly dimmed next to the products available. This is a common, real world situation to show that an item is not available but not to take it off the list.

There is a control panel at the bottom of the screen that you can use when you are using the app to adjust the Opacity properties.

 #How to run

1. Add Flutter and test it using flutter doctor.
2. Click on the repository of this project and open the project folder.
3. Install the packages needed and execute the app:

```bash
flutter pub get
flutter run -d chrome
```

It can also be executed using an Android emulator, connected device or Windows desktop, depending on the device you choose: `flutter devices` and `flutter run -d <device>`.

 #The three attributes

 1. `opacity`
Defines the transparency of the child, in range 0.0 - 1.0. This is an argument passed by and not supplied with a default value, and is 1.0 in plain sight.

In demo: slider is set to `1.00` initially, so that sold out cards are the same as others. When it's dragged to the right with 0.40, it's definitely dark; and when you drag it to 0.00, it's not visible, but you can see that you have space that isn't filled by anything else.
When to use it: To mark unavailable content, disabled or de-emphasised content.

 2. `alwaysIncludeSemantics`
A boolean with a default value of false. Does not appear on the screen. If it is opaque (full transparency), it means whether screen readers and other assistive technologies can still be used to perceive the child or not.

When switching during demo, there are no changes to the visual input at all – as expected. When the opacity is set to `0.0`, only the difference is of interest for assistive technology.
Why change it: set to true if the content is accessible even if it's not visible.

 3. `child`
The widget which fades out. It is required.

With the “Whole card” option, the entire product card is wrapped and the image and the text fade together in the demo. The "Image only" option will wrap the image only, with the product name and price clearly visible.
Why change it: because you want to de-emphasise exactly which part of the UI to do that on.

 #Code overview

All the code is in `lib/main.dart`. In the `_fadeIfSoldOut` method, it's used to return the widget if the product is available; otherwise, it wraps the widget in the `Opacity` widget. The slider, switch and toggle call setState which will re-create the cards with the new values.

 Screenshot
<img width="1348" height="896" alt="screen" src="https://github.com/user-attachments/assets/c513eb04-ba16-4fa8-98f7-44f08a10567c" />

 Related widget

It is also similar to AnimatedOpacity, but animates over a `duration` and Opacity is immediately changed.

 References

Floating Platform: Opacity class
The Flutter API documentation for the AnimatedOpacity class is found here: AnimatedOpacity class docs
