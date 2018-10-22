function update_composite_name(composite_id) {
	var new_name = $('#standard_name_' + composite_id).val();
	jQuery.ajax({url:"/assessments/" + id + "/invalidate",
				data: "invalidated=" + on,
				type: "PUT",
		        error: function() { alert('Oh noes!') }, 
		        async: false}); 	
	
}
