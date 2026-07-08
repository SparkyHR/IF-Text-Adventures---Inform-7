"Orbital Crisis" by SparkyHR

The story headline is "A science station loses power. You must restore the main computer before impact."

[SETTING AND ATMOSPHERE]
The sky is a room. "You wake in the observation dome of Zenith Station, an orbital research facility high above Earth. Through the transparent aluminum walls, you can see our planet rotating slowly below. But something is terribly wrong. The station shudders violently, and emergency lights flicker red. A computerized voice crackles overhead: 'WARNING: Orbital decay detected. Recalculation required. Estimated time to atmosphere interface: 47 minutes.'"

The observation_dome is a room. "This transparent dome offers a panoramic view of space and Earth below. A quantum computer terminal sits dormant in the center, its screen dark. To the west, you can see the dim outline of the station hub connecting to other modules."

The description of the observation_dome is "You're in the heart of the station's observation area. The quantum computer that controls orbital calculations is here, but it needs power. A cool hum of failing life support echoes through the walls."

The hub is a room west of the observation_dome. "This is the central junction of Zenith Station. Three corridors branch off: the Power Module to the west, the Research Lab to the north, and the Communications Array to the south. The station's frame creaks ominously."

The power_module is a room west of the hub. "The main power plant occupies this section. Two massive fusion reactors line the walls, and you can see a large circuit breaker panel against the far wall. One of the reactors is dark—offline. A thick layer of frost covers parts of the equipment from a recent coolant leak."

The reactor_control is part of the power_module. "The manual override panel shows a large red button labeled 'RESTART REACTOR 2.' Next to it, a faded warning reads: 'CAUTION: Reactor restart will route primary power to Central Systems.'"

The research_lab is a room north of the hub. "This lab is a mess—papers and specimen containers float in the microgravity, and computer workstations lie dormant. A backup power cell sits on a shelf, glowing faintly. A few physics textbooks drift near the ceiling."

The comms_array is a room south of the hub. "The communications equipment fills this room with blinking lights and dormant screens. A solar panel control console sits against one wall, covered in dust. A cracked monitor displays scrolling error messages."

[OBJECTS]
The quantum_computer is a device in the observation_dome. It is fixed in place. The description is "A sleek machine covered in dark displays and inactive indicator lights. It pulses faintly—dormant but not dead. This computer controls all orbital mechanics calculations."

The circuit_breaker_panel is a device in the power_module. It is fixed in place. The description is "A wall-mounted panel with dozens of switches and a large red restart button. Below it, a label reads 'Reactor 2 — Manual Override.'"

The backup_power_cell is a portable thing in the research_lab. The description is "A compact energy cell, warm to the touch. It provides enough power to run critical systems for a short time."

The solar_panel_console is a device in the comms_array. It is fixed in place. The description is "A control interface for the station's external solar array. It's covered in dust, suggesting it hasn't been used in months."

The reactor is a device in the power_module. The description is "Reactor 2 is completely offline, its fuel chamber dark and cold."

[GAME MECHANICS]
A room can be powered or unpowered. The observation_dome is unpowered. The power_module is unpowered. The research_lab is unpowered. The comms_array is unpowered. The hub is unpowered.

The computer_online is a truth state that varies. The computer_online is false.
The reactor_running is a truth state that varies. The reactor_running is false.
The solar_arrays_deployed is a truth state that varies. The solar_arrays_deployed is false.

[ACTIONS AND RULES]
Instead of examining the quantum_computer:
	if the observation_dome is powered:
		say "The quantum computer hums to life, its displays flickering to show orbital data. It's running diagnostics now.";
	else:
		say "The quantum computer is dark and inert. It needs power.";

Instead of pushing the circuit_breaker_panel:
	if the reactor_running is true:
		say "The reactor is already running!";
	else if the backup_power_cell is in the research_lab:
		say "You slam the restart button, but nothing happens—there's no power to bootstrap the reactor.";
	else if the player has the backup_power_cell:
		say "You insert the backup power cell into the manual override socket. Lights flicker. The backup cell hums with effort. Deep within the reactor, cooling systems activate. A low rumble builds beneath your feet as the fusion reaction kindles. The reactor roars to life, and power surges through Zenith Station!";
		now the reactor_running is true;
		now the observation_dome is powered;
		now the power_module is powered;
		now the hub is powered;
		now the research_lab is powered;
		now the comms_array is powered;
	else:
		say "You push the button, but nothing happens. The reactor needs external power to bootstrap.";

Instead of pushing the solar_panel_console:
	if the solar_arrays_deployed is true:
		say "The solar panels are already deployed and feeding power to the station.";
	else:
		say "You activate the solar array deployment sequence. Outside, massive panels unfold across the station's exterior, catching the brilliant light of the distant sun. Power begins to trickle into the backup systems.";
		now the solar_arrays_deployed is true;
		now the observation_dome is powered;
		now the research_lab is powered;

Instead of taking the backup_power_cell:
	now the player has the backup_power_cell;
	say "You carefully secure the backup power cell and tuck it into your suit pocket.";

Instead of examining the quantum_computer when the observation_dome is powered:
	say "The quantum computer's displays glow brilliantly now. Orbital parameters scroll across the screen. The computer is running full trajectory calculations. You hear a soft beep.";
	if the reactor_running is true:
		say "[line break]The main display shows: 'ORBITAL RECALCULATION COMPLETE. New stable orbit achieved. Collision averted. All systems nominal.'[line break]The station stops shuddering. The emergency lights change from red to steady green. You've done it!";
		now the computer_online is true;
		end the game in victory;
	else:
		say "[line break]The display flickers. It needs more power than the solar backup can provide.";

[WINNING CONDITION]
When the computer_online is true:
	say "[bold]STATION SAVED[/bold][line break]";
	say "The quantum computer has recalculated the station's orbit, pulling it back from the brink of atmospheric reentry. Zenith Station is stable once more. Your quick thinking has saved the lives of everyone aboard.";
	end the game in victory;

[SETUP]
When play begins:
	say "[bold]ZENITH STATION — EMERGENCY[/bold][line break]";
	say "Forty-seven minutes. That's all you have.[line break]";
	now the sky is a room.
