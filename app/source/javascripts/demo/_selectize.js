$(document).on('ready page:load', function(){
  var selectMovieOptions = {
    theme: 'movies',
    valueField: 'title',
    labelField: 'title',
    searchField: 'title',
    options: [],
    create: false,
    plugins: ['nano_scroller'],
    render: {
      option: function(item, escape) {
        var actors = [];
        for (var i = 0, n = item.abridged_cast.length; i < n; i++) {
          actors.push('<span>' + escape(item.abridged_cast[i].name) + '</span>');
        }

        return '<div class="media">' +
                '<img class="media-object pull-left" height="80" src="' + escape(item.posters.thumbnail) + '" alt="">' +
                '<div class="media-body">' +
                '<strong class="media-heading">' + escape(item.title) + '</strong>' +
                '<p>' + escape((item.synopsis || 'No synopsis available at this time.').substring(0, 80)) + '</p>' +
                '<p>' + (actors.length ? 'Starring ' + actors.join(', ') : 'Actors unavailable') + '</p>' +
                '</div>' +
                '</div>';
      }
    },
    load: function(query, callback) {
      if (!query.length)
        return callback();
      $.ajax({
        url: 'http://api.rottentomatoes.com/api/public/v1.0/movies.json',
        type: 'GET',
        dataType: 'jsonp',
        data: {
          q: query,
          page_limit: 10,
          apikey: 'puhkccvuy6p87zp54qr887bn'
        },
        error: function() {
          callback();
        },
        success: function(res) {
          callback(res.movies);
        }
      });
    }
  };
  
  var $selectize = $('.selectize-search-movie').selectize(selectMovieOptions);
  if(! $selectize[0]) {
    return;
  }
  var control = $selectize[0].selectize;
  control.on('item_add', function(){
    control.close();
    control.clear();
  });

  $('.selectize-select-movie').selectize(selectMovieOptions);

  $("#select-car").selectize({
    options: [
      {id: 'avenger', make: 'dodge', model: 'Avenger'},
      {id: 'caliber', make: 'dodge', model: 'Caliber'},
      {id: 'caravan-grand-passenger', make: 'dodge', model: 'Caravan Grand Passenger'},
      {id: 'challenger', make: 'dodge', model: 'Challenger'},
      {id: 'ram-1500', make: 'dodge', model: 'Ram 1500'},
      {id: 'viper', make: 'dodge', model: 'Viper'},
      {id: 'a3', make: 'audi', model: 'A3'},
      {id: 'a6', make: 'audi', model: 'A6'},
      {id: 'r8', make: 'audi', model: 'R8'},
      {id: 'rs-4', make: 'audi', model: 'RS 4'},
      {id: 's4', make: 'audi', model: 'S4'},
      {id: 's8', make: 'audi', model: 'S8'},
      {id: 'tt', make: 'audi', model: 'TT'},
      {id: 'avalanche', make: 'chevrolet', model: 'Avalanche'},
      {id: 'aveo', make: 'chevrolet', model: 'Aveo'},
      {id: 'cobalt', make: 'chevrolet', model: 'Cobalt'},
      {id: 'silverado', make: 'chevrolet', model: 'Silverado'},
      {id: 'suburban', make: 'chevrolet', model: 'Suburban'},
      {id: 'tahoe', make: 'chevrolet', model: 'Tahoe'},
      {id: 'trail-blazer', make: 'chevrolet', model: 'TrailBlazer'},
    ],
    optgroups: [
      {id: 'dodge', name: 'Dodge'},
      {id: 'audi', name: 'Audi'},
      {id: 'chevrolet', name: 'Chevrolet'}
    ],
    labelField: 'model',
    valueField: 'id',
    optgroupField: 'make',
    optgroupLabelField: 'name',
    optgroupValueField: 'id',
    optgroupOrder: ['chevrolet', 'dodge', 'audi'],
    searchField: ['model'],
    plugins: ['optgroup_columns']
  });
});