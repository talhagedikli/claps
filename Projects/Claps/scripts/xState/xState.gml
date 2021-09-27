/// @func xState())
#macro MAX_STATE_HISTORY 10
function xState(_first, _owner = other.id) constructor
{
	owner	= _owner;
	inited	= false;
	first	= _first;
	base	= {};
	with (owner)
	{
		__state			= {};
		__states		= {};
		__defaults		= {};
		__states_array	= [];
		__history		= [];
	}
	static __update_history = function (name)
	{
		var l = array_length(owner.__history);
		array_push(owner.__history, name);
		if (l >= MAX_STATE_HISTORY)
		{
			array_delete(owner.__history, 0, 1);
		}
	}
	// These methods to create default events before and after a specific event
	// You can apply these functions via using "call("event", (defaults) true)" method like that 
	static default_before = function(func)
	{
		with(owner) 
		{
			__defaults[$ "before"] = func;
		}
		return self;		
	}	
	static default_after = function(func)
	{
		with(owner) 
		{
			__defaults[$ "after"] = func;
		}
		return self;		
	}
	// To add an event to state machine
	// Order stars from zero(if you add second its index is 1)
	static add	= function(name, struct)
	{
		with(owner) 
		{
			__states[$ name]			= struct;
			__states[$ name][$ "name"]	= name;
		}
		return self;
	}
	// add	= method(owner, function(name, struct)
	// {
	// 	__states[$ name]			= struct;
	// 	__states[$ name][$ "name"]	= name;
	// 	return self;
	// });

	// Inits the function and runs first code
	static init = function(name)
	{
		// No need to execute leave because it is first event
		// if (variable_struct_exists(owner.__state, "leave")) 
		// {
		// 	with owner
		// 	{
		// 		script_execute_ext(method_get_index(__state.leave), []);
		// 	}
		// }
		// Create an array includes all states names in a row when you init your state
		// You can get this array via "xState.get_state_array()"
	    var names = variable_struct_get_names(owner.__states)
	    var size = variable_struct_names_count(owner.__states);
		for (var i = 0; i < size; i++) 
		{
	        var ind = names[i];
	        var val = variable_struct_get(owner.__states, ind);
	        if (array_safe(owner.__states_array, val.name))
			{
	        	array_push(owner.__states_array, val.name);
			}
    	}
    	// Apply first state
		owner.__state = owner.__states[$ name];
		__update_history(name);
		// No need to execute first 
		// After creating first event run its enter code
		if (variable_struct_exists(owner.__state, "enter")) 
		{
			with owner
			{
				script_execute_ext(method_get_index(__state.enter), []);
			}
		}
		return self;
	}
	// To change event and run leave - "event name" - enter functions
	static change = function(name, funcbef = function() {}, funcaft = function() {})
	{
		if (variable_struct_exists(owner.__states, name))
		{
			// Run a specific before function before you change state 
			// And run leave function you if it exists
			funcbef();
			if (variable_struct_exists(owner.__state, "leave")) 
			{
				with (owner)
				{
					script_execute_ext(method_get_index(__state.leave), []);
				}
			}
			// Switch state itself then update history
			// !!! History not working properly now
			owner.__state = owner.__states[$ name];
			__update_history(name);
			// Run a specific after function after you change state 
			// And run enter function you if it exists			
			funcaft();
			if (variable_struct_exists(owner.__state, "enter")) 
			{
				with (owner)
				{
					script_execute_ext(method_get_index(__state.enter), []);
				}
			}
		}
		return self;
	}
	// Call functions whenever you want
	// Enter and leave functions will be called also
	// Running default functions every time you use "call" method is up to you (_defaults)
	static call = function(name, _defaults = false)
	{
		if (_defaults)
		{
			with (owner)
			{
				script_execute_ext(method_get_index(__defaults[$ "before"]), []);
				if (is_method(method_get_index(__state[$ name])))
				{
					script_execute_ext(method_get_index(__state[$ name]), []);
				}
				script_execute_ext(method_get_index(__defaults[$ "after"]), []);
			}
		}
		else
		{
			with (owner)
			{
				if (is_method(method_get_index(__state[$ name])))
				{
					script_execute_ext(method_get_index(__state[$ name]), []);
				}
			}			
		}
		return self;
	}
	// Get current states name
	static get_state = function()
	{
		return owner.__state.name;
	}	
	// Get number of states
	static get_state_length = function()
	{
		return variable_struct_names_count(owner.__states);
	}
	// Get array includes all states name in string (in a row you add them)
	static get_state_array = function()
	{
		return owner.__states_array;
	}
	// !!! Not working for now
	static get_state_history = function()
	{
		return (owner.__history);
	}
}










