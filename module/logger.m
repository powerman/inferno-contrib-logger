
Logger: module
{
	PATH: con "/opt/powerman/logger/dis/lib/logger.dis";

	init: fn();

	progname: fn(s: string);
	modname: fn(s: string);
	log: fn(level: int, s: string);

	ERR, WARN, INFO, DEBUG, DUMP: con iota;
	verbose: int;
};

