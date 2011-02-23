$.fn.extend({charCounter:function(a)
{return this.each(function()
{$(this).bind("blur focus keyup",function()
{var g=a.min;var i=a.max;var h=a.setIsValid||function(){};var d=this.value?this.value.length:0;var e=d>i?"warning":d>i*0.8?"supernova":d>i*0.6?"hot":d>i*0.4?"warm":"cool";var c="";if(d==0){c="enter at least "+g+" characters";h(false)}
else
{if(d<g){c=(g-d)+" more to go..";h(false)}
else{if(i){c=(i-d)+" character"+(i-d!=1?"s":"")+" left";h(d<=i)}}}
var f=$(this).parents("form").find("span.text-counter");f.text(c);if(!f.hasClass(e)){f.removeClass("warning supernova hot warm cool").addClass(e)}})})}});$(document).ready(function(){var u=false;var p=function(w){u=w};$("#question_body").charCounter({min:5,max:140,setIsValid:p});$(".answer_body").charCounter({min:15,setIsValid:p});$(".new_comment textarea").charCounter({min:5,max:140,setIsValid:p});});