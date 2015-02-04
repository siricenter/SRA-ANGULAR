## Intro

### Build system

If you just want to use the already built components as they are you can find these 
in the "build" directory. This is the easy route for busy people. Just include the 
files and start your engines. In the "build" folder you will find all the html files, 
css styles, js plugins that you need. If you choose this route feel free to scroll 
down to the "Setting up a layout" section.

If you want to extend or change the Emerald theme you should become familiar with 
the build system.  
Emerald uses [Middleman](http://middlemanapp.com ) for the development and build process.  
Style sheets are built using [Scss](http://sass-lang.com/) a superset of CSS.  
Some js files are built with [Coffeescript](http://coffeescript.org/).  

### Folders organization

Here are the **folders and files** you need to know about:

1. build - The resulting htmls, javascript and css files built out of templates in the "source" folder.
2. doc - The documentation folder where you will find each component documented in markdown format.
3. source - html, js and css source files, more on this below
4. bower.json - list of plugins and dependencies used by Emerald via [Bower](http://bower.io/)

The **source folder** is the most important. Here is the hierarchy for the relaevant files:

1. htmls - html templates that use the [ERB](https://en.wikipedia.org/wiki/ERuby) preprocessor, useful to understand the html structure you need to use.
2. layouts - html templates used for the page layout
3. javascripts - js components and plugin integrations built for the Emerald theme
4. stylesheets - stylesheets components plugin integrations built for the Emerald theme

Find more info about each of these in the doc/theme_structure folder.

### Using only what you need

The emerald theme bundles and styles many plugins to have a cohesive look and feel
is you happen to use them. As such the first step would be to remove the plugins you 
don't make use of. You need to edit the following files:

    source/javascripts/application.js.coffee
    source/stylesheets/application.scss

You may need to also edit the init.js file at:

    source/javascripts/init.js.coffee

### Building the theme

A build is already made for you in "emerald/build" folder.

If you remved any plugins and want to do your own build with Middleman,
use the command "build" after you cd in the root Emerald directory.

1. Install a Ruby interpreter from https://www.ruby-lang.org/en/downloads/
2. Install Middleman and Bundler

    gem install middleman
    gem install bundler
    
3. Install Emerald dependencies with Bundler, and do a build:

    cd emerald
    bundle install
    middleman build

After you do this you can use the resulting files in the build directory:

    emerald/build/stylesheets/application.css
    emerald/build/javascripts/application.js
    
These are the only two files you need.
The other files in the "emerald/build/javascripts/" are only for documentation 
purposes. You can also analyse sample full html files in "emerald/build/htmls/" also for
documentation purposes.
    
### Setting up a layout

Asuming the following files structure

    htmls/index.html
    stylesheets/application.css
    javascripts/application.js
    images/
    
Here is a the general page structure

    <!doctype html>
    <html lang="en" class="high">
    <head>  
    <meta charset="utf-8">

    <!-- Always force latest IE rendering engine or request Chrome Frame -->
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">

    <meta name="viewport" content="width=device-width, minimal-ui, initial-scale=1, maximum-scale=1.0, user-scalable=no">

    <!-- Apple Touch -->
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../images/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../images/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../images/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="57x57" href="../images/apple-touch-icon-57-precomposed.png">

    <!-- Favicon -->
    <link rel="shortcut icon" href="../images/favicon.png">

    <!-- Use title if it's in the page YAML frontmatter -->
    <title>Dashboard</title>

    <script type="text/javascript">
        var polyfilter_scriptpath = "/themes/emerald/polyfills/filters/";
    </script>
    <link href="../stylesheets/application.css" media="screen" rel="stylesheet" type="text/css" />
    <script src="../javascripts/application.js" type="text/javascript"></script>

    </head>
    <body class="high emerald-default <%= page_classes %>">
      CONTENT HERE
      <div id="mq"></div>
      <div id="emvars"></div>
    </body>
    </html> 
    
Adding the offcanvas drawers, in place of the "CONTENT HERE" placeholder:
(Find more documentation about the offcanvas component in doc/offcanvas.md)
The many classes on the #oc-wrapper element are needed to establish default 
states for the drawer the four screen form factors: xs, sm, md, lg.

    <div class="oc-lg-squeeze-push oc-md-squeeze-push oc-sm-squeeze-push oc-xs-push-push">

      <div id="oc-wrapper" class="oc-wrapper
           oc-lg-open-left oc-md-open-left oc-sm-partial-left
           oc-lg-left-squeeze oc-md-left-squeeze oc-sm-left-squeeze oc-xs-left-push
           oc-lg-right-push oc-md-right-push oc-sm-right-push oc-xs-right-push
           ">

        <div class="oc-push">
          <aside class="oc-sidebar oc-sidebar-left clearfix">
            LEFT SIDEBAR
          </aside>

          <div class="oc-container">
            TOP NAVBAR

            MY CONTENT
          </div>
        </div>

        <aside class="oc-sidebar oc-sidebar-right">
          RIGHT SIDEBAR
        </aside>

      </div>

    </div>

To continue check out each component's documentation and the html's templates
source code.

