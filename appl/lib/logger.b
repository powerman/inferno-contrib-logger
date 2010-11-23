implement Logger;

include "sys.m";
	sys: Sys;
	sprint: import sys;
include "env.m";
	env: Env;
include "../../module/logger.m";

prog	:= "";
mod	:= "";

init()
{
	sys = load Sys Sys->PATH;
	env = checkload(load Env Env->PATH, "Env");

	prog = env->getenv("logprogname");

	case env->getenv("loglevel") {
	"ERR"	=> verbose = ERR;
	"WARN"	=> verbose = WARN;
	"NOTICE"=> verbose = NOTICE;
	"INFO"	=> verbose = INFO;
	"DEBUG" => verbose = DEBUG;
	*	=> verbose = WARN;
	}
}

progname(s: string)
{
	prog = s;
	env->setenv("logprogname", prog);
}

modname(s: string)
{
	mod = s;
}


###

log(level: int, s: string)
{
	if(level > verbose)
		return;
	l : string;
	case level {
	ERR	=> l = "err";
	WARN	=> l = "warn";
	NOTICE	=> l = "notice";
	INFO	=> l = "info";
	DEBUG	=> l = "debug";
	*	=> l = "unknown";
	}
	prefix := prog;
	if(prefix != nil && mod != nil)
		prefix += " ";
	prefix += mod;
	sys->fprint(sys->fildes(2), "%s: [%s] %s\n", prefix, l, s);
}

fail(s: string)
{
	log(ERR, s);
	raise "fail:"+s;
}

checkload[T](x: T, s: string): T
{
	if(x == nil)
		fail(sprint("load: %s: %r", s));
	return x;
}


