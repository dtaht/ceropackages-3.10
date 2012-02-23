/*
 * Copyright (C) 2009-2010  Internet Systems Consortium, Inc. ("ISC")
 *
 * Permission to use, copy, modify, and/or distribute this software for any
 * purpose with or without fee is hereby granted, provided that the above
 * copyright notice and this permission notice appear in all copies.
 *
 * THE SOFTWARE IS PROVIDED "AS IS" AND ISC DISCLAIMS ALL WARRANTIES WITH
 * REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS.  IN NO EVENT SHALL ISC BE LIABLE FOR ANY SPECIAL, DIRECT,
 * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
 * LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE
 * OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
 * PERFORMANCE OF THIS SOFTWARE.
 */

/* $Id: trpmp.c 589 2010-01-15 05:00:12Z pselkirk $ */

/*
 * Trivial relay for NAT-PMP
 *
 * Francis_Dupont@isc.org, November 2009
 *
 * local LAN(s) side: run standard NAT-PMP over (unicast) IPv4
 * remote server side: run extended NAT-PMP over IPv6
 *
 * usage:
 *  -b <IPv6>: local IPv6 address on the server side: used as the source
 *	address for extended NAT-PMP requests. required
 *
 *  -s <IPv6>: IPv6 address of the server: used as the destination address
 *	for extended NAT-PMP requests. required
 *
 *  -l <IPv4>: local IPv4 address on the client side: clients send
 *	standard NAT-PMP requests to this address. at least one is required
 */

#include <sys/select.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <err.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int sfd = -1;

struct lan {
	struct lan *next;
	uint32_t addr;
	int fd;
};
struct lan *lans;

void
setserver(const char *server, const char *local)
{
	struct sockaddr_in6 srv;

	if (local == NULL)
		errx(1, "local must be set before server");
	if (sfd >= 0)
		errx(1, "server is already set");
	sfd = socket(PF_INET6, SOCK_DGRAM, IPPROTO_UDP);
	if (sfd < 0)
		err(1, "socket6");
	memset(&srv, 0, sizeof(srv));
	srv.sin6_family = AF_INET6;
	if (inet_pton(AF_INET6, local, &srv.sin6_addr) <= 0)
		errx(1, "bad local \"%s\"", local);
	if (bind(sfd, (struct sockaddr *) &srv, sizeof(srv)) < 0)
		err(1, "bind(%s)", local);
	memset(&srv, 0, sizeof(srv));
	srv.sin6_family = AF_INET6;
	if (inet_pton(AF_INET6, server, &srv.sin6_addr) <= 0)
		errx(1, "bad server \"%s\"", server);
	srv.sin6_port = htons(5351);
	if (connect(sfd, (struct sockaddr *) &srv, sizeof(srv)) < 0)
		err(1, "connect");
}

void
setlan(const char *lan)
{
	struct lan *l;
	struct sockaddr_in clt;

	l = (struct lan *) malloc(sizeof(*l));
	if (l == NULL)
		err(1, "malloc lan");
	memset(l, 0, sizeof(*l));
	if (inet_pton(AF_INET, lan, &l->addr) <= 0)
		errx(1, "bad lan \"%s\"", lan);
	memset(&clt, 0, sizeof(clt));
	clt.sin_family = AF_INET;
	clt.sin_addr.s_addr = l->addr;
	clt.sin_port = htons(5351);
	l->fd = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP);
	if (l->fd < 0)
		err(1, "socket(%s)", lan);
	if (bind(l->fd, (struct sockaddr *) &clt, sizeof(clt)) < 0)
		err(1, "bind(%s)", lan);
	l->next = lans;
	lans = l;
}

void
fromclient(const struct lan *l)
{
	unsigned char buf[128];
	struct sockaddr_in from;
	socklen_t fromlen;
	int cc;

	memset(buf, 0, sizeof(buf));
	memset(&from, 0, sizeof(from));
	fromlen = sizeof(from);
	cc = recvfrom(l->fd, buf, 128, 0, (struct sockaddr *) &from, &fromlen);
	if (cc < 0) {
		warn("recvfrom");
		return;
	} else if (cc <= 1) {
		warnx("underrun");
		return;
	} else if (cc >= 100) {
		warnx("overrun");
		return;
	}
	memmove(buf + 12, buf, cc);
	cc += 12;
	buf[0] = 12;
	buf[1] = 'P';
	memcpy(buf + 2, &from.sin_port, 2);
	memcpy(buf + 4, &l->addr, 4);
	memcpy(buf + 8, &from.sin_addr, 4);
	if (send(sfd, buf, cc, 0) < 0)
		warn("send6");
}

void
fromserver(void)
{
	struct lan *l;
	unsigned char buf[128];
	struct sockaddr_in to;
	int cc;

	memset(buf, 0, sizeof(buf));
	cc = recv(sfd, buf, 128, 0);
	if (cc < 0) {
		warn("recv6");
		return;
	} else if (cc <= 15) {
		warnx("underrun6");
		return;
	} else if (cc >= 100) {
		warnx("overrun6");
		return;
	}
	if ((buf[0] != 12) || (buf[1] != 'P')) {
		warnx("bad6");
		return;
	}
	for (l = lans; l != NULL; l = l->next)
		if (memcmp(buf + 4, &l->addr, 4) == 0)
			break;
	if (l == NULL) {
		warnx("no lan");
		return;
	}
	memset(&to, 0, sizeof(to));
	to.sin_family = AF_INET;
	memcpy(&to.sin_port, buf + 2, 2);
	memcpy(&to.sin_addr, buf + 8, 4);
	cc -= 12;
	memmove(buf, buf + 12, cc);
	if (sendto(l->fd, buf, cc, 0, (struct sockaddr *) &to, sizeof(to)) < 0)
		warn("sendto");
}

int
main(int argc, char *argv[])
{
	struct lan *l;
	fd_set set;
	int opt, maxfd;
	char *local = NULL;
	extern char *optarg;
	extern int optind;

	while ((opt = getopt(argc, argv, "b:s:l:")) != -1)
		switch (opt) {
		case 'b':
			local = optarg;
			break;
		case 's':
			setserver(optarg, local);
			break;
		case 'l':
			setlan(optarg);
			break;
		default:
			errx(1, "usage: -b <local> -s <server> [-l <lan>]+");
		}
	if (optind != argc)
		errx(1, "extra arguments");
	if (sfd < 0)
		errx(1, "server is mandatory");
	if (lans == NULL)
		errx(1, "at least one lan is mandatory");

	for (;;) {
		FD_ZERO(&set);
		FD_SET(sfd, &set);
		maxfd = sfd;
		for (l = lans; l != NULL; l = l->next) {
			FD_SET(l->fd, &set);
			if (l->fd > maxfd)
				maxfd = l->fd;
		}
		if (select(maxfd + 1, &set, NULL, NULL, NULL) < 0)
			err(1, "select");
		if (FD_ISSET(sfd, &set))
			fromserver();
		for (l = lans; l != NULL; l = l->next)
			if (FD_ISSET(l->fd, &set))
				fromclient(l);
	}
	errx(1, "unreachable");
}
