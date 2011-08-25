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

  $('label').live('click', function(){
    var label = $(this);
    if (!label.parent().is('.done')) {
      label.hide();
      var input = $('<input type="text"/>').val(label.text()).appendTo(label.parent()).select();
      input.blur(function(){
        label.text(input.val()).show();
        input.remove();
      }).bind('keypress', function(e){
        if((e.keyCode || e.which) == 13) {
          label.text(input.val()).show();
          input.remove();
        }
      });
    }
  });

  $('form').submit(function(e){
    e.preventDefault();
    var input = $('[type=text]');
    if (input.val().length > 0) {
      var item = $('<li><input type="checkbox"/><label>' + input.val() + '</label></li>').hide();
      $('ul').prepend(item.fadeIn());
      input.val('');
    }
    return false;
  });
});