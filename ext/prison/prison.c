#include "prison.h"

VALUE cPrison;
struct iovec *iov;

struct r_jail {
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
				u_int niov = 0;
				int flags = 0;
				int jg_res = jail_get(iov, niov, flags);
				printf("%d\n", jg_res);
				return self;
}

void Init_prison(){
				puts("called Init_prison()");
				cPrison = rb_define_class("Prison", rb_cObject);

				rb_define_method(cPrison, "list", RUBY_METHOD_FUNC(list_func),0);
}

