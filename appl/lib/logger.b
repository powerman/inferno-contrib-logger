implement Logger;

include "sys.m";
	sys: Sys;
	sprint: import sys;
include "env.m";
	env: Env;
include "daytime.m";
	daytime: Daytime;
include "../../module/logger.m";

output	: ref Sys->FD;
src	:= "";
prog	:= "";
mod	:= "";
pfx	:= "";


init()
{
	sys = load Sys Sys->PATH;
	env = checkload(load Env Env->PATH, "Env");
	daytime = checkload(load Daytime Daytime->PATH, "Daytime");

	path := env->getenv("logoutput");
	if(path == nil)
		output = sys->fildes(2);
	else{
		output = sys->open(path, Sys->OWRITE);
		if(output == nil)
			fail(sprint("open '%s': %r", path));
	}

	src = env->getenv("logsrc");
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
	sys->pctl(Sys->FORKENV, nil);
	env->setenv("logprogname", prog);
}

modname(s: string)
{
	mod = s;
}

prefix(s: string)
{
	pfx = s;
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
	*	=> fail("unknown level: "+string level);
	}
	dt := daytime->time();
	if(dt[8] == '0')
		dt[8] = ' ';
	ident := src + prog;
	if(ident != nil && mod != nil)
		ident += ".";
	ident += mod;
	# "user.err: " + "Dec  5 15:46:38 " + "ident" + "[123]" + ": "
	sys->fprint(output, "user.%s: %s%s[%d]: %s%s\n",
		l, dt[4:20], ident, sys->pctl(0,nil), pfx, s);
}

fail(s: string)
{
        if(output != nil)
                log(ERR, s);
        else
                sys->fprint(sys->fildes(2), "%s\n", s);
	raise "fail:"+s;
}

checkload[T](x: T, s: string): T
{
	if(x == nil)
		fail(sprint("load: %s: %r", s));
	return x;
}


