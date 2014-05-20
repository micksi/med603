Calibration
===========

## Purpose
To offset the errors caused by EyeTribe's calibration

## Procedure
- There are n focus points on the screen (e.g. 4)
- For each focus point
	- Have users look at focus points on the screen
	- Register the gazetracker's position when the user looks at a focus point
		- Use key to report when user is looking
	- Record the offset between the gaze position and the focus point.
- Use the offset to correct gaze position
	- By using bilinear interpolation