## Panel Icons Source

 - To add or modify the panel icons, edit source SVG file found in this directory
 - For simplified development, has various scripts to extract or render icons from the larger SVG source files.
 - To edit the icons you will need `inkscape` and you'll need `ruby` installed to run the render script.

**[light](./light) & [dark](./dark) - the folders that contains all of the panel icon sources**
 - each layer of the source files corresponds to a icon `context` and the icons are sorted accordingly
 - each icon should be drawn within an square corresponding to the panel icon szie and use only 1 colour
 - when complete, group all element of an icon within a rectangle of the panel icon size (with no fill or stroke) and label that group with the `icon-name`

**[extract-panel-icons.rb](./extract-panel-icons.rb) - the render script**
 - extract any new panel icons from the source SVG by passing the icon name to this script: `./extract-panel-icons.rb <icon-name>`
 - or, if run generally, this script will look through the entire source file to render any new icons (if a new icon does not have a correct label the script will fail)