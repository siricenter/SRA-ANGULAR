### Layout

The modal component offers several sizes (normal, large and small, all responsive) 
as well as several color configurations and effects. There are custom modal effects
that can be added on the .modal class as well as more general effects from animate.css
that can be added on the .modal-dialog class.

Markup with common configuration:

    <div class="modal MODAL-EFFECT MODAL-STYLE">
      <div class="modal-dialog ANIMETE-CSS-MODAL-EFFECT MODAL-SIZE">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h4 class="modal-title">Modal title</h4>
          </div>
          <div class="modal-body">
            ...
          </div>
          <div class="modal-footer">
            ... 
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

MODAL-EFFECT and ANIMETE-CSS-MODAL-EFFECT are mutually exclusive.
You should nott use both simultaneously.

MODAL-STYLEs

    .modal-dark
    .modal-light
    .modal-primary
    .modal-success
    .modal-info
    .modal-warning
    .modal-danger

MODAL-SIZEs

    (default)
    .modal-lg
    .modal-sm

MODAL-EFFECTs

    .fade-in-scale
    .slide-in-right
    .slide-in-bottom
    .newspaper
    .slide-to-top
    .super-scaled
    .just-modal
    .blur
    .fall
    .side-fall
    .flip-horizontal-3d
    .flip-vertical-3d
    .slit-3d
    .rotate-bottom-3d
    .rotate-left-3d

For the blur effect the modal markup should be added just above the main content element
that holds the .modal-blur-content class.
Also as a general good practice the modal markup should be added above the main content markup.

ANIMETE-CSS-MODAL-EFFECTs

    see http://daneden.github.io/animate.css/

This component is custom made.

### Jump to

Jump to menu is a special kind of modal, featuring a full page grid of links.

Sample markup:

    <div class="modal blur jump-to-modal" id="jump-to-menu">
      <div class="modal-dialog modal-lg">
        <div class="clearfix">
          <button type="button" class="close pull-right text-white-dk" data-dismiss="modal" aria-hidden="true">×</button>
        </div>
        <div class="container-fluid">

          <div class="row text-center vpadded-row">
            <div class="col-sm-4">
              <a href="/htmls/dashboard.html">
                <div class="jump-to-element padded text-gradient-white text-component-shadow">
                  <i class="icm icm-screen4 icm-4x"></i>
                  <h5>Dashboard</h5>
                </div>
              </a>
            </div>

            <div class="col-sm-4">

              <a href="/htmls/widgets.html">
                <div class="jump-to-element padded text-gradient-white text-component-shadow">
                  <i class="icm icm-grid icm-4x"></i>
                  <h5>Widgets</h5>
                </div>
              </a>
            </div>

            ANOTHER CELL ...

          </div>

          <div class="row text-center vpadded-row">
            ANOTHER ROW ....
          </div>

        </div>
      </div>

    </div>

To trigger it:

    <a data-toggle="modal" href="#jump-to-menu">
      Toggle jump-to menu
    </a>
