### Markup

Markup with common configuration:

    <div class="tree" rel="tree">
      <ul class="list-unstyled">
        <li>
          <span class="tree-node LABEL">
            <i class="fa ICON"></i></span> CONTENT
          <ul>
            <li>
              <span class="tree-node label label-default">
                <i class="fa fa-plus"></i></span> CONTENT
              <ul>
                <li>
                  <span class="tree-node label label-default">
                    <i class="fa fa-leaf"></i></span> <a href="#">Link</a>
                </li>
              </ul>
            </li>
            <li>
              <span class="tree-node label label-default"><i class="fa fa-plus"></i></span> <a href="#">Link</a>
              <ul>
                <li>
                  <span class="tree-node label label-default"><i class="fa fa-leaf"></i></span> <a href="#">Link</a>
                </li>
                ...
              </ul>
            </li>
          </ul>
        </li>
        ...
      </ul>
    </div>

### JS API

    $('[rel=tree]').tree()

