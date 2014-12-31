### Extra for utilities

#### Floating labels

Floating labels are input place-holders that become tiny labels ince text is
inserted in the input. They are useful for creating clean compact forms.

Markup

    <div class="form-group string">
      <input class="form-control" placeholder="Full name" type="text" rel="jvfloat">
    </div>

JS

    $('[rel=jvfloat]').jvFloat()

This component uses the JVFloat JQuery plugin:
https://github.com/maman/JVFloat.js

#### Form control header

form-control-header is just like form-control-feedback from Bootstrap only that it's
added at the begining of the input and not at the end.

Markup

    <div class="form-group has-header">
      <span class="fa fa-align-right form-control-header"></span>
      <input class="form-control" type="text">
    </div>

This component is custom made.

#### Textarea autosize

Is used for textarea that adjust the size based on the amount of text inside them.

Markup

    <textarea class="form-control" rel="autosize"></textarea>

JS

    $('[rel=autosize]').autosize()

This component uses the Autosize jQuery plugin:
http://www.jacklmoore.com/autosize/

#### File inputs

Add .fileinput to the container. Elements inside the container with 
.fileinput-new and .fileinput-exists are shown or hidden based on the 
current state. A preview of the selected file is placed in .fileinput-preview. 
The text of .fileinput-filename gets set to the name of the selected file.

The file input widget should be placed in a regular <form> replacing a standard 
<input type="file">. The server side code should handle the file upload as normal.

HTML5 API

Add data-provides="fileinput" to the .fileinput element. 
Implement a button to clear the file with data-dismiss="fileinput". 
Add data-trigger="fileinput" to any element within the .fileinput 
widget to trigger the file dialog.

    <div class="fileinput fileinput-new" data-provides="fileinput">
      <div class="input-group">
        <div class="form-control" data-trigger="fileinput">
          <i class="fa fa-file fileinput-exists"></i>
          <span class="fileinput-filename"></span>
        </div>
        <span class="input-group-addon btn btn-default btn-file">
          <span class="fileinput-new">Select file</span>
          <span class="fileinput-exists">Change</span>
          <input type="file" name="...">
        </span>
        <a href="#" class="input-group-addon btn btn-default fileinput-exists" 
           data-dismiss="fileinput">Remove</a>
      </div>
    </div>

JS

    $('.fileinput').fileinput()

This component is based on the Jasny Fileinput:
http://jasny.github.io/bootstrap/javascript/#fileinput
