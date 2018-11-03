function update_default_instrument(id) {
	var on = document.getElementById("default_" + id).checked;	
	jQuery.ajax({url:"/instruments/" + id + "/set_default",
				data: "default=" + on,
				type: "PUT",
		        error: function() { alert('Oh noes!'); }, 
		        async: false}); 	
	
}

function update_approved_instrument(id) {
	var on = document.getElementById("default_" + id).checked;	
	jQuery.ajax({url:"/instruments/" + id + "/set_approved",
				data: "approved=" + on,
				type: "PUT",
		        error: function() { alert('Oh noes!'); }, 
		        async: false}); 	
	
}
