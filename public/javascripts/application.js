// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function update_select_options( target, opts_array, clear_select_list ) {

    if( $(target).type.match("select" ) ){ // Confirm the target is a select box

        // Remove existing options from the target and the clear_select_list
        clear_select_list[clear_select_list.length] = target // Include the target in the clear list

        for( k=0;k < clear_select_list.length;k++){
            obj = $(clear_select_list[k]);
            if( obj.type.match("select") ){
                len = obj.childNodes.length;
                for( var i=0;i < len;i++){obj.removeChild(obj.firstChild);}
            }
        }

        // Populate the new options
        for(i=0;i < opts_array.length;i++){
            o = document.createElement( "option" );
            o.appendChild( document.createTextNode( opts_array[i][0] ) );
            o.setAttribute( "value", opts_array[i][1] );
            obj.appendChild(o);
        }
    }
}

function updateProvider(element, value, hiddenField, modelID) {
	var url =  '/inav/providers/' + modelID + '/auto_complete_show.js';

	var update = new Ajax.Updater(
		{success:'patientproviderassignmentprovider'},
	   url,
		{method: 'get', parameters: { id: modelID }}
		);
}