$(function(){

  var opts = {
    lines: 10,
    length: 2,
    width: 2,
    radius: 5,
    color: '#333',
    speed: 1.0,
    trail: 14,
    shadow: false
  };
  var form_spinner = new Spinner(opts).spin();
  $('#new_item').append(form_spinner.el);
  var spinner_el = $(form_spinner.el).css({
    position: "absolute",
    right: "172px",
    top: "39px",
    display: "none"
  });
  var updateItem = function(item, callback, error_callback) {
    var spinner = new Spinner(opts).spin();
    item.append(spinner.el);
    var li_spinner_el = $(spinner.el).css({
      position: "absolute",
      right: "30px",
      top: "19px"
    });
    if (typeof error_callback === "undefined") {
      error_callback = function() { alert("Sorry, an error occured while updating your item"); };
    }
    $.ajax({
      type: 'PUT',
      url: '/item/'+item.attr('id')+'.json',
      data: {
        title:     item.find('input[type=text]').val(),
        completed: item.find('input[type=checkbox]').is(':checked')
      },
      success: function(data){
        li_spinner_el.remove();
        callback(data);
      },
      error: function(data){
        li_spinner_el.remove();
        error_callback(data);
      }
    });
  };

  $('input[type=checkbox]').live('click', function(){
    var input = $(this);
    updateItem(input.parents('li'), function(){
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
  });

  $('label').live('click', function(){
    var label = $(this);
    if (!label.parent().is('.done')) {
      label.hide();
      var input = $('<input type="text"/>').val(label.text()).appendTo(label.parent()).select();
      var update = function(){
        updateItem(label.parents('li'), function(){
          label.text(input.val()).show();
          input.remove();
        });
      };
      input.blur(update).bind('keypress', function(e){
        if((e.keyCode || e.which) == 13) {
          update();
        }
      });
    }
  });

  $('#new_item').submit(function(e){
    e.preventDefault();
    var form = $(this);
    var input = $('[type=text]');
    if (input.val().length > 0) {
      input.attr('disabled', '');
      spinner_el.show();
      $.ajax({
        type: 'POST',
        url: form.attr('action')+'.json',
        data: {title: input.val() },
        success: function(data){
          spinner_el.hide();
          input.removeAttr('disabled', '');
          if (!data.error) {
            var item = $('<li id="'+data.id+'"><input type="checkbox"/><label>' + input.val() + '</label></li>').hide();
            $('ul').prepend(item.fadeIn());
            input.val('');
          }
          $('li.no-items').remove();
        },
        error: function(){
          spinner_el.hide();
          input.removeAttr('disabled', '');
        }
      });
    }
    return false;
  });
});