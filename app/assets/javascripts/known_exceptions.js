function update_knex_effective_date(id) {
	var on = document.getElementById("knex_effective_" + id).value;	
	jQuery.ajax({url:"/known_exceptions/" + id + "/update_effective_date",
		data: "effective_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 	
}

function update_knex_expiration_date(id) {
	var on = document.getElementById("knex_effective_" + id).value;	
	jQuery.ajax({url:"known_exceptions/" + id + "/update_expiration_date",
		data: "expiration_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 		
}
