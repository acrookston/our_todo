$(function(){
  $('input[type=checkbox]').live('click', function(){
    var input = $(this);
    var row = input.parents('li').hide().toggleClass('done');
    if (input.is(':checked')) {
      if ($('.done').length > 1){
        row.insertBefore($('.done')[1]).fadeIn();
      } else {
        $('ul').append(row.fadeIn());
      }      
    } else {
      $('ul').prepend(row.fadeIn());
    }
  });

  $('form').bind('submit', function(e){
    e.preventDefault();
    var input = $('[type=text]');
    var randomid = Math.floor(Math.random()*11);
    var item = $('<li><input type="checkbox" id="' + randomid + '"/><label for="' + randomid + '">' + input.val() + '</label></li>').hide();
    $('ul').prepend(item.fadeIn());
    input.val('');
  });
});