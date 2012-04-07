
$(document).ready(function(){

  $.extend($.expr[':'], {
      icontains: function(a,i,m){
        return (a.textContent||a.innerText||jQuery(a).text()||"").toLowerCase().indexOf(m[3].toLowerCase())>=0;
        }
    });

});


