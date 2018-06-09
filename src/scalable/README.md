## Symbolic Icons Source

 - To add or modify an symbolic icon, edit source SVG file found in this directory
 - For simplified development, has various scripts to extract or render icons from the larger SVG source files.
 - To edit the icons you will need `inkscape` and you'll need `ruby` installed to run the render script.

**[source-symbolic.svg](./source-symbolic.svg) - the source files that contains all of the symbolic icons**
 - each layer in this source file corresponds to a icon `context` and the icons are sorted accordingly
 - each icon should be drawn within an 16x16 pixel square and use only 1 colour
 - when complete, group all elements within a 16x16 rectangle (with no fill or stroke) and label that group with the `icon-name`

**[extract-symbolic-icons.rb](./extract-symbolic-icons.rb) - the render script**
 - extract any new symbolic icons from the source SVG by passing the icon name to this script: `./extract-symbolic-icons.rb <icon-name>`
 - or, if run generally, this script will look through the entire source file to render any new icons (if a new icon does not have a correct label the script will fail)