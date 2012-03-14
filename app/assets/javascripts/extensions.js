
$(document).ready(function(){

$.extend($.expr[':'], {
    icontains: function(a,i,m){
      return (a.textContent||a.innerText||jQuery(a).text()||"").toLowerCase().indexOf(m[3].toLowerCase())>=0;
      }
  });


(function($){
 $.getParameterByName = function(name){

    name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
    var regexS = "[\\?&]" + name + "=([^&#]*)";
    var regex = new RegExp(regexS);
    var results = regex.exec(window.location.search);
    if(results == null)
      return "";
    else 
      return decodeURIComponent(results[1].replace(/\+/g, " "));
 };
 })(jQuery);

});


