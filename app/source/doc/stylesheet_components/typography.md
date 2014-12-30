## Typography

### Text Gradients

Text gradients include all the theme classes/color variations by using the `.text-gradient-COLOR` class (ex: `.text-gradient-success`).

the `COLOR` is a named color like `danger` or `primary` or `info-lt` (check out the `variables` file for all available variations)

### Text alignment

You can use `.text-left-SIZE` like you use `.col-SIZE` when defining grids. `text-center` and `text-right` are also available

So if you do for example `.text-center-md`, it will show up centered on the `md` size only

### Page header

We use `.em-page-header` on the page title that you see on almost all the pages

### Other options

* `.base-header` - use it on headers to remove the margin (top and bottom)
* `.thin` - font size 300 (thinnest)
* `.major` - our headers have normal font-weight, use this if you want bold instead
* `.text-lg` - use this on a header for bigger text
* `.bg-COLOR` - use `COLOR` to apply background to a container. same rules with color names as text gradients above (this also adjusts the text color, so it will fit well with the new background)
* `.bg-light-semi` - use this for a super dimmed background color. useful on white backgrounds to give a subtle background tint