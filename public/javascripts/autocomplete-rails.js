$(document).ready(function(){$('.autocomplete').railsAutocomplete();});(function(jQuery)
{var self=null;jQuery.fn.railsAutocomplete=function(){return this.live('focus',function(){if(!this.railsAutoCompleter){this.railsAutoCompleter=new jQuery.railsAutocomplete(this);}});};jQuery.railsAutocomplete=function(e){_e=e;this.init(_e);};jQuery.railsAutocomplete.fn=jQuery.railsAutocomplete.prototype={railsAutocomplete:'0.0.1'};jQuery.railsAutocomplete.fn.extend=jQuery.railsAutocomplete.extend=jQuery.extend;jQuery.railsAutocomplete.fn.extend({init:function(e){e.delimiter=$(e).attr('delimiter')||null;function split(val){return val.replace(/，([\s])+/,',').split(/,\s*/);}
function extractLast(term){return split(term).pop();}
$(e).autocomplete({source:function(request,response){$.getJSON($(e).attr('data-autocomplete'),{term:extractLast(request.term)},response);},search:function(){var term=extractLast(this.value);if(term.length<1){return false;}},focus:function(){return false;},select:function(event,ui){var terms=split(this.value);terms.pop();terms.push(ui.item.value);if(e.delimiter!=null){terms.push("");this.value=terms.join(e.delimiter);}else{this.value=terms.join("");if($(this).attr('id_element')){$($(this).attr('id_element')).val(ui.item.id);}};return false;}});}});})(jQuery);