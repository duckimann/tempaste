(({vOpen, vr, resistor}) => {
	let result = (vOpen - vr) / (vr / resistor);
	console.log(`Internal Resistance Value: ${result} Ohm || ${ Math.ceil( result * 1000 ) } miliOhm.`);
})({
	vOpen: 4.1, // Open circuit voltage
	vr: 4.04, // Voltage when connected to an resistor, wait a few second
	resistor: 1 // Resistor Value, Measured in Ohm
})