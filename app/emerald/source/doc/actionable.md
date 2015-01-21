Actionable cards give feedback for actions with a nice slide and follow up animation.

### Markup

    <div class="actionable">
      <div class="actionable-front">
        FRONT CONTENT CONTAINING ACTION BUTTON
        <a class="btn btn-info btn-block action">Submit action</a>
      </div>
      <div class="actionable-back bg-white padded">
        BACK CONTENT
      </div>
    </div>

The FRONT CONTENT must contain the button with the .action class.
It's a good idea to add the close button on the back content:

    <button type="button" class="close pull-right">&times;</button>
    
On the .actionable div there are two events being fired:

* 'acting.actionable' - when the animation starts
* 'acted.actionable' - when the animation ends

You probably want to listen for the 'acted.actionable' event and execute a
callback.

The elements with the class:

    .actionable-animated-fadeInLeftSmall
    .actionable-animated-fadeInRightSmall
    
can be animated on the back of the card.

