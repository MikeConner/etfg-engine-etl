$(function() { 
  $(".jquery-ui-date").datepicker();
  $(".jquery-ui-datetime").datetimepicker({timeFormat:"hh:mm tt",
                                           showTimezone: true,
                                           timezoneList:[{label:"EST",value:-240},
	                                                     {label:"CST",value:-300},
	                                                     {label:"MST",value:-360},
	                                                     {label:"PST",value:-420}]});
});
