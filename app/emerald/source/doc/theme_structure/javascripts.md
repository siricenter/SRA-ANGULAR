## Javascripts

### demo

One important thing is the `javascripts/demo` folder. The `application.js.coffee` includes a `#= require_tree ./demo` directive which loads everything in there.

You can go through it to get a feeling of how we're using the javascript plugins to get the awesome feeling that Emerald has, but really, it should only be used for demo purposes

### bootstrap-extra

Here you can find custom scripts and patches that you'll need in the components provided in Emerald.

If you need to use just a specific component, read the component's doc to see if it requires anything from here

### bootstrap-overrides

In this folder you will find overrides specific to bootstrap libraries (currently only the collapse plugin, which we're using in a special way in our sidebar component)

### components

Major custom components like the Chat in the right sidebar

### vendored

Here you'll find javascript plugins that we had issues importing through Bower, and plugins for packages that integrate one another (like nanoscroller for selectize)

### application

manifest file where the javascripts get included. 
the `window.Loaded` at the bottom is used only in the `splash` page

### init

This is the main initializer file that you will probably need to modify to only load the components you require.

Take note that the theme uses turbolinks and there are some edge cases that you need to take in account when doing initializers

### some neat little helpers

The theme outputs the sass variables as named variables to the DOM, by adding a json object to the `body:before content`

The variables can then be easily accessed through javascript (for example when doing charts)

Check out `bootstrap-extra/emerald.coffee` - you'll see some functions there that you might want to use when doing stuff like charts (it's documented there)

Also, check the demos in the `demo` folder to see how we use the helpers to build our own charts