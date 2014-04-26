#include "prison.h"

VALUE cPrison;

struct jail {
				VALUE	version;
				VALUE	path;
				VALUE	hostname;
				VALUE	jailname;
				VALUE ip4s;
				VALUE	ip6s;
				VALUE	ip4;
				VALUE	ip6;
};

VALUE list_func(VALUE self){
				puts ("Prison#list()");
				return self;
}

void Init_prison(){
				puts("called Init_prison()");
				cPrison = rb_define_class("Prison", rb_cObject);

				rb_define_method(cPrison, "list", RUBY_METHOD_FUNC(list_func),0);
}

