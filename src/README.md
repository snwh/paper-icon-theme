Notes
-------

* Do not edit the icon assets of the theme directly, instead edit source files in this directory and render them with the appropriate script.
* To render the icons you will need `inkscape`, `python`, `ruby` and to build the cursor theme you'll need an additional tool: `x11-apps`

## Source folders

The sources for all the different Paper icons are kept organized in this `src` folder for ease of development.

`bitmaps`
 - all the sources for hires icons

`cursors`
 - the source for the cursor theme

`panel`
 - the source plates for the vector icons for environments with panels

`symbolic`
 - the symbolic icon source SVG plates

`vector`
 - the sources for the non-bitmap icons that get chopped up

## Render Scripts

For simplified development, Paper has various scripts to extract or render icons from the larger SVG source files.

`extract-panel-icons.rb`
 - this script will chop up the source plate in the `panel` folder into individual icons.

`extract-symbolic-icons.rb`
 - this script will chop up the `source-symbolic.svg` plate in the `symbolic` folder into individual icons.

`extract-symbolic-app-icons.rb`
 - this script will chop up the `source-apps-symbolic.svg` plate in the `symbolic` folder into individual icons.

`extract-vector-app-icons.rb`
 - this script will chop up the source plates in the `vector` folder into individual icons.

`render-bitmaps(-hidpi).py`
- will render all hicolor icons for Paper both the normal and high dpi variations respectively.

`render-cursors.sh`
- will render the cursor assets and build the cursor theme