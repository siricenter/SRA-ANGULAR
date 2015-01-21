### Vertical carousel

The vertical carousel component allows for carousels with vertical animations.

Markup with common configuration:

    <div class="carousel slide vertical HEIGHT-CLASS" data-ride="carousel">
      <div class="carousel-inner">
        <div class="item active HEIGHT-CLASS">...</div>
        <div class="item HEIGHT-CLASS">...</div>
        <div class="item HEIGHT-CLASS">...</div>
      </div>
    </div>

Make sure you add HEIGHT-CLASS with given fixed height.

HEIGHT-CLASS can currently be tile-normal (250px), tile-half (125px) or tile-double (250px)

You can also add new classes and we recommend adding them in the `source/stylesheets/components/_tiles.scss` , in the `$tile-carousel-heights` variable

This component is custom made.
