module('Init');

test('jQuery', function(){
  ok($ === jQuery, '$ === jQuery');
});

module('Load module');

asyncTest('success load', function(){
  
  ok($.load('underscore') === 202, 'underscore is not loaded');
  
  var i = 0;
  
  $.load('underscore', function(){
    ok($.isFunction(_), '_ is loaded');
    ok($.load('underscore') === 200, 'underscore loaded');
    i++;
    ok(i === 1, 'success func is loaded');
  });
  $.load('underscore', function(){
    i++;
    ok(i === 2, 'twice success func is loaded');
    start();
  });
});

asyncTest('error load', function(){
  ok($.load('null') === 202, 'null is not loaded');
  
  $.load('null', {
    error: function(){
      ok($.load('null') === 500, 'module null is error');
      start();
    }
  });
});

