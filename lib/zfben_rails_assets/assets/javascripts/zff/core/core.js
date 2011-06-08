//= require zff/lib/jquery/core

var MODULE_PATH = '/assets';

// load module
// $.load(module_name, success_function)
// $.load(module_name, ajax_options)

(function($){
  
  var info = {};
  
  $.load = function(module, opts){
    opts = opts || {};
    
    if($.isFunction(opts)){
      opts = {
        success: opts
      };
    }
    
    if(typeof info[module] === 'undefined'){
      var defaults = {
        url: MODULE_PATH + '/' + module + '.js',
        dataType: 'script'
      };
      
      opts = $.extend(defaults, opts);
      
      var xhr = $.ajax(opts).success(function(){
        info[module].state = 200;
      }).error(function(){
        info[module].state = 500;
      });
      
      info[module] = {
        state: 202,
        xhr: xhr
      };
    }else{
      if(info[module].state === 200){
        if($.isFunction(opts.success)){
          opts.success();
        }
      }
      
      if(info[module].state === 202){
        $.each(['success', 'error', 'complete', 'statusCode'], function(i, type){
          if($.isFunction(opts[type])){
            info[module].xhr = info[module].xhr[type](opts[type]);
          }
        });
      }
    }
    return info[module].state;
  };
})($);
