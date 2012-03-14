
$(document).ready(function(){

$.extend($.expr[':'], {
    icontains: function(a,i,m){return (a.textContent||a.innerText||jQuery(a).text()||"").toLowerCase().indexOf(m[3].toLowerCase())>=0;}
    });

$.extend({
getUrlVars: function(){
var vars = [], hash;
var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
for(var i = 0; i < hashes.length; i++)
{
hash = hashes[i].split('=');
vars.push(hash[0]);
vars[hash[0]] = hash[1];
}
return vars;
},
getUrlVar: function(name){
return $.getUrlVars()[name];
}
});
});
