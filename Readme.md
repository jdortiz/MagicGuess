# Intro

This is a demo to show how Core Motion works and enables you to do
"magic".

## Project Setup

1. Create a new Project. Choose the template for 1 view.
2. Visit the Storyboard.
3. In the main view controller add 1 UIView and a button.
4. Add constraints so the button is centered at the bottom and the
   view covers the rest of the view controller respecting the margins.
5. Set the label of the button to "Clear".
6. Create a new UIView subclass and call it CanvasView.
7. Set the class of the view that was added to the view controller to
   CanvasView.
8. Create an outlet in the main view controller for the canvas view.

## Enable drawing in the canvas view

1. Create an internal property in the canvas view to hold a
   UIBezierPath. Call it bezierPath.
2. Initialize in initWithCoder, create the UIBezierPath there and set
   the default line width.
3. In an new public method called clear, remove all the points from the
   path and mark the rectangle of the view as needed to be redrawn.
4. In the storyboard connect the button with a new action of the
   view controller. The new action should invoke the clear method of
   the canvas view.
5. In the drawRect method, stroke the path.
6. Override the touchesBegan:withEvent:. Obtain the first touch from
   the set and add the point, translated of the coordinates of the
   Canvas view, to the Bezier path as a movement.
7. Override touchesMoved:withEvent:. Obtain the first touch from
   the set and add the point, translated of the coordinates of the
   Canvas view, to the Bezier path as a line. Mark the rectangle of
   the view as needed to be redrawn.
8. Override touchesCancelled:withEvent: and invoke
   touchesMoved:withEvent: with the corresponding parameters.
9. Override touchesEnded:withEvent: and invoke
   touchesMoved:withEvent: with the corresponding parameters.
10. Run and test.

## Save and restore the desired paths

1. In Canvas view create a new method, "saveCurrentPath".
2. Obtain the URL for the documents directory
3. Append the current date an time with the path extension to have a
   unique filename. Use NSDateFormatter.
4. Save the contents of the Bezier path with NSKeyedArchiver
   (archiveRootObject).
5. Invoke this method from the clear method before the data is
   removed.
6. Run it and generate the 4 paths so they can be saved.
7. From the device manager, download the container with the paths.
8. Edit the container to have proper names for the card suits (Spades,
   Diamonds, Hearts, and Clubs).
9. Replace the container.
10. Remove the invocation to save from the clear method.
11. Write the method to load and display the paths (taking an
    NSUInteger).
12. Invoke the method after clearing the path and before marking the
    view for redrawing.
13. Run and test with.

## Gather information about the position of the device

1. Import CoreMotion framework
2. Create a new subclass of NSObject. Call it MotionController.
3. In the private interface of the class define a property for the
   CMMotionManager.
4. Create a method to perform lazy instanciation of the motionManager.
5. Create a new public method to startMeasuringPosition.
6. Verify that the deviceMotionAvailable is YES and set the interval
   of the device motion update to 0.5.
7. Start the pushing updates and print the data inside of the block
   inorder to understand the dynamics. Use the reference frame
   XArbitraryZVertical. Use the main queue for the operations.
8. Create another public method to stop the updates.
9. Create an instance of the MotionController in the view controller
   and start measuring when view appears. Stop measuring when view
   disappears.
10. Run and learn how to use the data.

## Use the position of the device to alter behavior

1. In MotionController, define an enum with two states (Drawing, Learning).
2. Define a property that is of the enum type. and set it to drawing
   when the startMeasuring begins.
3. Use a switch in the block for gathering the data and implement the
   logic for the two states there. (Remember to use weakSelf and
   identify the different values).


## Communicate the information to the view controller and act on it.

1. Define a protocol to notify the view controller. Use an enum for
   the suites and have the enum in a different header, so it can also be used
   in the view controller and the canvas view.
2. Implement the protocol on the view controller so that the path is
   deleted, the one for the corresponding suit is loaded and it is displayed.
3. Declare itself as delegate of the motion controller.
4. In the implementation of the method, tell the canvas to load the
   required suit, which means removing the current path, loading the
   path and redrawing.
