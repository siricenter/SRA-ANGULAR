## Background Box

We created the `.em-background-box` element on pages like `pricing` or `profile`. You can use this class on elements that you'd like to look good with a background and content over it

    <div class="em-background-box text-white" style="background-image: url(some_image_url)">
      <div class="container-fluid">
        <div class="text-center em-background-box-content">
          <h1 class="base-header">Plans & Pricing</h1>
          <h3 class="thin">Affordable pricing. No upfront fees. No long term contract.</h3>
          <a class="btn btn-sm btn-transparent-light push-top" href="#">Start your FREE TRIAL NOW!</a>
        </div>
      </div>
    </div>
    
This will center the image throughout the container (using `background-size: cover`) and darken it a bit.

For buttons we recommend using `btn-transparent-light`
Make sure you're adding your content in a `em-background-box-content` container inside the `em-background-box` (this will negate the dark tint that `em-background-box` gives)