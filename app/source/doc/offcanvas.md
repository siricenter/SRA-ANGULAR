### Layout

Markup with common configuration:

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
            <%= partial 'shared/navbar' %>

            <%= Faker::Lorem.paragraphs(100).join('<br>') %>
          </div>
        </div>

        <aside class="oc-sidebar oc-sidebar-right">
          RIGHT SIDEBAR
        </aside>

      </div>

    </div>

On the parent div we define, for each screen, the effects we will use:

    oc-[screen]-[effect-left]-[effect-right]
    screen in xs, sm, md, lg
    effect in squeeze, push

On the .oc-wrapper we declare the default states for each screen:

    oc-[screen]-[state]-[side]
    screen in xs, sm, md, lg
    state in hidden, partial, open
    side in left, right

Also, on the .oc-wrapper the effects must be redeclared with the format:

    oc-[screen]-[side]-[effect]
    screen in xs, sm, md, lg
    side in left, right
    effect in squeeze, push

The classes .oc-sidebar-fixed or oc-sidebar-free can be added on the sidebars
(tag <aside>) to make them either fixed or scroll with the content respectively.
In case of .oc-sidebar-fixed, a scroll bar might be needed, depending on content.
For example, using the nano-scroller tool included in the theme:

    <aside class="oc-sidebar oc-sidebar-left clearfix oc-sidebar-fixed nano">
      <div class="nano-content">
        LEFT SIDEBAR
      </div>
    </aside>

### HTML5 API

    <a href="#oc-wrapper"
       data-toggle="offcanvas" data-control="left"
       data-states="open,partial"
       data-parent="body" data-sibling="right">
      Toggle left
    </a>

    <a href="#oc-wrapper"
       data-toggle="offcanvas" data-control="right"
       data-states="open,hidden">
      Toggle right
    </a>

Options:

data-toggle="offcanvas"
Mandatory.

data-control="left"
Side to be controled left or right.

data-states="open,partial"
Sidebar states to be controlled by this button
a subset of open, hidden, partial.

data-parent="body"
A parent selector, in which to look for siblings to close when this
sidebar is opened.

data-sibling="right"
The side of the corresponding siblings to close when the sidebar opens.
Must be used in conjunction with the data-parent attribute.

### JS API

    $('#oc-container').offcanvas(options)

Examples

    // args: data hash, as per html5 api
    // { toggle: 'offcanvas', states: statesArray, parent: selector, sibling: string }
    $('#oc-container').offcanvas(hash)

    // args: toggle, side, statesArray
    $('#oc-container').offcanvas('toggle', 'left', ['open', 'hidden'])

    // args: setState, side, stateString, screensArray
    $('#oc-container').offcanvas('setState', 'left', 'open', ['lg', 'md'])

This component is custom made.
