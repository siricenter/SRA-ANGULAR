## Stylesheets

first of all, each folder has it's own include file called `_folder_name.scss` - you can add new files but make sure you include them in the specific folder include file

### bootstrap-extra

Contains additions to bootstrap components and new smaller components designed by us

### bootstrap-overrides

Contains overrides to bootstrap components only

### components

separate, larger components like the pricing box, timeline, wizard etc

### fonts

includes the font faces for open sans and other icons we're using in the theme

### vendored

overrides for different 3rd party plugins we're getting from Bower

### _bower

all the bower plugins get included here

### _mixins

our own custom made mixins

### _utilities

utility classes similar to bootstrap's utility classes. we added them here, and not in the `bootstrap-extra`, since they need to be included at the end of the stylesheet

### _variables

the core of the Emerald theme, this is where you can configure almost anything regarding look and feel

### application

manifest file for the main stylesheet of the theme. this is the file that gets included in the main layout

### splash

manifest file for the splash screen only