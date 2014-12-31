Turbocards are cards arranged in a grid that when toggled, open in a 3d rotate
and pull to front, while the grid travles away on the z axis.

### Markup

Markup with common configuration:

    <div class="container-fluid turbo-cols-static turbo-grid-wrap">
    <div class="turbo-grid">
      <div class="row">
        <div class="col-md-6">
          CARD CONTENT
        </div>
        <div class="col-md-3">
          CARD CONTENT
        </div>
        <div class="col-md-3">
          CARD CONTENT
        </div>
      </div>
    </div>
    </div>

Where CARD CONTENT must have the following structure:

    <div class="turbo-card turbo-toggle"
         data-back-class="INITIAL-BACK-CLASS"
         data-turbo-url="/URL/TO/BACK/CONTENT"
         >
      CARD FRONT CONTENT
    </div>

The class .turbo-toggle can be added to any element within the front of the card to toggle the card
state (acts as opening button).

Sample BACK CONTENT

    <div class="animated fadeInUp padded bg-info">
      <button type="button" class="close pull-right turbo-toggle">&times;</button>
      BACK CONTENT
    </div>

The button with .turbo-toggle class must be present on the back of the card to be able to close it.

If you create the cards dynamically you may need to initialize the grid it via JS:

    $('.turbo-grid-wrap').turbogrid()
