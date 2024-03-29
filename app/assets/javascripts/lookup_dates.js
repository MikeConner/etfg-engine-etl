function update_lookup_effective_date(id, prefix) {
	var on = document.getElementById(prefix + "_effective_" + id).value;	
	jQuery.ajax({url:"/" + prefix + "_lookups/" + id + "/update_effective_date",
		data: "effective_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 	
}

function update_lookup_expiration_date(id, prefix) {
	var on = document.getElementById(prefix + "_expiration_" + id).value;	
	jQuery.ajax({url:"/" + prefix + "_lookups/" + id + "/update_expiration_date",
		data: "expiration_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 		
}

function update_ff_effective_date(id) {
	var on = document.getElementById("ff_effective_" + id).value;	
	jQuery.ajax({url:"/date_adjust_fund_flows/" + id + "/update_effective_date",
		data: "effective_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 	
}

function update_ff_expiration_date(id) {
	var on = document.getElementById("ff_expiration_" + id).value;	
	jQuery.ajax({url:"/date_adjust_fund_flows/" + id + "/update_expiration_date",
		data: "expiration_date=" + on,
		type: "PUT",
        error: function() { alert('Error updating field!'); }, 
        async: false}); 		
}
