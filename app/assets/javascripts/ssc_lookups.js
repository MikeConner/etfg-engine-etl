function update_ssc_effective(id) {
	var on = document.getElementById("ssc_effective_" + id).value;	
	jQuery.ajax({url:"/ssc_lookups/" + id + "/update_effective_date",
		data: "effective_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 	
}

function update_ssc_expiration(id) {
	var on = document.getElementById("ssc_expiration_" + id).value;	
	jQuery.ajax({url:"/ssc_lookups/" + id + "/update_expiration_date",
		data: "expiration_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 		
}
