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

function split_instrument(exception_id, src_id) {
	var split_date = $('#exp_date_' + exception_id).val();
	var name = $('#candidate_name_' + exception_id).val();
    var data = { 'date': split_date,
                 'name': name };
	
	if (split_date) {
		var src_arg = "";
		if (src_id != 0) {
			src_arg += "&src_id=" + src_id;
		}
		
		jQuery.ajax({url:"/instrument_exceptions/" + exception_id + "/split?corporate=true" + src_arg,
					data: data,
					type: "PUT",
			        error: function() { alert('Oh noes!'); }, 
			        async: false}); 		
	}
	else {
		alert("Please enter a date!");
	}
}
