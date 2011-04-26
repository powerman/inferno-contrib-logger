
Logger: module
{
	PATH: con "/opt/powerman/logger/dis/lib/logger.dis";

	init: fn();

	progname: fn(s: string);	# WARNING: will do pctl(FORKENV)
	modname: fn(s: string);
	prefix: fn(s: string);
	log: fn(level: int, s: string);

	ERR, WARN, NOTICE, INFO, DEBUG: con iota;
	verbose: int;
};

