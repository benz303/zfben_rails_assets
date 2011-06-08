module('Init');

test('jQuery', function(){
  ok($ === jQuery, '$ === jQuery');
});

module('Load module');

asyncTest('success load', function(){
  
  ok($.load('zff/lib/underscore/core') === 202, 'underscore is not loaded');
  
  var i = 0;
  
  $.load('zff/lib/underscore/core', function(){
    ok($.isFunction(_), '_ is loaded');
    ok($.load('zff/lib/underscore/core') === 200, 'zff/lib/underscore/core loaded');
    i++;
    ok(i === 1, 'success func is loaded');
  });
  $.load('zff/lib/underscore/core', function(){
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

