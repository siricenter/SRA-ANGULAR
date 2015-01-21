## Badges

### Colors

Badges include all the theme classes/color variations by using the `.badge-COLOR` class (ex: `.badge-success`).

the `COLOR` is a named color like `danger` or `primary` or `info-lt` (check out the `variables` file for all available variations)

### Empty badge

You might have noticed empty badges on the demo pages. add `.badge-empty` if you don't need text inside, and want the badge to look like a circle

### Check mark

You can add a checkmark to a badge by adding `.badge-checkmark` (check it out the menu widget on the widgets page, and open up the Labels submenu)
Add an `.active` class to a parent to actually show the badge, or toggle it.

### Badge Grow

If you want a grow effect on badge hover, add `.badge-grow` to a badge

### In a row

Add the `.badge-empty-list` to a parent containing `.badge` elements, to align them horizontally with a margin. `list-inline` won't cut it here since that uses padding (used in the sort by widget)

### In a corner

Add the `.has-corner-badge` to a parent containing a `.badge` element 
Then add either `.badge-corner-top-left` or `.badge-corner-top-right` to the `.badge` to move it to the left/right of that element (used in the top sidebar and the chat toggle button)





